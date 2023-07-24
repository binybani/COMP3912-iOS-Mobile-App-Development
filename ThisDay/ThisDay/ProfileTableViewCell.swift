//
//  ProfileTableViewCell.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImg: UIImage!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var moveButon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
