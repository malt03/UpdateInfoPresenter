//
//  UpdateInfoViewController.swift
//  Example
//
//  Created by Koji Murata on 2020/10/12.
//

import UIKit
import UpdateInfoPresenter

final class UpdateInfoViewController: UIViewController {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UpdateInfoPresenter.dismiss()
    }
}
