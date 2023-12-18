//
//  ContentView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct StockRankView: View {
    
    @State var list = StockModel.list
    
    var body: some View {
        
        // Cell 재사용을 위한 List
        List(list, id: \.self) { item in
            StockRankRow(stockModel: item)
                .listRowInsets(EdgeInsets(.zero))
                .listSectionSeparator(.hidden)
                .frame(height: 80)
        }
        .listStyle(.plain)
        .background(.black)
        
        // ScollView는 Cell 재사용 X
//        ScrollView {
//            ForEach(list, id: \.self) { stock in
//                StockRankRow(stockModel: stock)
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockRankView()
    }
}
