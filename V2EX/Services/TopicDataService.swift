//
//  TopicDataService.swift
//  V2EX
//
//  Created by kim on 2024/11/21.
//

import Foundation
import Combine

// 定义枚举表示选中状态
enum TopicCategory: Equatable {
    case hot // 热门
    case latest // 最新
    case node(nodeName: String) // 节点下的所有主题
    case user(userName: String) // 用户发表的所有主题
    
    var rawValue: String {
        switch self {
        case .hot:
            return "热门".localized
        case .latest:
            return "最新".localized
        case .node:
            return ""
        case .user:
            return ""
        }
    }
    
    var urlString: String {
        switch self {
        case .hot:
            return "https://www.v2ex.com/api/topics/hot.json"
        case .latest:
            return "https://www.v2ex.com/api/topics/latest.json"
        case .node(let nodeName):
            return "https://www.v2ex.com/api/topics/show.json?node_name=\(nodeName)"
        case .user(let userName):
            return "https://www.v2ex.com/api/topics/show.json?username=\(userName)"
        }
    }
}

class TopicDataService: ObservableObject {
    
    @Published var hotTopics: [TopicModel] = []
    @Published var latestTopics: [TopicModel] = []
    @Published var nodeTopics: [TopicModel] = []
    @Published var userTopics: [TopicModel] = []
    
    private var topicSubscribtion: AnyCancellable?
    
    init() { }
    
    func getTopics(category: TopicCategory) {
        guard let url = URL(string: category.urlString) else {
            return
        }
        
        topicSubscribtion = NetworkingManager.download(url: url)
//            .map({ data -> [TopicModel] in
//                do {
//                    let returnedValue = try JSONDecoder().decode([TopicModel].self, from: data)
//                    return returnedValue
//                } catch {
//                    print(error)
//                    return []
//                }
//            })
            .decode(type: [TopicModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedTopics in
                switch category {
                case .hot:
                    self?.hotTopics = returnedTopics
                case .latest:
                    self?.latestTopics = returnedTopics
                case .node:
                    self?.nodeTopics = returnedTopics
                case .user:
                    self?.userTopics = returnedTopics
                }
                self?.topicSubscribtion?.cancel()
            })
    }
}
