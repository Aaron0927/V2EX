//
//  ReplyViewModel.swift
//  V2EX
//
//  Created by kim on 2024/12/12.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var replies: [ReplyModel] = []
    @Published var isFavorite: Bool = false
    @Published var topic: TopicModel
    
    private let replyDataService: ReplyDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(topic: TopicModel) {
        self.topic = topic
        self.replyDataService = ReplyDataService(topic: topic)
        addSubscribers()
    }
    
    private func addSubscribers() {
        replyDataService.$replies
            .sink { [weak self] returnedReplies in
                self?.replies = returnedReplies
            }
            .store(in: &cancelables)
    }
}
