//
//  SignupViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-06-26.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin

class SignupViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfrimTF: UITextField!
    
    @IBOutlet weak var confirmPasswordLable: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var googleSignupButton: GIDSignInButton!
    @IBOutlet weak var facebookSignupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var titleValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        //Connect the delegate and data source for the text fields - needed for validation
        emailTF.delegate = self
        emailTF.layer.cornerRadius = 25
        emailTF.clipsToBounds = true
        
        passwordTF.delegate = self
        passwordTF.isSecureTextEntry = true
        passwordTF.layer.cornerRadius = 25
        passwordTF.clipsToBounds = true
        
        passwordConfrimTF.delegate = self
        passwordConfrimTF.isSecureTextEntry = true
        passwordConfrimTF.layer.cornerRadius = 25
        passwordConfrimTF.clipsToBounds = true
        
        loginButton.layer.cornerRadius = 25
        signupButton.layer.cornerRadius = 25
        
        // Set the initial text of the password-matching label to empty
        confirmPasswordLable.text = ""
        
        // Google button
        // Create Google Sign In button
        let googleSignupButton = GIDSignInButton()
        googleSignupButton.style = .wide
        googleSignupButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignupButton.frame = googleSignupButton.bounds
        view.addSubview(googleSignupButton)
        
        // Add constraints to position the button
        NSLayoutConstraint.activate([
            googleSignupButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            googleSignupButton.bottomAnchor.constraint(equalTo: facebookSignupButton.topAnchor, constant: -20),
            googleSignupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            googleSignupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39),
            googleSignupButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        googleSignupButton.addTarget(self, action: #selector(googleSignup), for: .touchUpInside)

//        googleSignupButton.addSubview(googleSignupButton)

        // Add shadow
        googleSignupButton.layer.shadowColor = UIColor.black.cgColor
        googleSignupButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        googleSignupButton.layer.shadowOpacity = 0.5
        googleSignupButton.layer.shadowRadius = 4
        googleSignupButton.layer.masksToBounds = false
        
        
        // facebool login button text chagne
        facebookSignupButton.setTitle(" Sign up Facebook", for: .normal)
        
        // Add shadow
        facebookSignupButton.layer.shadowColor = UIColor.black.cgColor
        facebookSignupButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        facebookSignupButton.layer.shadowOpacity = 0.5
        facebookSignupButton.layer.shadowRadius = 4
        facebookSignupButton.layer.masksToBounds = false
        
        // Facebook login: only one user can login per one time
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
        
    }
    
    @IBAction func googleSignup(_ sender: GIDSignInButton) {
        // Google auth
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                // At this point, our user is signed in
                if let error = error {
                    print(error)
                } else {
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVCID") as! HomeViewController
                    homeVC.titleValue = "Home"
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
    }
    
@IBAction func facebookSignup(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: nil) { result, error in
            if let error = error {
                print("Facebook login failed. Error: \(error.localizedDescription)")
            } else if result?.isCancelled == true {
                print("Facebook login is cancelled.")
            } else {
                guard let token = AccessToken.current?.tokenString else {
                    print("Failed to get Facebook access token.")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("Login failed. Error: \(error.localizedDescription)")
                    } else if let user = authResult?.user {
//                        if let email = user.email {
//                            // Do something with the email
//                        }
//                        if let displayName = user.displayName {
//                            // Do something with the display name
//                        }
//                        if let uid = user.uid {
//                            // Do something with the UID
//                        }
//                        if let photoURL = user.photoURL {
//                            // Do something with the photo URL
//                        }
                    }
                }
            }
        }
    }

    
    
    @IBAction func loginAction(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginVCID") as! LoginViewController
        loginVC.titleValue = "Log In"
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        guard let userEmail = emailTF.text,
              let userPassword = passwordTF.text,
              let userPasswordConfirm = passwordConfrimTF.text else {
            return
        }
        
        func simpleAlert(_ controller: UIViewController, message: String) {
            let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            controller.present(alertController, animated: true, completion: nil)
        }
        
        func simpleAlert(_ controller: UIViewController, message: String, title: String, handler: ((UIAlertAction) -> Void)?) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: handler)
            alertController.addAction(alertAction)
            controller.present(alertController, animated: true, completion: nil)
        }
        
        guard userPassword != ""
                && userPasswordConfirm != ""
                && userPassword == userPasswordConfirm else {
            simpleAlert(self, message: "Passwords do not match.")
            return
        }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) {
            [self] authResult, error in
            // 이메일, 비밀번호 전송
            guard let user = authResult?.user, error == nil else {
                simpleAlert(self, message: error!.localizedDescription)
                return
            }
        
            simpleAlert(self, message: "\(user.email!)'s registration is complete.", title: "OK") { action in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SignupViewController: UITextFieldDelegate {

    func setLabelPasswordConfirm(_ password: String, _ passwordConfirm: String) {
        // Checking if the user entered a password or not
        guard passwordConfirm != "" else {
            confirmPasswordLable.text = ""
            return
        }
        
        // Checking if the user-entered password matches or not
        if password == passwordConfirm {
            confirmPasswordLable.textColor = .green
            confirmPasswordLable.text = "Password Match."
        } else {
            confirmPasswordLable.textColor = .red
            confirmPasswordLable.text = "Password Do Not Match."
        }
    }
    
    // Move to next text field when the user touch the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTF:
            passwordTF.becomeFirstResponder()
        case passwordTF:
            passwordConfrimTF.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordConfrimTF {
            guard let password = passwordTF.text,
                  let passwordConfirmBefore = passwordConfrimTF.text else {
                return true
            }
            
            let passwordConfirm = string.isEmpty ? String(passwordConfirmBefore.prefix(passwordConfirmBefore.count)) : passwordConfirmBefore + string

//            let passwordConfirm = string.isEmpty ? passwordConfirmBefore[0..<(passwordConfirmBefore.count - 1)] : passwordConfirmBefore + string
            setLabelPasswordConfirm(password, passwordConfirm)
            
        }
        return true
    }
}
