//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by 박성준 on 2023/12/04.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    var content: QuickFocus = QuickFocus(title: "No Content", description: "", imageName: "")
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var decriptionLabel: UILabel!
    
    func configure(_ focus: QuickFocus) {
        imageView.image = UIImage(named: focus.imageName)
        titleLabel.text = focus.title
        decriptionLabel.text = focus.description
    }
}
