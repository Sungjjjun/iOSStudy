//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by 박성준 on 2023/12/02.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    // @Published var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")
    let framework = CurrentValueSubject<AppleFramework, Never>(AppleFramework(name: "Unknown", imageName: "", urlString: "", description: ""))
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    var subscription = Set<AnyCancellable>()
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        // Input: Button Clicked(Framework -> URL -> Safari -> present)
        buttonTapped
            .receive(on: RunLoop.main)
            .compactMap { URL(string: $0.urlString) }
            .sink { [unowned self] url in
                let safari = SFSafariViewController(url: url)
                present(safari, animated: true)
            }
            .store(in: &subscription)
    
        // Output: UI Update
        framework
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
                iconImageView.image = UIImage(named: framework.imageName)
                nameLabel.text = framework.name
                descriptionLabel.text = framework.description
            }
            .store(in: &subscription)
    }
    
    @IBAction func onTappedLearnMore(_ sender: Any) {
        buttonTapped.send(framework.value)
    }
}
