//
//  UserImageView.swift
//  V2EX
//
//  Created by kim on 2024/11/21.
//

import SwiftUI



struct UserImageView: View {
    
    @StateObject var vm: UserImageViewModel
    @State private var showUserProfileView: Bool = false
    
    private let member: MemberModel
    
    init(member: MemberModel) {
        self.member = member
        _vm = StateObject(wrappedValue: UserImageViewModel(member: member))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.userImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        showUserProfileView.toggle()
                    }
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
            }
        }
        .navigationDestination(isPresented: $showUserProfileView) {
            MyProfileView(isPresented: $showUserProfileView, member: member)
        }
    }
}

#Preview {
    UserImageView(member: DeveloperPreview.instance.memberModel)
}
