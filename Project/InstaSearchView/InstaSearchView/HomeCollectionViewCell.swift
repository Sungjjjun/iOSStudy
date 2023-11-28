//
//  HomeCollectionViewCell.swift
//  InstaSearchView
//
//  Created by 박성준 on 2023/11/28.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var animalImageView: UIImageView!
    func configure(_ image: String) {
        animalImageView.image = UIImage(named: image)
    }
}
