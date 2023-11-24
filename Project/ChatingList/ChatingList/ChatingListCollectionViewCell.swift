//
//  ChatingListCollectionViewCell.swift
//  ChatingList
//
//  Created by 박성준 on 2023/11/24.
//

import UIKit

class ChatingListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(_ chat: Chat) {
        profileImageView.image = UIImage(named: chat.name)
        nameLabel.text = chat.name
        messageLabel.text = chat.chat
        dateLabel.text = chat.date
    }
}
