//
//  MyView.swift
//  V2EX
//
//  Created by Aaron on 2024/11/10.
//

import SwiftUI
import Combine
import MessageUI

struct MyView: View {
    
    @EnvironmentObject private var appState: AppState
    @State private var cancellable: AnyCancellable?
    
    @State private var showProfileView: Bool = false
    @State private var showTopicsView: Bool = false
    @State private var showThemeSettingView: Bool = false
    @State private var showLanguageSettingView: Bool = false
    @State private var showLoginView: Bool = false
    @State private var showRotationView: Bool = false
    @State private var degree: CGFloat = 0
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var showShareSheet = false
    @State private var isMailViewPresented = false
    
    private let textToShare = "Check out this amazing SwiftUI App!"
    private let urlToShare = URL(string: "https://github.com/Aaron0927")!
    
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }
    
    
    private var member: MemberModel? {
        appState.member
    }
    
    var body: some View {
        ZStack {
            List {
                profileSection
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                settingsSection
                generalSection
                feedbackSection
            }
            .listStyle(.insetGrouped)
            
            if showRotationView {
                Image(systemName: "arrow.2.circlepath")
                    .foregroundStyle(Color.theme.title)
                    .font(.system(size: 50))
                    .rotationEffect(Angle(degrees: degree), anchor: .center)
            }
        }
        .background(Color.theme.background)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showProfileView) {
            if let member = member {
                MyProfileView(isPresented: $showProfileView, member: member)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .navigationDestination(isPresented: $showTopicsView) {
            if let member = member {
                MyTopicView(member: member)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .navigationDestination(isPresented: $showThemeSettingView) {
            SettingThemeView()
                .toolbar(.hidden, for: .tabBar)
        }
        .navigationDestination(isPresented: $showLanguageSettingView) {
            SettingLanguageView()
                .toolbar(.hidden, for: .tabBar)
        }
        .sheet(isPresented: $showLoginView) {
            LoginView()
                .environmentObject(appState)
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [textToShare, urlToShare])
        }
        .sheet(isPresented: $isMailViewPresented) {
            MailView(subject: "V2EX",
                     recipients: ["aaronxiao0927@gmail.com"],
                     body: "This is the email body.")
        }
        .toast(toastMessage, showToast: $showToast)
    }
}

#Preview {
    NavigationStack {
        MyView()
            .environmentObject(AppState())
    }
}

