//
//  MyTopicViewModel.swift
//  V2EX
//
//  Created by kim on 2024/12/23.
//

import Foundation
import Combine

class MyTopicViewModel: ObservableObject {
    
    @Published var topics: [TopicModel] = []
    
    private let dataService = TopicDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init(member: MemberModel) {
        addSubscribers()
        dataService.getTopics(category: .user(userName: member.username))
    }
    
    private func addSubscribers() {
        dataService.$userTopics
            .sink { [weak self] returnedTopics in
                self?.topics = returnedTopics
            }
            .store(in: &cancelables)
    }
}
