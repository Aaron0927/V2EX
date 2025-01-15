//
//  TopicReplyDataService.swift
//  V2EX
//
//  Created by kim on 2024/12/12.
//

import Foundation
import Combine

/// 主题回复
class ReplyDataService: ObservableObject {
    
    @Published var replies: [ReplyModel] = []
    
    private let topic: TopicModel
    private var replySubscribtion: AnyCancellable?
    
    init(topic: TopicModel) {
        self.topic = topic
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://www.v2ex.com/api/replies/show.json?topic_id=\(topic.id)&page=1&page_size=100") else {
            return
        }
        
        replySubscribtion = NetworkingManager.download(url: url)
            .map({ data -> [ReplyModel] in
                do {
                    let returnedValue = try JSONDecoder().decode([ReplyModel].self, from: data)
                    return returnedValue
                } catch {
                    print(error)
                    return []
                }
            })
//            .decode(type: [ReplyModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedNotifies in
                self?.replies = returnedNotifies
                self?.replySubscribtion?.cancel()
            })
    }
    
}
