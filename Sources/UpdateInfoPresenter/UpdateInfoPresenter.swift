//
//  UpdateInfoPresenter.swift
//  UpdateInfoPresenter
//
//  Created by Koji Murata on 2020/10/12.
//

import UIKit

public final class UpdateInfoPresenter {
    public struct PresentingOption: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let empty = PresentingOption([])
        public static let newUser = PresentingOption(rawValue: 1 << 0)
        public static let skippedUser = PresentingOption(rawValue: 1 << 1)
        
        fileprivate func needsPresent<VersionType: Version>(target: VersionType, previous: VersionType?, current: VersionType) -> Bool {
            if current < target { return false }
            if current > target && !contains(.skippedUser) { return false }
            guard let previous = previous else { return contains(.newUser) }
            if previous >= target { return false }
            return true
        }
    }
    
    public static func configure<VersionType: Version>(
        targetVersion: VersionType,
        presentingOption: PresentingOption,
        viewController: @escaping @autoclosure () -> UIViewController,
        forcePresent: Bool = false
    ) {
        let previousVersionValue = UserDefaults.standard.string(forKey: Keys.version)
        let currentVersionValue = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.setValue(currentVersionValue, forKey: Keys.version)
        
        let previousVersion = previousVersionValue.map { VersionType(bundleVersion: $0) }
        let currentVersion = VersionType(bundleVersion: currentVersionValue)
        
        if !forcePresent && !presentingOption.needsPresent(target: targetVersion, previous: previousVersion, current: currentVersion) { return }
        
        func addObserverForWindowDidBocmeKey() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(windowDidBecomeKey),
                name: UIWindow.didBecomeKeyNotification,
                object: nil
            )
        }
        if #available(iOS 13.0, *) {
            if Bundle.main.object(forInfoDictionaryKey: "UIApplicationSceneManifest") != nil {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(sceneDidActivate),
                    name: UIScene.didActivateNotification,
                    object: nil
                )
            } else {
                addObserverForWindowDidBocmeKey()
            }
        } else {
            addObserverForWindowDidBocmeKey()
        }
        
        self.viewController = viewController
    }
    
    public static func dismiss() {
        window = nil
    }
    
    private static var viewController: (() -> UIViewController)?
    private static var window: UIWindow?
    
    @available(iOS 13.0, *)
    @objc static private func sceneDidActivate() {
        guard let scene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) else { return }
        presentUpdateInfo(on: UIWindow(windowScene: scene))
    }
    
    @objc static private func windowDidBecomeKey() {
        presentUpdateInfo(on: UIWindow(frame: UIScreen.main.bounds))
    }
    
    private static func presentUpdateInfo(on window: UIWindow) {
        NotificationCenter.default.removeObserver(self)
        guard let viewController = viewController else { return }
        window.rootViewController = viewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
