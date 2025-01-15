//
//  NodeViewModel.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import Foundation
import Combine

class NodeViewModel: ObservableObject {
    
    @Published var allNodes: [NodeModel] = [] // 全部节点
    @Published var sectionNodes: [String: [NodeModel]] = [:] // 分组节点
    @Published var searchText: String = "" // 搜索过滤
    
    private let dataService = NodeDataService()
    private var cancelables = Set<AnyCancellable>()
    private let dataManager = CoreDataManager.shared
    // 常用父节点集合
    private var parentNodeNames: [String]
    
    init() {
        parentNodeNames = [
            "dev", "programming", "apple", "life", "geek"
        ]
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allNodes
            .map(filterNodeSection)
            .combineLatest(dataManager.$nodeEntities)
            .map(combineNodes)
            .map(groupNodesByParentName)
            .sink { [weak self] returnedNodes in
                self?.sectionNodes = returnedNodes
            }
            .store(in: &cancelables)
        
        
        

        $searchText.combineLatest(dataService.$allNodes)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterNodes)
            .sink { [weak self] returnedNodes in
                self?.allNodes = returnedNodes
            }
            .store(in: &cancelables)
    }
    
    private func filterNodes(text: String, nodes: [NodeModel]) -> [NodeModel] {
        guard !text.isEmpty else {
            return nodes
        }
        
        let lowercasedText = text.lowercased()
        
        return nodes.filter { node in
            return node.title.lowercased().contains(lowercasedText) ||
            node.name.lowercased().contains(lowercasedText) ||
            (node.parentNodeName?.lowercased().contains(lowercasedText) ?? false)
        }
    }
    
    // 节点分组过滤
    private func filterNodeSection(nodes: [NodeModel]) -> [NodeModel] {
        nodes.filter { parentNodeNames.contains($0.parentNodeName ?? "") }
    }
    
    // 节点分组
    private func groupNodesByParentName(nodes: [NodeModel]) -> [String: [NodeModel]] {
        var groupedNodes = [String: [NodeModel]]()
        
        nodes.forEach { node in
            if let parentName = node.parentNodeName, !parentName.isEmpty {
                groupedNodes[parentName, default: []].append(node)
            }
        }
        return groupedNodes
    }
    
    // 同步数据库收藏数据
    private func combineNodes(nodes: [NodeModel], nodeEntities: [NodeEntity]) -> [NodeModel] {
        nodes.map { node in
            var updatedNode = node // 创建一个新的节点副本
            if let entity = nodeEntities.first(where: { $0.nodeID == node.id }) {
                updatedNode.isFavorite = entity.isFavorite
            }
            return updatedNode // 返回更新后的节点
        }
    }
    
}
