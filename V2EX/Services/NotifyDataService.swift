//
//  NotifyDataService.swift
//  V2EX
//
//  Created by kim on 2024/11/27.
//

import Foundation
import Combine
import SwiftUI

class NotifyDataService: ObservableObject {
    
    @Published var notifies: [NotificationModel] = []
    @AppStorage("token") var token: String = ""
    
    private var notifySubscribtion: AnyCancellable?
    
    init() {}
    
    func getNotifies() {
        guard !token.isEmpty,
              let url = URL(string: "https://www.v2ex.com/api/v2/notifications?p=1") else {
            notifies = []
            return
        }
        notifySubscribtion = NetworkingManager.download(url: url, token: token)
            .map({ data -> [NotificationModel] in
                do {
                    let returnedValue = try JSONDecoder().decode(NotificationResult.self, from: data)
                    return returnedValue.result
                } catch {
                    print(error)
                    return []
                }
            })
//            .decode(type: [NotificationModel].self, decoder: NetworkingManager.decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedNotifies in
                self?.notifies = returnedNotifies
                self?.notifySubscribtion?.cancel()
            })
    }
}


