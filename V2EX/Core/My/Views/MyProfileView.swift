//
//  MyProfileView.swift
//  V2EX
//
//  Created by kim on 2024/12/20.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: MyProfileViewModel
    
    @State private var selectedTopic: TopicModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showLogoutDialog: Bool = false
    
    @Binding var isPresented: Bool
    
    private let member: MemberModel
    
    init(isPresented: Binding<Bool>, member: MemberModel) {
        self._isPresented = isPresented
        self.member = member
        self._vm = StateObject(wrappedValue: MyProfileViewModel(member: member))
    }
    
    var body: some View {
        List {
            profileView
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            
            memberTopicsView
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .customNavigationBar(title: "")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let member = appState.member,
                   member.id == self.member.id {
                    Button {
                        showLogoutDialog.toggle()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(Color.theme.title)
                    }
                } else {
                    Button {
                        
                    } label: {
                        Text("关注".localized)
                            .foregroundStyle(Color.theme.secondary)
                            .font(.body)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showDetailView) {
            DetailLoadingView(topic: $selectedTopic)
        }
        .alert("确定退出吗？".localized, isPresented: $showLogoutDialog) {
            Button(role: .cancel) {
                showLogoutDialog.toggle()
            } label: {
                Text("取消".localized)
            }
            Button(role: .destructive) {
                appState.clearMember()
                isPresented.toggle()
            } label: {
                Text("确定".localized)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyProfileView(isPresented: .constant(false), member: DeveloperPreview.instance.memberModel)
            .environmentObject(AppState())
    }
}

extension MyProfileView {
    private var profileView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .top, spacing: 20) {
                    UserImageView(member: member)
                        .frame(width: 60, height: 60)
                        .clipShape(.rect(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(member.username)
                            .foregroundStyle(Color.theme.secondary)
                            .font(.headline)
                        
                        if let bio = member.bio {
                            Text(bio)
                                .foregroundStyle(Color.theme.body)
                                .font(.body)
                        }
                        
                        Text(String(format: "加入于 %@".localized, Date(timeIntervalSince1970: Double(member.created)).asHyphenString()))
                            .foregroundStyle(Color.theme.caption)
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Full Stack Developer. UTC+08:00. Talk is cheap.")
                    .foregroundStyle(Color.theme.body)
                    .font(.body)
                
                HStack {
                    IconImageView(imageName: "location", title: "ShenZhen")
                    IconImageView(imageName: "link", title: "Aaron")
                }
                .foregroundStyle(Color.theme.body)
                .font(.caption)
                
                HStack {
                    IconImageView(imageName: "location", title: "Aaron")
                    IconImageView(imageName: "link", title: "Aaron")
                    IconImageView(imageName: "link", title: "Aaron")
                }
                .foregroundStyle(Color.theme.body)
                .font(.caption)
                
                Text(String(format: "从%@开始成为V2EX用户".localized, Date(timeIntervalSince1970: Double(member.created)).asChineseDateString()))
                    .foregroundStyle(Color.theme.caption)
                    .font(.caption)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            Rectangle()
                .frame(maxHeight: 5)
                .foregroundStyle(Color.theme.border)
        }
    }
    
    private var memberTopicsView: some View {
        VStack(alignment: .leading) {
            Image(systemName: "newspaper")
                .foregroundStyle(Color.theme.caption)
                .font(.body)
                .padding(.horizontal)
            
            TopicListView(selectedTopic: $selectedTopic, showDetailView: $showDetailView, topics: vm.topics)
        }
        .padding(.top, 20)
    }
}