extension MyView {
    private var profileView: some View {
        VStack {
            HStack {
                HStack(alignment: .top, spacing: 20) {
                    if let member = member {
                        UserImageView(member: member)
                            .frame(width: 60, height: 60)
                            .clipShape(.rect(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(member.username)
                                .foregroundStyle(Color.theme.secondary)
                                .font(.headline)
                            
                            if let tagline = member.tagline {
                                Text(tagline)
                                    .foregroundStyle(Color.theme.body)
                                    .font(.body)
                            }
                            
                            Text(String(format: "加入于 %@".localized, Date(timeIntervalSince1970: Double(member.created)).asHyphenString()))
                                .foregroundStyle(Color.theme.caption)
                                .font(.caption)
                        }
                    } else {
                        Rectangle()
                            .background(Color.theme.background)
                            .frame(width: 60, height: 60)
                            .clipShape(.rect(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("去登录".localized)
                                .foregroundStyle(Color.theme.secondary)
                                .font(.headline)
                            Text("登录体验更多V2EX功能".localized)
                                .foregroundStyle(Color.theme.body)
                                .font(.callout)
                        }
                        .background(Color.clear)
                        .onTapGesture {
                            showLoginView.toggle()
                        }
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(Color.theme.caption)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 5)
            Divider()
        }
        .onTapGesture {
            showProfileView.toggle()
        }
    }
    
    private var profileSection: some View {
        Section {
            profileView
                
            HStack {
                MyProfileItemView(title: "我的主题".localized, value: 22)
                    .onTapGesture {
                        showTopicsView.toggle()
                    }
                Spacer()
                MyProfileItemView(title: "收藏主题".localized, value: 22)
                    .onTapGesture {
                        showTopicsView.toggle()
                    }
                Spacer()
                MyProfileItemView(title: "关注的人".localized, value: 22)
                    .onTapGesture {
                        showTopicsView.toggle()
                    }
                Spacer()
                MyProfileItemView(title: "浏览记录".localized, value: 22)
                    .onTapGesture {
                        showTopicsView.toggle()
                    }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var settingsSection: some View {
        Section {
            ProfileRowView(imageName: "paintpalette", title: "主题设置".localized)
                .onTapGesture {
                    showThemeSettingView.toggle()
                }
            ProfileRowView(imageName: "globe", title: "语言环境".localized)
                .onTapGesture {
                    showLanguageSettingView.toggle()
                }
            ProfileRowView(imageName: "arrow.2.circlepath", title: "缓存清理".localized)
                .onTapGesture {
                    showRotationView.toggle()
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                        self.degree = 360
                    }
                    toastMessage = ""
                    cancellable = LocalFileManager.instance.clearCache()
                        .sink { success in
                            self.showRotationView = false
                            self.degree = 0
                            self.toastMessage = success ? "清理成功".localized : "清理失败".localized
                            self.showToast.toggle()
                            self.cancellable?.cancel()
                        }
                }
        } header: {
            Text("设置".localized)
        }
    }
    
    private var generalSection: some View {
        Section {
            ProfileRowView(imageName: "star", title: "评分鼓励".localized)
                .onTapGesture {
                    toastMessage = "暂未实现该功能".localized
                    showToast.toggle()
                }
            ProfileRowView(imageName: "square.and.arrow.up", title: "分享给好友".localized)
                .onTapGesture {
                    showShareSheet.toggle()
                }
            ProfileRowView(imageName: "link", title: "URL Schemes")
                .onTapGesture {
                    toastMessage = "暂未实现该功能".localized
                    showToast.toggle()
                }
            ProfileRowView(imageName: "lock.open", title: "开源协议".localized)
                .onTapGesture {
                    toastMessage = "暂未实现该功能".localized
                    showToast.toggle()
                }
            ProfileRowView(imageName: "person.2", title: "关于".localized)
                .onTapGesture {
                    toastMessage = "暂未实现该功能".localized
                    showToast.toggle()
                }
        } header: {
            Text("综合".localized)
        }
    }
    
    private var feedbackSection: some View {
        Section {
            ProfileRowView(imageName: "envelope", title: "邮件".localized, detail: "aaronxiao0927@gmail.com")
                .onTapGesture {
                    if MFMailComposeViewController.canSendMail() {
                        isMailViewPresented = true
                    } else {
                        toastMessage = "Cannot send email on this device."
                        showToast.toggle()
                    }
                }
            
            ProfileRowView(imageName: "", customImageName: "logo.twitter", title: "推特".localized, detail: "Aaron")
                .onTapGesture {
                    let urlString = "https://x.com/kim_18162579527"
                    openURL(urlStr: urlString)
                }
            ProfileRowView(imageName: "", customImageName: "logo.github", title: "Github", detail: "Aaron0927")
                .onTapGesture {
                    let urlString = "https://github.com/Aaron0927"
                    openURL(urlStr: urlString)
                }
        } header: {
            Text("反馈".localized)
        } footer: {
            HStack {
                VStack(spacing: 10) {
                    Text("V2EX \(appVersion)(\(buildNumber))")
                    Text("V2EX创意工作者们的社区".localized)
                }
                .font(.footnote)
                .foregroundStyle(Color.theme.caption)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 20)
        }
    }
    
    private func openURL(urlStr: String) {
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    print("Failed to open url \(url).")
                }
            }
        }
    }
}


struct MyProfileItemView: View {
    
    let title: String
    let value: Int
    
    var body: some View {
        VStack {
            Text("\(value)")
                .foregroundStyle(Color.theme.title)
                .font(.headline)
                .bold()
            Text(title)
                .foregroundStyle(Color.theme.body)
                .font(.body)
        }
    }
}
