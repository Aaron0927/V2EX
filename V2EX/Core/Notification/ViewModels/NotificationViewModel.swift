//
//  NotificationViewModel.swift
//  V2EX
//
//  Created by kim on 2024/11/26.
//

import Foundation
import Combine

class NotificationViewModel: ObservableObject {
    
    @Published var notifies: [NotificationModel] = []
    @Published var isLoading: Bool = false
    
    private let dataService = NotifyDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$notifies
            .sink { [weak self] returnedNotifies in
                self?.notifies = returnedNotifies
                self?.isLoading = false
            }
            .store(in: &cancelables)
    }
    
    func getNotifies() {
        isLoading = true
        dataService.getNotifies()
    }
}
