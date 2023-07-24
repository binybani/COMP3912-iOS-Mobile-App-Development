//
//  GroupsViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-14.
//

import UIKit


class GroupsViewController: UITableViewController {
    
    @IBOutlet weak var addGroupButton: UIButton!
    @IBOutlet var groupTableView: UITableView!
    
    var data = [
        (date: "Sep 5, Sunday 12:00-15:00", name: "Uni friends", note: "The Keg Steakhouse + Bar - Dunsmuir"),
        (date: "Sep 6, Monday 14:00-17:00", name: "Workout member", note: "Gym session"),
        (date: "Sep 7, Tuesday 19:00-22:00", name: "Party Friends", note: "Club night"),
        (date: "Sep 8, Wednesday 19:00-22:00", name: "Workout membe", note: "We will do the legs and back workou"),
        (date: "Sep 9, Thursday 19:00-22:00", name: "Group 1 ", note: "ABCDEF"),
        (date: "Sep 10, Friday 19:00-22:00", name: "Group 2", note: "GHIJKLM"),
        (date: "Sep 11, Saturday 19:00-22:00", name: "Group 3", note: "OPQRSTU"),
        (date: "Sep 12, Suunday 19:00-22:00", name: "Group 4", note: "VWXYZ"),
        (date: "Sep 13, Monday 19:00-22:00", name: "Group 5", note: "TMI"),
        (date: "Sep 14, Tuesday 19:00-22:00", name: "Group 6", note: "Chat"),
        (date: "Sep 15, Wednesday 19:00-22:00", name: "Group 7", note: "Drink night"),
        (date: "Sep 16, Thursday 19:00-22:00", name: "Group 8", note: "Talk night")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    
    // Set header of section 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Groups"
    }
    
    // 그룹 추가 버튼 액션 메서드
    @objc func addGroupButtonTapped() {
        // 그룹을 추가하는 로직을 구현합니다.
        // 예를 들어, 그룹을 추가하는 팝업이나 뷰컨트롤러를 띄우는 등의 동작을 수행할 수 있습니다.
    }
    
    // 셀 삭제를 허용하는 메서드 구현
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 데이터 배열에서 항목 삭제
            data.remove(at: indexPath.row)

            // 테이블뷰에서도 삭제하도록 애니메이션과 함께 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupTableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupsTableViewCell
        // Bring the info to display the cell from the data source array
        let item = data[indexPath.row]
        // Configure the cell...
        cell.startDate.text = item.date
        cell.groupName.text = item.name
        cell.groupNote.text = item.note

        return cell
    }
    
    

}
