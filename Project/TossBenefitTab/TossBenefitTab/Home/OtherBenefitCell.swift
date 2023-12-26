//
//  OtherBenefitCell.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/22.
//

import UIKit

class OtherBenefitCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    func configure(item: Benefit) {
        imageView.image = UIImage(named: item.imageName)
        descriptionLabel.text = item.description
        titleLabel.text = item.title
    }
}
