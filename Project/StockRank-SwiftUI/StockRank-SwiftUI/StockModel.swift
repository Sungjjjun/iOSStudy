//
//  StockModel.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import Foundation

struct StockModel: Hashable, Identifiable{
    
    // 각 요소들을 구분할 수 있는 정보로 ID 지정 (Unique Value)
    var id: String {
        return name
    }
    
    // 랜덤 값으로 고유 아이디 생성 (보통 사용하는 방법)
    // var id: UUID = UUID()
    
    let rank: Int
    let imageName: String
    let name: String
    let price: Int
    let diff: Double
    var isFavorite: Bool = false
}

extension StockModel {
    static let list: [StockModel] = [
        StockModel(rank: 1, imageName: "TSLA", name: "테슬라", price: 1_238_631, diff: 0.04),
        StockModel(rank: 2, imageName: "AAPL", name: "애플", price: 238_631, diff: 1.04),
        StockModel(rank: 3, imageName: "NFLX", name: "넷플릭스", price: 438_631, diff: -0.04),
        StockModel(rank: 4, imageName: "GOOG", name: "알파벳 A", price: 3_176_631, diff: 0.04),
        StockModel(rank: 5, imageName: "AMZN", name: "아마존", price: 3_538_631, diff: 0.04),
        StockModel(rank: 6, imageName: "NIKE", name: "나이키", price: 158_631, diff: 0.04),
        StockModel(rank: 7, imageName: "DIS", name: "디즈니", price: 138_631, diff: 0.04),
        StockModel(rank: 8, imageName: "TSLA", name: "테슬라", price: 1_238_631, diff: 0.04),
        StockModel(rank: 9, imageName: "AAPL", name: "애플", price: 238_631, diff: 1.04),
        StockModel(rank: 10, imageName: "NFLX", name: "넷플릭스", price: 438_631, diff: -0.04),
        StockModel(rank: 11, imageName: "GOOG", name: "알파벳 A", price: 3_176_631, diff: 0.04),
        StockModel(rank: 12, imageName: "AMZN", name: "아마존", price: 3_538_631, diff: 0.04),
        StockModel(rank: 13, imageName: "NIKE", name: "나이키", price: 158_631, diff: 0.04),
        StockModel(rank: 14, imageName: "DIS", name: "디즈니", price: 138_631, diff: 0.04),
    ]
}
