//
//  LoginViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-06-27.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var titleValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        emailTF.layer.cornerRadius = 25
        emailTF.clipsToBounds = true

        passwordTF.layer.cornerRadius = 25
        passwordTF.clipsToBounds = true

        loginButton.layer.cornerRadius = 25
        signupButton.layer.cornerRadius = 25
        
        // Google button
        let googleLoginButton = GIDSignInButton()
        googleLoginButton.style = .wide
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        googleLoginButton.frame = googleLoginButton.bounds
        view.addSubview(googleLoginButton)

        // Add constraints to position the button
        NSLayoutConstraint.activate([
            googleLoginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            googleLoginButton.bottomAnchor.constraint(equalTo: facebookLoginButton.topAnchor, constant: -20),
            googleLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            googleLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        googleLoginButton.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        
        // Add shadow
        googleLoginButton.layer.shadowColor = UIColor.black.cgColor
        googleLoginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        googleLoginButton.layer.shadowOpacity = 0.5
        googleLoginButton.layer.shadowRadius = 4
        googleLoginButton.layer.masksToBounds = false
        
        // facebook login button text chagne
        facebookLoginButton.setTitle("  Sign in Facebook", for: .normal)
        
        // Add shadow
        facebookLoginButton.layer.shadowColor = UIColor.black.cgColor
        facebookLoginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        facebookLoginButton.layer.shadowOpacity = 0.5
        facebookLoginButton.layer.shadowRadius = 4
        facebookLoginButton.layer.masksToBounds = false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let e = error {
                    print(e)
                } else {
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVCID") as! HomeViewController
                    homeVC.titleValue = "Home"
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func googleLogin(_ sender: GIDSignInButton) {
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
    
    @IBAction func facebookLogin(_ sender: UIButton) {
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

    
    @IBAction func signupAction(_ sender: Any) {
        let signupVC = storyboard?.instantiateViewController(withIdentifier: "signupVCID") as! SignupViewController
        signupVC.titleValue = "Sign Up"
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}

