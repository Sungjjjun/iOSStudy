import UIKit

class BannerCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    func configure(_ banner: BannerInfo) {
        titleLabel.text = banner.title
        contentLabel.text = banner.description
        iconImageView.image = UIImage(named: banner.imageName)
    }
}
