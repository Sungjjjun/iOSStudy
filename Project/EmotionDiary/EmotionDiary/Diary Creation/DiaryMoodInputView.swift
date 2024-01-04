//
//  DiaryMoodInputView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

import SwiftUI

struct DiaryMoodInputView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: DiaryViewModel
    
    let moods: [Mood] = Mood.allCases
    
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                ForEach(moods, id: \.self) { mood in
                    Button {
                        viewModel.mood = mood
                    } label: {
                        VStack() {
                            Image(systemName: mood.imageName)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                .padding()
                            Text(mood.name)
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(colorScheme == .dark ? .gray : .black)
                        }
                        .frame(height: 180)
                        .background(mood == viewModel.mood ? .gray.opacity(0.4) : .clear)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            Spacer()
            NavigationLink {
                DiaryTextInputView()
            } label: {
                Text("Next")
                    .frame(width: 200, height: 80)
                    .foregroundColor(.white)
                    .background(.pink)
                    .cornerRadius(40)
            }
        }
    }
}

struct DiaryMoodInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryMoodInputView(viewModel: DiaryViewModel(isPresented: .constant(false)))
            .preferredColorScheme(.dark)
    }
}
