//
//  MyAccountViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-19.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Elements for table view
    let items = ["Setting", "Friends", "Support", "Share", "About Us"]
    var databaseRef: DatabaseReference!
        
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
        logoutButton.layer.cornerRadius = 25
        editButton.layer.cornerRadius = 15
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profileTVCID")
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let userID = user.uid
        
        let userRef = databaseRef.child("users").child(userID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any] {
                    let userName = userData["name"] as? String ?? "N/A"
                    let userEmail = userData["email"] as? String ?? "N/A"
                    
                    DispatchQueue.main.async {
                        self.nameLabel.text = userName
                        self.emailLabel.text = userEmail
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
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
    
    // Set number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTVCID", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        // Add an accessory type to the cell (right arrow)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // Set behaviour when selecting cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        print("Selected: \(selectedItem)")
        // 선택된 항목에 따라 원하는 동작을 구현하세요.
        // 예를 들어, "Setting" 항목을 선택했을 때 설정 화면으로 이동하도록 구현할 수 있습니다.
    }
}
