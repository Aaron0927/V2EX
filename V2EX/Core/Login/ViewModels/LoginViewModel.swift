//
//  LoginViewModel.swift
//  V2EX
//
//  Created by kim on 2025/1/9.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var member: MemberModel? = nil
    @Published var message: String? = nil
    @Published var loginSuccess: Bool = false
    
    private let memberService = MemberDataService()
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        memberService.$member
            .sink { [weak self] returnedMember in
                if let returnedMember = returnedMember {
                    self?.member = returnedMember
                    self?.loginSuccess = true
                } else {
                    self?.message = "登录失败，请检查您的授权码。".localized
                }
            }
            .store(in: &cancelable)
    }
    
    func login(token: String) {
        // "0d023c5a-442c-4bc6-9084-30db95d111f1"
        memberService.getMember(token: token)
    }
    
}
