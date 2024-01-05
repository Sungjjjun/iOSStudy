//
//  DiaryDetailsView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

import SwiftUI

struct DiaryDetailsView: View {
    @StateObject var viewModel: DiaryDetailsViewModel
    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 50) {
                    Text(formattedDate(dateString: viewModel.diary.date))
                        .font(.system(size: 30, weight: .bold))
                    
                    Image(systemName: viewModel.diary.mood.imageName)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .frame(width: 100, height: 100)
                    
                    Text(viewModel.diary.text)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(colorScheme == .dark ? .gray : .black)
                    
                }
                .frame(maxWidth: .infinity)
            }
            HStack{
                Button {
                    print("Delete Button Clicked")
                    viewModel.delete()
                } label: {
                    Image(systemName: "trash")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 0))
                Spacer()
            }
        }
    }
}

extension DiaryDetailsView {
    private func formattedDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let date = formatter.date(from: dateString)

        formatter.dateFormat = "EEE, MMM d, yyyy"
        return formatter.string(from: date!)
    }
}

struct DiaryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = DiaryDetailsViewModel(
            diary: MoodDiary.list[0],
            diaries: .constant(MoodDiary.list)
        )
        DiaryDetailsView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
