//
//  SiteStatViewModel.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import Foundation
import Combine

class SiteStatViewModel: ObservableObject {
    
    @Published var stat: SiteStatModel = SiteStatModel(topicMax: 0, memberMax: 0)
    
    private let dataService = StatDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$stat
            .sink { [weak self] returnedStat in
                self?.stat = returnedStat
            }
            .store(in: &cancelables)
    }
}
