//
//  UserProfileView.swift
//  GithubUserSearch
//
//  Created by 박성준 on 2023/12/21.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.crop.square.fill")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 160)
                .cornerRadius(80)
            Text(viewModel.name)
                .font(.system(size: 30, weight: .bold))
            Text(viewModel.login)
                .font(.system(size: 20))
                .foregroundColor(.gray)
            Text(viewModel.followers)
                .font(.system(size: 20))
                .foregroundColor(.gray)
            Text(viewModel.following)
                .font(.system(size: 20))
                .foregroundColor(.gray)
        }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: UserProfileViewModel(network: NetworkService(configuration: .default), loginID: "Sungjjjun"))
            .preferredColorScheme(.dark)
    }
}
