//
//  GroupListViewController.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-15.
//

import UIKit

class GroupListViewController: UITableViewCell {
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
