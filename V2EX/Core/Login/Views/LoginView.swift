//
//  LoginView.swift
//  V2EX
//
//  Created by kim on 2025/1/9.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var token: String = ""
    @State private var showServiceView: Bool = false
    @State private var showPolicyView: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.red.opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Link(destination: URL(string: "https://www.v2ex.com/settings/tokens")!) {
                        Text("获取token".localized)
                            .foregroundStyle(Color.theme.body)
                            .font(.body)
                    }
                }
                .padding()
                
                Spacer()
                Image("256")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.vertical, 50)
                
                VStack(spacing: 20) {
                    TextField("输入授权码..".localized, text: $token)
                        .foregroundStyle(Color.black)
                        .padding(.horizontal)
                        .frame(minHeight: 50)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 10))
                    
                    Button {
                        viewModel.login(token: token)
                    } label: {
                        Text("使用 Token 授权登录".localized)
                            .padding(.horizontal)
                            .foregroundStyle(Color.theme.surface)
                            .font(.body)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.theme.secondary)
                            .clipShape(.rect(cornerRadius: 10))
                            .opacity(token.isEmpty ? 0.7 : 1)
                    }
                    .disabled(token.isEmpty)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("跳过,暂不授权".localized)
                            .foregroundStyle(Color.theme.body)
                            .font(.callout)
                    }
                    .padding(.top, 10)

                }
                .padding(.horizontal)
                
                Spacer()
                Spacer()
                
                HStack(spacing: 0) {
                    Text("登录即表示你同意".localized)
                    Text("服务条款".localized)
                        .foregroundStyle(Color.blue)
                        .underline()
                        .onTapGesture {
                            showServiceView.toggle()
                        }
                    Text("和".localized)
                    Text("隐私政策".localized)
                        .foregroundStyle(Color.blue)
                        .underline()
                        .onTapGesture {
                            showPolicyView.toggle()
                        }
                }
                .foregroundStyle(Color.theme.body)
                .font(.footnote)
            }
        }
        .toast(toastMessage, showToast: $showToast)
        .sheet(isPresented: $showServiceView) {
            NavigationStack {
                TermsServiceView()
            }
        }
        .sheet(isPresented: $showPolicyView) {
            NavigationStack {
                PrivacyView()
            }
        }
        .onChange(of: viewModel.loginSuccess) { _, success in
            if success {
                appState.saveMember(member: viewModel.member)
                dismiss()
            } else {
                toastMessage = viewModel.message ?? ""
                showToast = true
            }
        }
    }
}

#Preview {
    LoginView()
}
