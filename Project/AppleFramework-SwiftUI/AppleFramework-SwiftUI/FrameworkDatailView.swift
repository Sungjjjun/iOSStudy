//
//  FrameworkDatailView.swift
//  AppleFramework-SwiftUI
//
//  Created by 박성준 on 2023/12/20.
//

import SwiftUI

struct FrameworkDatailView: View {
    @Binding var framework: AppleFramework
    
    var body: some View {
        VStack(spacing: 30){
            Image(framework.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text(framework.name)
                .font(.system(size: 30, weight: .bold))
            Text(framework.description)
                .font(.system(size: 18))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
            Button {
                
            } label: {
                Text("Learn More")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(.pink)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

struct FrameworkDatailView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDatailView(framework: .constant(AppleFramework.list[1]))
            .preferredColorScheme(.dark)
    }
}
