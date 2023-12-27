//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/27.
//

import Foundation
import Combine

final class ButtonBenefitViewModel {
    @Published var benefit: Benefit = .today
    @Published var benefitDetials: BenefitDetails?
    
    init(benefit: Benefit, benefitDetials: BenefitDetails? = nil) {
        self.benefit = benefit
        self.benefitDetials = benefitDetials
    }
    
    func fetchDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.benefitDetials = .default
        }
    }
}
