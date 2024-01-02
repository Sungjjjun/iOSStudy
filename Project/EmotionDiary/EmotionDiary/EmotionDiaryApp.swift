//
//  EmotionDiaryApp.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

import SwiftUI

@main
struct EmotionDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            DiaryListView(viewModel: DiaryListViewModel())
        }
    }
}
