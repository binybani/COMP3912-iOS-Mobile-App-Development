//
//  GroupsTableViewCell.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-15.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var eventTitle: UILabel!

    
    let margin: CGFloat = 10.0

    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContentView() {
        
        // Add round corner
        contentView.layer.cornerRadius = 8.0

        // Add Shadow
        contentView.layer.cornerRadius = 8.0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4.0
        contentView.clipsToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Add margin
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
    }

}
