//
//  Version.swift
//  UpdateInfoPresenter
//
//  Created by Koji Murata on 2020/10/12.
//

import Foundation

public protocol Version: Comparable {
    init(bundleVersion: String)
}

extension Int: Version {
    public init(bundleVersion: String) {
        guard let value = Int(bundleVersion) else {
            fatalError("failed to convert bundleVersion \(bundleVersion)!")
        }
        self = value
    }
}
