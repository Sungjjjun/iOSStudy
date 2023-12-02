//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by 박성준 on 2023/12/02.
//

import UIKit
import SafariServices

class FrameworkDetailViewController: UIViewController {
    var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        iconImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    
    @IBAction func onTappedLearnMore(_ sender: Any) {
        guard let url = URL(string: framework.urlString) else {
            return
        }
        
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}
