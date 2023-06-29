//
//  ViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-06-26.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        loginButton.layer.cornerRadius = 50
//        signupButton.layer.cornerRadius = 50
//
//        loginButton.layer.shadowColor = UIColor.gray.cgColor
//        loginButton.layer.shadowOpacity = 1
//
//        signupButton.layer.shadowColor = UIColor.gray.cgColor
//        signupButton.layer.shadowOpacity = 1

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
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! LoginViewController
//        destinationVC.titleValue = "Sign Up"
//    }
}

