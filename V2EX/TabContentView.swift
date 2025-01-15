//
//  ContentView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

enum Tab: Hashable {
    case home
    case node
    case notification
    case me
}

struct TabContentView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "flame")
            }
            .tag(Tab.home)
            
            NavigationStack {
                NodeView()
            }
            .tabItem {
                Image(systemName: "note.text")
            }
            .tag(Tab.node)
            
            NavigationStack {
                NotificationView()
            }
            .tabItem {
                Image(systemName: "bell.fill")
            }
            .tag(Tab.notification)
            
            NavigationStack {
                MyView()
            }
            .tabItem {
                Image(systemName: "person")
            }
            .tag(Tab.me)
        }
        .font(.headline)
        .tint(Color.theme.secondary) // 设置选中颜色
    }
}

#Preview {
    TabContentView()
}
