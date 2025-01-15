//
//  V2EXApp.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

@main
struct V2EXApp: App {
    
    @StateObject private var appState = AppState() // 全局状态
    
    var body: some Scene {
        WindowGroup {
            TabContentView()
                .onAppear {
                    switch appState.theme {
                    case .auto:
                        UIApplication.window?.overrideUserInterfaceStyle = .unspecified
                    case .light:
                        UIApplication.window?.overrideUserInterfaceStyle = .light
                    case .dark:
                        UIApplication.window?.overrideUserInterfaceStyle = .dark
                    }
                }
                .environmentObject(appState) // 注入到环境中
        }
    }
}
