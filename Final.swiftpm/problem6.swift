//
//  problem6.swift
//  Final
//
//  Created by Yubin Kim on 2023-07-29.
//

import Foundation

private var myViewController: LoginViewController = {

    guard myViewController = UIStoryboard.myStoryboard.instantiateViewController(withIdentifier: LoginViewController.storyboardIdentifier) as LoginViewController else {
        fatalError("Wrong View Controller")
    }

    myViewController.doLogin = { in
        self.modifyView()
    }

    return myViewController
}()
