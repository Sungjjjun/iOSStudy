//
//  FrameworkDatailView.swift
//  AppleFramework-SwiftUI
//
//  Created by 박성준 on 2023/12/20.
//

import SwiftUI

struct FrameworkDatailView: View {
    @StateObject var viewModel: FrameworkDetailViewModel
    
    var body: some View {
        VStack(spacing: 30){
            Spacer()
            Image(viewModel.framework.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text(viewModel.framework.name)
                .font(.system(size: 30, weight: .bold))
            Text(viewModel.framework.description)
                .font(.system(size: 18))
            Spacer()
            Button {
                print("Safari 띄우기")
            } label: {
                Text("Learn More")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(.pink)
            .cornerRadius(40)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct FrameworkDatailView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDatailView(viewModel: FrameworkDetailViewModel(framework: AppleFramework.list[1]))
            .preferredColorScheme(.dark)
    }
}
