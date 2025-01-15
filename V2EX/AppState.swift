//
//  AppState.swift
//  V2EX
//
//  Created by kim on 2025/1/10.
//

import Foundation
import Combine
import SwiftUI

/// 全局数据模型
class AppState: ObservableObject {
    @Published var member: MemberModel? = nil
    
    @AppStorage("user") var userInfo: String = ""
    @AppStorage("token") var token: String = ""
    @AppStorage("theme") var theme: Theme = .auto {
        didSet {
            switch theme {
            case .auto:
                UIApplication.window?.overrideUserInterfaceStyle = .unspecified
            case .light:
                UIApplication.window?.overrideUserInterfaceStyle = .light
            case .dark:
                UIApplication.window?.overrideUserInterfaceStyle = .dark
            }
        }
    }
    @AppStorage("language") var language: AppLanguage = .auto
    
    init() {
        self.member = getMember()
    }
    
    func getMember() -> MemberModel? {
        guard !userInfo.isEmpty,
              let data = userInfo.data(using: .utf8)
        else { return nil }
        do {
            let member = try JSONDecoder().decode(MemberModel.self, from: data)
            return member
        } catch {
            print("convert to member error \(error)")
            return nil
        }
    }
    
    func saveMember(member: MemberModel?) {
        self.member = member
        guard let member = member else { return }
        do {
            let data = try JSONEncoder().encode(member)
            let json = String(data: data, encoding: .utf8)
            self.userInfo = json ?? ""
        } catch {
            print("convert to json error \(error)")
        }
    }
    
    func clearMember() {
        self.member = nil
        self.userInfo = ""
        self.token = ""
    }
}
