//
//  DiaryTextInputView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

import SwiftUI

struct DiaryTextInputView: View {
    @ObservedObject var viewModel: DiaryViewModel
   
    // 화면이 띄워짐과 동시에 키보드가 나타나게 하기 위해
    @FocusState var focused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $viewModel.text)
                .focused($focused)
                .border(.gray.opacity(0.2), width: 2)
            Spacer()
            Button {
                viewModel.completed()
            } label: {
                Text("Done")
                    .frame(width: 200, height: 80)
                    .foregroundColor(.white)
                    .background(.pink)
                    .cornerRadius(40)
            }
        }
        .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
            focused = true
        }
    }
}

struct DiaryTextInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryTextInputView(viewModel: DiaryViewModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list)))
    }
}
