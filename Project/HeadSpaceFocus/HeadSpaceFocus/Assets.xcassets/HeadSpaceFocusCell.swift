//
//  HeadSpaceFocusCell.swift
//  HeadSpaceFocus
//
//  Created by 박성준 on 2023/11/30.
//

import UIKit

class HeadSpaceFocusCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    func configure(_ focus: Focus) {
        titleLabel.text = focus.title
        contentLabel.text = focus.title
        weatherImageView.image = UIImage(systemName: focus.imageName)
    }
}
