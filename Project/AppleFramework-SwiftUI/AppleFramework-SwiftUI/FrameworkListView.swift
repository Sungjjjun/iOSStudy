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
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
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
