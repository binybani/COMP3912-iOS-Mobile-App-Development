//
//  HomeViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-05.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    var titleValue: String = ""
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            // Move to the login screen when successfully logout.
            navigateToLoginScreen()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    // Move to the login screen
    private func navigateToLoginScreen() {
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginVCID") as? LoginViewController {
            loginVC.titleValue = "Log In"
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }
}
