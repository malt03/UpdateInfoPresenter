//
//  UpdateInfoPresenter.swift
//  UpdateInfoPresenter
//
//  Created by Koji Murata on 2020/10/12.
//

import UIKit

private var holder: Any?

public final class UpdateInfoPresenter {
    private var window: UIWindow?
    
    public struct PresentOption: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let empty = PresentOption([])
        public static let newUser = PresentOption(rawValue: 1 << 0)
        public static let skippedUser = PresentOption(rawValue: 1 << 1)
        
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
        presentOption: PresentOption,
        viewController: @autoclosure () -> UIViewController
    ) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeVisibleNotification),
            name: UIWindow.didBecomeVisibleNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeKeyNotification),
            name: UIWindow.didBecomeKeyNotification,
            object: nil
        )
        
        let previousVersionValue = UserDefaults.standard.string(forKey: Keys.version)
        let currentVersionValue = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.setValue(currentVersionValue, forKey: Keys.version)
        
        let previousVersion = previousVersionValue.map { VersionType(bundleVersion: $0) }
        let currentVersion = VersionType(bundleVersion: currentVersionValue)
        
        if !presentOption.needsPresent(target: targetVersion, previous: previousVersion, current: currentVersion) { return }
        
        let window = UIWindow()
        window.backgroundColor = .red
        window.rootViewController = viewController()
        self.window = window
    }
    
    private static var window: UIWindow?
    
    @objc static private func didBecomeVisibleNotification() {
        print("didBecomeVisibleNotification")
    }
    
    @objc static private func didBecomeKeyNotification() {
        print(window)
        window?.makeKeyAndVisible()
    }
}
