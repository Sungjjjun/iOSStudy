//
//  DiaryDetailsView.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

import SwiftUI

struct DiaryDetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    var diary: MoodDiary
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 50) {
                    Text(formattedDate(dateString: diary.date))
                        .font(.system(size: 30, weight: .bold))
                    
                    Image(systemName: diary.mood.imageName)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .frame(width: 100, height: 100)
                    
                    Text(diary.text)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(colorScheme == .dark ? .gray : .black)
                    
                }.padding(EdgeInsets(top: 100, leading: 10, bottom: 10, trailing: 0))
            }
            HStack{
                Button {
                    print("Delete Button Clicked")
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
        DiaryDetailsView(diary: MoodDiary.list[1])
            .preferredColorScheme(.dark)
    }
}
