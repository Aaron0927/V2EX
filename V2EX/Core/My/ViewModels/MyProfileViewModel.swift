//
//  MyProfileViewModel.swift
//  V2EX
//
//  Created by kim on 2024/12/20.
//

import Foundation
import Combine

class MyProfileViewModel: ObservableObject {
    
    @Published var topics: [TopicModel] = []
    
    private let topicDataService = TopicDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init(member: MemberModel) {
        addSubscribers()
        topicDataService.getTopics(category: .user(userName: member.username))
    }
    
    private func addSubscribers() {
        topicDataService.$userTopics
            .sink { [weak self] returnedTopics in
                self?.topics = returnedTopics
            }
            .store(in: &cancelables)
    }
    
}
