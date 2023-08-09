//
//  GroupInfoViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-20.
//

import UIKit
import FSCalendar
import Firebase
import FirebaseDatabase
import SwiftUI

class GroupInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource{
    
    var titleValue: String = ""
    var groupNameValue: String = ""
    var eventTitleValue: String = ""
    var noteValue: String = ""
    var startDateValue: String = ""
    var endDateValue: String = ""
    var pickedDateValue: String = ""
    var databaseRef: DatabaseReference!
    var groupId: String = ""
    var friendsData: [(uid: String, name: String, color: UIColor, memberPickDates: [[String: String]])] = []
    var groups: [String: [String: Any]] = [:]
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var pickAllDate: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 255/255, alpha: 1)
        calendarView.allowsMultipleSelection = true
        calendarView.swipeToChooseGesture.isEnabled = true
        // 타이틀 컬러
        calendarView.appearance.titleSelectionColor = .black
        // 서브 타이틀 컬러
        calendarView.appearance.subtitleSelectionColor = .black
        
        title = titleValue
        groupNameLabel.text = groupNameValue
        eventTitleLabel.text = eventTitleValue
        dateLabel.text =  !pickedDateValue.isEmpty ? "Picked: \(pickedDateValue)" : "\(startDateValue) to \(endDateValue)"
        pickAllDate.text =  !pickedDateValue.isEmpty ? "Explore a variety of activities!" : "Pick all your available dates!"

        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "friendsListTVCID")
        // Init Firebase
        databaseRef = Database.database().reference()
        fetchMembersData()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // Refresh the calendar when the current page (month) changes
        calendarView.reloadData()
    }

    
    // Fetch selected group's members data from Firebase
    func fetchMembersData() {
        let groupMembersRef = Database.database().reference().child("groups").child(groupId).child("members")
        
        groupMembersRef.observeSingleEvent(of: .value) { snapshot,arg  in
            guard let membersDict = snapshot.value as? [String: [String: Any]] else {
                return
            }

            for (memberUID, memberData) in membersDict {
                if let colorData = memberData["color"] as? [String: CGFloat] {
                    let red = colorData["red"] ?? 0
                    let green = colorData["green"] ?? 0
                    let blue = colorData["blue"] ?? 0
                    let color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
                    
                    var memberPickDates: [[String: String]] = []
                    if let memberPickDatesData = memberData["memberPickDates"] as? [[String: String]] {
                        memberPickDates = memberPickDatesData
                    }
                    
                    // Add the friend data to the friendsData array
                    self.friendsData.append((uid: memberUID, name: "", color: color, memberPickDates: memberPickDates))
                }
            }
            
            // Now that friendsData is updated, fetch and set member names
            self.fetchAndSetMemberNames()
            
            // Reload table view and calendar
            self.friendsTableView.reloadData()
            self.calendarView.reloadData()
        }
    }
    
    // Fetch and set member names using their UIDs
    func fetchAndSetMemberNames() {
        let dispatchGroup = DispatchGroup()
        
        for (index, friend) in friendsData.enumerated() {
            dispatchGroup.enter()
            let userRef = databaseRef.child("users").child(friend.uid)
            
            userRef.observeSingleEvent(of: .value) { snapshot in
                if let userData = snapshot.value as? [String: Any],
                   let name = userData["name"] as? String {
                    self.friendsData[index].name = name // Update member name
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {

            self.friendsTableView.reloadData() // Reload table view after updating member names
        }
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if !pickedDateValue.isEmpty {
            if dateString == pickedDateValue {
                return "Picked!"
            }
        } else if let startDate = dateFormatter.date(from: startDateValue),
                  let endDate = dateFormatter.date(from: endDateValue),
                  date >= startDate && date <= endDate,
                  friendsData.contains(where: { $0.memberPickDates.contains(where: { $0["date"] == dateString }) }) {
            
            var selectedMembers: [String] = []
            for memberData in friendsData {
                if memberData.memberPickDates.contains(where: { $0["date"] == dateString }) {
                    selectedMembers.append(memberData.name)
                }
            }
            return selectedMembers.joined(separator: ", ")
        }
        
        return nil
    }

    
    // FSCalendarDelegate method: called when a date is selected
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDateString = dateFormatter.string(from: date)

        if let user = Auth.auth().currentUser {
            let userId = user.uid

            let groupMembersRef = databaseRef.child("groups").child(groupId).child("members").child(userId)
            groupMembersRef.observeSingleEvent(of: .value) { snapshot in
                if var memberData = snapshot.value as? [String: Any] {
                    if var memberPickDates = memberData["memberPickDates"] as? [[String: String]] {
                        // Check if a date has already been selected and add it
                        if !memberPickDates.contains(where: { $0["date"] == selectedDateString }) {
                            memberPickDates.append(["date": selectedDateString])
                            memberData["memberPickDates"] = memberPickDates
                            snapshot.ref.setValue(memberData)
                        }
                    } else {
                        // Create and append array if first selected date
                        let memberPickDates = [["date": selectedDateString]]
                        memberData["memberPickDates"] = memberPickDates
                        snapshot.ref.setValue(memberData)
                    }
                }
            }
        }
    }

    // FSCalendar delegate method: called when date selection is cleared
     func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let deselectedDateString = dateFormatter.string(from: date)

         if let user = Auth.auth().currentUser {
             let userId = user.uid

             let groupMembersRef = databaseRef.child("groups").child(groupId).child("members").child(userId)
             groupMembersRef.observeSingleEvent(of: .value) { snapshot in
                 if var memberData = snapshot.value as? [String: Any],
                    var memberPickDates = memberData["memberPickDates"] as? [[String: String]] {
                     memberPickDates.removeAll { $0["date"] == deselectedDateString }
                     memberData["memberPickDates"] = memberPickDates
                     snapshot.ref.setValue(memberData)
                 }
             }
         }
     }
        
    // Set header of section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Friends' Label"
    }
    // Set number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsListTVCID", for: indexPath)
        let friend = friendsData[indexPath.row]

        cell.textLabel?.text = friend.name
        cell.backgroundColor = friend.color
        
        return cell
    }
    
    // Set behaviour when selecting cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = friendsData[indexPath.row]
        print("Selected: \(selectedItem)")

    }
}
extension GroupInfoViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if dateString == pickedDateValue {
            return UIColor.black // Set the desired text color for the picked date
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if dateString == pickedDateValue {
            return UIColor.yellow // Set the desired background color for the picked date
        }
        
        return nil
    }
}
