//
//  NodeImageViewModel.swift
//  V2EX
//
//  Created by kim on 2024/12/18.
//

import Foundation
import Combine
import SwiftUI

class NodeImageViewModel: ObservableObject {
    
    @Published var nodeImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: NodeImageDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(node: NodeModel) {
        self.dataService = NodeImageDataService(node: node)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$nodeImage
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.nodeImage = returnedImage
            }
            .store(in: &cancelables)

    }
}
