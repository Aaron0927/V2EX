//
//  HomeViewModel.swift
//  V2EX
//
//  Created by kim on 2024/11/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var topics: [TopicModel] = []
    @Published var isLoading: Bool = false
    
    private let dataService = TopicDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$hotTopics
            .sink { [weak self] returnedTopics in
                self?.topics = returnedTopics
                self?.isLoading = false
            }
            .store(in: &cancelables)
        
        dataService.$latestTopics
            .sink { [weak self] returnedTopics in
                self?.topics = returnedTopics
                self?.isLoading = false
            }
            .store(in: &cancelables)
    }
    
    func getTopics(category: TopicCategory) {
        isLoading = true
        dataService.getTopics(category: category)
    }
    
}
