//
//  ViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-06-26.
//

import UIKit
import Firebase
import GoogleSignIn
//import FacebookLogin

class ViewController: UIViewController {
    var window: UIWindow?

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 25
        signupButton.layer.cornerRadius = 25
        if let user = Auth.auth().currentUser {
            // Go to home view controller if there is a logged in user
            let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            tabBarController.title = "This Day"
            self.navigationController?.pushViewController(tabBarController, animated: true)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SignupViewController
        destinationVC.titleValue = "Sign Up"
    }
    
    @IBAction func loginAction(_ sender: Any) {
   
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginVCID") as! LoginViewController
        loginVC.titleValue = "Log In"
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

