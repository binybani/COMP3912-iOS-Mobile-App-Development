//
//  GroupsTableViewCell.swift
//  ThisDay
//
//  Created by Yubin Kim on 2023-07-15.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupNote: UILabel!
    
    let margin: CGFloat = 10.0 // 마진 크기를 설정

    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContentView() {
        // contentView에 보더 추가
//        contentView.layer.borderWidth = 1.0
//        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        // contentView에 라운드 코너 추가
        contentView.layer.cornerRadius = 8.0 // 적절한 값을 설정하여 원하는 라운드 코너 크기를 지정합니다.

        // contentView에 그림자 추가
        contentView.layer.cornerRadius = 8.0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4.0
        contentView.clipsToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // contentView의 위치와 크기를 조정하여 마진을 추가
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))

        // 각 서브뷰들의 위치를 조정
//        startDate.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 20)
//        groupName.frame = CGRect(x: 0, y: startDate.frame.maxY + 5, width: contentView.bounds.width, height: 20)
//        groupNote.frame = CGRect(x: 0, y: groupName.frame.maxY + 5, width: contentView.bounds.width, height: contentView.bounds.height - groupName.frame.maxY - 5)
    }

}
