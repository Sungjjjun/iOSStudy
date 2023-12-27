//
//  MyPointViewModel.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/27.
//

import Foundation
import Combine

final class MyPointViewModel {
    @Published var point: MyPoint = .default
    
    init(point: MyPoint) {
        self.point = point
    }
}
