//
//  OnboardingCollectionViewCell.swift
//  NRCOnboarding
//
//  Created by 박성준 on 2023/11/29.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ message: OnboardingMessage) {
        thumbImageView.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        descriptionLabel.text = message.description
    }
}
