//
//  ContentView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct StockRankView: View {
    
//    @State var list = StockModel.list
    @StateObject var viewModel = StockRankViewModel()
    
    var body: some View {
        NavigationView {
            // Cell 재사용을 위한 List
            List($viewModel.models) { $item in
                
                // 디자인적으로 Custom한 셀들을 Navigiation View에 적용하기 위한 방법
                ZStack {
                    NavigationLink {
                        StockDetailView(viewModel: viewModel, stock: $item)
                    } label: {
                        EmptyView()
                    }
                    StockRankRow(stockModel: $item)
                        .listRowInsets(EdgeInsets(.zero))
                        .listSectionSeparator(.hidden)
                        .frame(height: 80)
                }
                .listRowInsets(EdgeInsets(.zero))
                .frame(height: 80)
            }
            .listStyle(.plain)
            .navigationTitle("Stock Rank")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockRankView()
             .preferredColorScheme(.dark)
    }
}
