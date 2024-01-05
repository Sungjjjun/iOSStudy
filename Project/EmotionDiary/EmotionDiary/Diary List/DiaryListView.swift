//
//  ContentView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

/*
 [✅] 전체 DiaryMood 리스트의 데이터(Sequence) => 월별로 따로 저장(Dictionary Type)
 - {"2022-04" : [DiaryMoode]}
 */
import SwiftUI

struct DiaryListView: View {
    @StateObject var viewModel: DiaryListViewModel
    @State var isPreseted: Bool = false
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.keys, id: \.self) { key in
                            Section {
                                let items = viewModel.dic[key] ?? []
                                let orderedItems = items.sorted(by: { $0.date < $1.date })
                                ForEach(orderedItems) { item in
                                    NavigationLink {
                                        let vm = DiaryDetailsViewModel(
                                            diary: item,
                                            diaries: $viewModel.list
                                        )
                                        DiaryDetailsView(viewModel: vm)
                                    } label: {
                                        MoodDiaryCell(diary: item)
                                            .frame(height: 50)
                                    }
                                }
                            } header: {
                                Text(formattedSectionTitle(key))
                                    .font(.system(size: 30, weight: .bold))
                            }
                            .frame(height: 60)
                            .padding()
                        }
                    }
                }
                HStack {
                    Button {
                        isPreseted = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                }
            }
            .navigationTitle("Emotion Diary")
        }
        .sheet(isPresented: $isPreseted) {
            let diaryViewModel = DiaryViewModel(isPresented: $isPreseted, diaries: $viewModel.list)
            DiaryDateInputView(viewModel: diaryViewModel)
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

extension DiaryListView {
    private func formattedSectionTitle(_ id: String) -> String {
        let dateComponents = id
            .components(separatedBy: "-")
            .compactMap{ Int($0) }
        guard let year = dateComponents.first, let month = dateComponents.last else {
            return id
        }
        
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponent = DateComponents(calendar: calendar, year: year, month: month)
        let date = dateComponent.date!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView(viewModel: DiaryListViewModel(storage: MoodDiaryStorage()))
            .preferredColorScheme(.dark)
    }
}
