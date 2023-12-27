//
//  ButtonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/26.
//

import UIKit
import Combine

class ButtonBenefitViewController: UIViewController {
    
    var viewModel: ButtonBenefitViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet var ctaButton: UIButton!
    @IBOutlet var vStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.fetchDetails()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 5
    }
    
    private func bind() {
        viewModel.$benefit
            .receive(on: RunLoop.main)
            .sink { benefit in
                self.ctaButton.setTitle(benefit.ctaTitle, for: .normal)
            }.store(in: &subscriptions)
        
        viewModel.$benefitDetials
            .compactMap{ $0 }
            .receive(on: RunLoop.main)
            .sink { details in
                self.addGuides(details: details)
            }.store(in: &subscriptions)
    }
    
    private func addGuides(details: BenefitDetails) {
        // 만약 이미 GuideView가 있는 상태면 return(실행하지 않는다.)
        let guideView = vStackView.arrangedSubviews.filter { $0 is BenefitGuideView }
        guard guideView.isEmpty else { return }
        
        let guideViews: [BenefitGuideView] = details.guides.map { guide in
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
