//
//  SettingThemeView.swift
//  V2EX
//
//  Created by kim on 2024/12/23.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case auto = "自动"
    case light = "日间"
    case dark = "深色"
}

struct SettingThemeView: View {
    
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        List {
            ForEach(Theme.allCases, id: \.self) { theme in
                Text(theme.rawValue.localized)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.theme.surface)
                    .font(.body)
                    .foregroundStyle(theme == appState.theme ? Color.theme.secondary : Color.theme.body)
                    .onTapGesture {
                        appState.theme = theme
                    }
            }
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .background(Color.theme.background)
        .customNavigationBar(title: "选择主题")
    }
}

#Preview {
    NavigationStack {
        SettingThemeView()
            .environmentObject(AppState())
    }
}
