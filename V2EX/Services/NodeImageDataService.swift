//
//  NodeImageDataService.swift
//  V2EX
//
//  Created by kim on 2024/12/18.
//

import Foundation
import Combine
import SwiftUI

class NodeImageDataService: ObservableObject {
    
    @Published var nodeImage: UIImage? = nil
    
    private var imageSubscribtion: AnyCancellable?
    private let node: NodeModel
    private let fileManager = LocalFileManager.instance
    private let imageName: String
    private let folderName: String = "node_iamges"
    
    init(node: NodeModel) {
        self.node = node
        self.imageName = "\(node.id)"
        getNodeImage()
    }
    
    private func getNodeImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            nodeImage = savedImage
        } else {
            downloadNodeImage()
        }
    }
    
    private func downloadNodeImage() {
        guard let url = URL(string: node.avatarNormal) else {
            return
        }
        
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.nodeImage = returnedImage
                self?.imageSubscribtion?.cancel()
            })
    }
    
}
