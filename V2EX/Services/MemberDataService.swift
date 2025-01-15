//
//  MemberDataService.swift
//  V2EX
//
//  Created by kim on 2025/1/9.
//

import Foundation
import Combine
import SwiftUI

class MemberDataService: ObservableObject {
    
    @Published var member: MemberModel?
    @AppStorage("token") var token: String = ""
    
    private var memberSubscription: AnyCancellable?
    
    init() { }
    
    func getMember(token: String) {
        guard let url = URL(string: "https://www.v2ex.com/api/v2/member") else {
            return
        }
        
        memberSubscription = NetworkingManager.download(url: url, token: token)
            .decode(type: MemberModelWrapper.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedMember in
                self?.member = returnedMember.member
                if let _ = self?.member {
                    self?.token = token
                }
                self?.memberSubscription?.cancel()
            }
    }
}
