//
//  ButtonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/26.
//

import UIKit

class ButtonBenefitViewController: UIViewController {
    
    var benefit: Benefit = .today
    var benefitDetials: BenefitDetails = .default

    @IBOutlet var ctaButton: UIButton!
    @IBOutlet var vStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGuides()
        ctaButton.setTitle(benefit.ctaTitle, for: .normal)
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 5
    }
    
    private func addGuides() {
        let guideViews: [BenefitGuideView] = benefitDetials.guides.map { guide in
            let guideView = BenefitGuideView(frame: .zero)
            guideView.icon.image = UIImage(systemName: guide.iconName)
            guideView.title.text = guide.guide
            return guideView
        }
        
        guideViews.forEach { view in
            self.vStackView.addArrangedSubview(view)
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
}
