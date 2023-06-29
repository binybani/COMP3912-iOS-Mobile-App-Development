//
//  SignupViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-06-26.
//

import UIKit

class SignupViewController: UIViewController {
    
    var titleValue: String = ""
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var googleSignup: UIButton!
    @IBOutlet weak var faceboocSignup: UIButton!
    @IBOutlet weak var appleSignup: UIButton!
    @IBOutlet weak var logninButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleValue
    }
}
