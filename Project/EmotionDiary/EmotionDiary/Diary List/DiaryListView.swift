//
//  ContentView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

/* ✅
 [] 전체 DiaryMood 리스트의 데이터(Sequence) => 월별로 따로 저장(Dictionary Type)
    - {"2022-04" : [DiaryMoode]}
 */
import SwiftUI

struct DiaryListView: View {
    @StateObject var viewModel: DiaryListViewModel
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(viewModel.keys, id: \.self) { key in
                Section {
                    let items = viewModel.dic[key] ?? []
                    let orderedItems = items.sorted(by: { $0.date < $1.date })
                    ForEach(orderedItems) { item in
                        MoodDiaryCell(diary: item)
                            .frame(height: 50)
                    }
                } header: {
                    Text(key)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView(viewModel: DiaryListViewModel())
            .preferredColorScheme(.dark)
    }
}
