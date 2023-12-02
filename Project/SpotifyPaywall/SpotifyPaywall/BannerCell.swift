import UIKit

class BannerCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    func configure(_ banner: BannerInfo) {
        titleLabel.text = banner.title
        contentLabel.text = banner.description
        iconImageView.image = UIImage(named: banner.imageName)
    }
}
