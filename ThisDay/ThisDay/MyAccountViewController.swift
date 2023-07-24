//
//  MyAccountViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-19.
//

import UIKit
import Firebase

class MyAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 테이블뷰에 표시될 항목들을 배열로 저장
    let items = ["Setting", "Friends", "Support", "Share", "About Us"]
        
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
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
    // 섹션 수 설정
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          cell.textLabel?.text = items[indexPath.row]
          return cell
    }
    // 셀 선택 시 동작 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        print("선택된 항목: \(selectedItem)")
        // 선택된 항목에 따라 원하는 동작을 구현하세요.
        // 예를 들어, "Setting" 항목을 선택했을 때 설정 화면으로 이동하도록 구현할 수 있습니다.
    }
}
