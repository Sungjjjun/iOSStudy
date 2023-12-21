//
//  UserProfileView.swift
//  GithubUserSearch
//
//  Created by 박성준 on 2023/12/21.
//

import SwiftUI
import Kingfisher

struct UserProfileView: View {
    @StateObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack(spacing: 80) {
            KFImage(viewModel.imageURL)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 160)
                .cornerRadius(80)
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.name)
                        .font(.system(size: 30, weight: .bold))
                    Text(viewModel.login)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.followers)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text(viewModel.following)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
        }
        .onAppear {
            viewModel.search(keyword: viewModel.loginID)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: UserProfileViewModel(network: NetworkService(configuration: .default), loginID: "Sungjjjun"))
            .preferredColorScheme(.dark)
    }
}
