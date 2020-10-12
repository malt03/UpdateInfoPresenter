//
//  ViewController.swift
//  Example
//
//  Created by Koji Murata on 2020/10/12.
//

import UIKit

class ViewController: UIViewController {

    let ww = UIWindow(frame: UIScreen.main.bounds)

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ww.windowLevel = .alert
        ww.rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "UpdateInfo")
        ww.backgroundColor = .yellow
        ww.makeKeyAndVisible()
        print(ww)
    }
}

