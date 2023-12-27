//
//  BenefitListViewModel.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/27.
//

import Foundation
import Combine

final class BenefitListViewModel {
    @Published var todaySectionItems: [AnyHashable] = []
    @Published var otherSectionItems: [AnyHashable] = []
    
    let benefitDidTapped = PassthroughSubject<Benefit, Never>()
    let pointDidTapped = PassthroughSubject<MyPoint, Never>()
    
    // Network를 통해 데이터를 받는 상황을 구현
    // TodaySectionItem은 약 0.5초의 Delay
    // OtherSectionItems은 약 2.5초의 Delay
    func fetchItem() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.todaySectionItems = TodaySectionItem(point: .default, today: .today).sectionItems
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.otherSectionItems = Benefit.others
        }
    }
}
