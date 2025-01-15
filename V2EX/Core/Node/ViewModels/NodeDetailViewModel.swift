//
//  NodeDetailViewModel.swift
//  V2EX
//
//  Created by kim on 2024/11/26.
//

import Foundation
import Combine

class NodeDetailViewModel: ObservableObject {
    
    @Published var allTopics: [TopicModel] = []
    @Published var node: NodeModel
    
    private let dataService = TopicDataService()
    private var cancelables = Set<AnyCancellable>()
    private let dataManager = CoreDataManager.shared
    
    init(node: NodeModel) {
        self.node = node
        addSubscribers()
        getNodeTopics(nodeName: node.name)
    }
    
    private func addSubscribers() {
        dataService.$nodeTopics
            .sink { [weak self] returnedTopics in
                self?.allTopics = returnedTopics
            }
            .store(in: &cancelables)
    }
    
    private func getNodeTopics(nodeName: String) {
        dataService.getTopics(category: .node(nodeName: nodeName))
    }
    
    // 添加收藏
    func toggleFavorite() {
        node.isFavorite.toggle()
        dataManager.updateNode(node: node, isFavorite: node.isFavorite)
    }
}
