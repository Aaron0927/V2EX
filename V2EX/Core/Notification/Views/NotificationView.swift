//
//  NotificationView.swift
//  V2EX
//
//  Created by Aaron on 2024/11/10.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: NotificationViewModel = NotificationViewModel()
    
    @State private var showLoginView: Bool = false
    
    var body: some View {
        ZStack {
            if let _ = appState.member {
                ZStack {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        if vm.notifies.isEmpty {
                            emptyView
                        }
                        
                        List {
                            ForEach(vm.notifies) { notify in
                                NotifcationRowView(notification: notify)
                                    .listRowInsets(EdgeInsets())
                                    .listRowSeparator(.hidden)
                            }
                        }
                    }
                }
                .onAppear {
                    vm.getNotifies()
                }
            } else {
                // not login
                VStack(spacing: 15) {
                    Image(systemName: "bell.fill")
                        .foregroundStyle(Color.theme.caption)
                        .font(.system(size: 50))
                    Text("此功能需要登录，要不登录下？".localized)
                        .foregroundStyle(Color.theme.caption)
                        .font(.body)
                    Button(action: {
                        showLoginView.toggle()
                    }, label: {
                        Text("去登录".localized)
                            .foregroundStyle(Color.theme.secondary)
                            .font(.body)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 40)
                    })
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.theme.secondary, lineWidth: 1.0)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("通知".localized)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showLoginView) {
            LoginView()
        }
    }
}

#Preview {
    NavigationStack {
        NotificationView()
            .environmentObject(AppState())
    }
}

extension NotificationView {
    // Empty View
    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bell")
                .foregroundStyle(Color.theme.caption)
                .font(.system(size: 48))
            
            Text("暂时还没有通知".localized)
                .foregroundStyle(Color.theme.caption)
                .font(.body)
            
            Button(action: {
                vm.getNotifies()
            }, label: {
                Text("刷新下".localized)
                    .foregroundStyle(Color.theme.secondary)
                    .font(.body)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.theme.secondary, lineWidth: 1)
                    )
            })
        }
    }
}
