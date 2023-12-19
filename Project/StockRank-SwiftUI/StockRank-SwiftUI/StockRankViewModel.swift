//
//  StockRankViewModel.swift
//  StockRank-SwiftUI
//
//  Created by 박성준 on 2023/12/19.
//

import Foundation

final class StockRankViewModel: ObservableObject {
    @Published var models: [StockModel] = StockModel.list
    
    var numberOfFavorites: Int {
        return models.filter { model in
            model.isFavorite
        }.count
    }
}
