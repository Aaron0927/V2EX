//
//  SidebarView.swift
//  V2EX
//
//  Created by kim on 2024/11/20.
//

import SwiftUI

struct SidebarView: View {
    
    @Binding var isSidebarVisible: Bool
    @Binding var category: TopicCategory
    private var selectedCallback: () -> Void
    
    init(isSidebarVisible: Binding<Bool>, category: Binding<TopicCategory>,  _ callback: @escaping () -> Void) {
        self._isSidebarVisible = isSidebarVisible
        self._category = category
        self.selectedCallback = callback
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .opacity(isSidebarVisible ? 1 : 0)
            
            content
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

extension SidebarView {
    
    private var content: some View {
        VStack(spacing: 20) {
            VStack(spacing: 5) {
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 20))
                Text(TopicCategory.hot.rawValue)
                    .font(.system(size: 14))
            }
            .background(Color.clear) // 添加透明背景
            .foregroundStyle(category == .hot ? Color.theme.secondary : Color.theme.caption)
            .onTapGesture {
                category = .hot
                isSidebarVisible = false
                selectedCallback()
            }
            
            VStack(spacing: 5) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 20))
                Text(TopicCategory.latest.rawValue)
                    .font(.system(size: 14))
            }
            .background(Color.clear) // 添加透明背景
            .foregroundStyle(category == .latest ? Color.theme.secondary : Color.theme.caption)
            .onTapGesture {
                category = .latest
                isSidebarVisible = false
                selectedCallback()
            }
            
            Spacer()
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    SidebarView(isSidebarVisible: .constant(true), category: .constant(.hot)){}
}
