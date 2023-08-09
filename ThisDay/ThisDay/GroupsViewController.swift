//
//  GroupsViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-14.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftUI

struct GroupInfo {
    var groupName: String
    var description: String
    var peopleLimit: Int
    var groupId: String
    var eventTitle: String
    var startDate: String
    var endDate: String
    var pickedDate: String
    var eventNote: String
}

class GroupsViewController: UITableViewController {
    
    @IBOutlet weak var addGroupButton: UIButton!
    @IBOutlet var groupTableView: UITableView!
    
    var databaseRef: DatabaseReference = Database.database().reference()
    var groupData: [GroupInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
        fetchGroupData()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewGroupCreated), name: .newGroupCreated, object: nil)
    }

    @objc func handleNewGroupCreated() {
        fetchGroupData()
        groupTableView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .newGroupCreated, object: nil)
    }
    
    func fetchGroupData() {
        let databaseRef = Database.database().reference().child("groups")
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            if let groupsDict = snapshot.value as? [String: [String: Any]] {
                self.groupData.removeAll()
                
                for (groupId, groupInfo) in groupsDict {
                    if let groupName = groupInfo["name"] as? String,
                       let description = groupInfo["description"] as? String,
                       let peopleLimit = groupInfo["peopleLimit"] as? Int,
                       let eventInfo = groupInfo["event"] as? [String: String] {
                        
                        let eventTitle = eventInfo["eventName"] ?? ""
                        let startDate = eventInfo["startDate"] ?? ""
                        let endDate = eventInfo["endDate"] ?? ""
                        let pickedDate = eventInfo["pickedDate"] ?? ""
                        let eventNote = eventInfo["eventNote"] ?? ""

                        let groupItem = GroupInfo(
                            groupName: groupName,
                            description: description,
                            peopleLimit: peopleLimit,
                            groupId: groupId,
                            eventTitle: eventTitle,
                            startDate: startDate,
                            endDate: endDate,
                            pickedDate: pickedDate,
                            eventNote: eventNote
                        )
                        self.groupData.append(groupItem)
                    }
                }
                self.groupTableView.reloadData()
            }
        }
    }
    
    // Set header of section 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Groups"
    }
    
    @IBAction func addNewGroupAction(_ sender: Any) {
        addGroupButtonTapped()
    }
    // Add group method
    @objc func addGroupButtonTapped() {
        let newGroupView = UIHostingController(rootView: NewGroupView())
        newGroupView.modalPresentationStyle = .pageSheet
        present(newGroupView, animated: true, completion: nil)
    }
    
    // Delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupToDelete = groupData[indexPath.row]
            
            if let user = Auth.auth().currentUser {
                let userId = user.uid
                let groupIdToDelete = groupToDelete.groupId
                
                let groupRef = databaseRef.child("groups").child(groupIdToDelete)
                groupRef.removeValue { error, _ in
                    if let error = error {
                        print("Error deleting group: \(error)")
                    } else {
                        print("Group deleted successfully!")
                    }
                }
                
                groupData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGroupData()
        groupTableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupsTableViewCell
        let groupItem = groupData[indexPath.row]
        cell.groupName.text = groupItem.groupName
        cell.eventTitle.text = groupItem.eventTitle
        cell.dateLabel.text = !groupItem.pickedDate.isEmpty ? "Picked: \(groupItem.pickedDate)" : "\(groupItem.startDate) to \(groupItem.endDate)"
        return cell
    }
    
    // Set behaviour when selecting cells
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupItem = groupData[indexPath.row]
        print("Selected: \(groupItem)")

         if let groupInfoVC = storyboard?.instantiateViewController(withIdentifier: "groupInfoVCID") as? GroupInfoViewController {
            
             groupInfoVC.titleValue = "This Day"
             groupInfoVC.groupNameValue = groupItem.groupName
             groupInfoVC.eventTitleValue = groupItem.eventTitle
             groupInfoVC.groupId = groupItem.groupId
             groupInfoVC.startDateValue = groupItem.startDate
             groupInfoVC.endDateValue = groupItem.endDate
             groupInfoVC.pickedDateValue = groupItem.pickedDate

             navigationController?.pushViewController(groupInfoVC, animated: true)
         }
    }
}
