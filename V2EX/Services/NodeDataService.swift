//
//  NodeDataService.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import Foundation
import Combine

class NodeDataService: ObservableObject {
    
    @Published var allNodes: [NodeModel] = []
    
    private var nodeSubscribtion: AnyCancellable?
    
    init() {
        getAllNodes()
    }
    
    private func getAllNodes() {
        guard let url = URL(string: "https://www.v2ex.com/api/nodes/all.json") else {
            return
        }
        
        nodeSubscribtion = NetworkingManager.download(url: url)
            .decode(type: [NodeModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedNodes in
                self?.allNodes = returnedNodes
                self?.nodeSubscribtion?.cancel()
            })
    }
}
