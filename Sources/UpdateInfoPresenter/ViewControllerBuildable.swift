//
//  ViewControllerBuildable.swift
//  UpdateInfoPresenter
//
//  Created by Koji Murata on 2020/10/12.
//

import UIKit

public protocol ViewControllerBuildable {
    associatedtype VersionType: Version
    
    func build(previous: VersionType?, current: VersionType) -> UIViewController
}
