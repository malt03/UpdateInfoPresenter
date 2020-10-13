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
    
    public static func presentIfNeeded<VersionType: Version>(
        viewController: @autoclosure () -> UIViewController?,
        targetVersion: VersionType,
        presentingOption: PresentingOption,
        forcePresent: Bool = false
    ) {
        let previousVersionValue = UserDefaults.standard.string(forKey: Keys.version)
        let currentVersionValue = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.setValue(currentVersionValue, forKey: Keys.version)
        
        let previousVersion = previousVersionValue.map { VersionType(bundleVersion: $0) }
        let currentVersion = VersionType(bundleVersion: currentVersionValue)
        
        if !forcePresent && !presentingOption.needsPresent(target: targetVersion, previous: previousVersion, current: currentVersion) { return }
        guard let viewController = viewController() else { return }

        let window: UIWindow
        if #available(iOS 13.0, *) {
            if
                let scene = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first(where: { $0.activationState == .foregroundActive })
            {
                window = UIWindow(windowScene: scene)
            } else {
                window = UIWindow(frame: UIScreen.main.bounds)
            }
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    public static func dismiss() {
        window = nil
    }
    
    private static var window: UIWindow?
}
