//
//  DiaryDateInputView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

/*
 생성 버튼 Click -> 날짜 입력 -> 기분 입력 -> Text 입력
 */
import SwiftUI

struct DiaryDateInputView: View {
    @StateObject var viewModel: DiaryViewModel
    
    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $viewModel.date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }
    }
}

struct DiaryDateInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDateInputView(
            viewModel: DiaryViewModel(isPresented: .constant(false))
        )
            .preferredColorScheme(.dark)
    }
}
