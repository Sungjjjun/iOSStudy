//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/22.
//

import Foundation

struct MyPoint: Hashable {
    var point: Int
}

extension MyPoint {
    static let `default` = MyPoint(point: 0)
}
