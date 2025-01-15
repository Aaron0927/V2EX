//
//  SettingLanguageView.swift
//  V2EX
//
//  Created by kim on 2024/12/23.
//

import SwiftUI

enum AppLanguage: String, CaseIterable {
    case auto = "自动"
    case chs = "简体中文"
    case en = "English"
    
    var name: String {
        switch self {
        case .auto:
            if let languageCode = Locale.current.language.languageCode?.identifier {
                return languageCode
            }
            return "en"
        case .chs:
            return "zh-Hans"
        case .en:
            return "en"
        }
    }
}

struct SettingLanguageView: View {
    
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        List {
            ForEach(AppLanguage.allCases, id: \.self) { language in
                Text(language.rawValue.localized)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.theme.surface)
                    .font(.body)
                    .foregroundStyle(language == appState.language ? Color.theme.secondary : Color.theme.body)
                    .onTapGesture {
                        appState.language = language
                    }
            }
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .background(Color.theme.background)
        .customNavigationBar(title: "选择语言".localized)
    }
}

#Preview {
    NavigationStack {
        SettingLanguageView()
            .environmentObject(AppState())
    }
}

