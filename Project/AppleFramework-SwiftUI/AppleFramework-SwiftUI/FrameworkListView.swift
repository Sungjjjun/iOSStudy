//
//  ContentView.swift
//  AppleFramework-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct FrameworkListView: View {
    var body: some View {
        @State var list: [AppleFramework] = AppleFramework.list
        
        let layout: [GridItem] = [
            // Flexible => 화면 크기에 비례하여 아이템 크기 조절
            // Fixed => 아이템 크기 고정
            // Adaptive => 아이템 크기에 비례해서 화면에 아이템 갯수 조절
            GridItem(.adaptive(minimum: 100))
//            GridItem(.flexible()),
//            GridItem(.flexible()),
//            GridItem(.flexible()),
        ]
        
        // Grid 만들기
        // - UIKit => UICollectionView
        // - SwiftUI => LazyVGrid, LazyHGrid
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(list) { item in
                        FrameworkCell(framework: item)
                    }
                }
                .padding([.top, .leading, .trailing], 16.0)
            }
            .navigationTitle("🌼Apple Framework")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkListView()
    }
}
