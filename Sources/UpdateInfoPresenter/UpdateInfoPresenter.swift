//
//  UpdateInfoPresenter.swift
//  UpdateInfoPresenter
//
//  Created by Koji Murata on 2020/10/12.
//

import UIKit

public final class UpdateInfoPresenter<ViewControllerBuilder: ViewControllerBuildable> {
    private var window: UIWindow?
    
    public init(viewControllerBuilder: ViewControllerBuilder) {
        let savedVersionValue = UserDefaults.standard.string(forKey: Keys.version)
        let currentVersionValue = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        if savedVersionValue == currentVersionValue { return }
        let savedVersion = savedVersionValue.map { ViewControllerBuilder.VersionType(bundleVersion: $0) }
        let currentVersion = ViewControllerBuilder.VersionType(bundleVersion: currentVersionValue)
        let viewController = viewControllerBuilder.build(previous: savedVersion, current: currentVersion)
        let window = UIWindow()
        self.window = window
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
