//
//  ImageView.swift
//  SwiftUI-Basic
//
//  Created by 박성준 on 2023/12/15.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        // 순서 중요
        // Image Modifier는 이미지 리턴
        // View Modifier는 뷰 리턴
        // aspectRatio는 View Modifier
        Image(systemName: "sun.max.fill")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(0.5)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
