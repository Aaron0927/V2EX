//
//  UserImageDataService.swift
//  V2EX
//
//  Created by kim on 2024/11/21.
//

import Foundation
import Combine
import SwiftUI

class UserImageDataService: ObservableObject {
    
    @Published var userImage: UIImage? = nil
    
    private var imageSubscribtion: AnyCancellable?
    private let member: MemberModel
    private let fileManager = LocalFileManager.instance
    private let imageName: String
    private let folderName: String = "user_iamges"
    
    init(member: MemberModel) {
        self.member = member
        self.imageName = "\(member.id)"
        getUserImage()
    }
    
    private func getUserImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            userImage = savedImage
        } else {
            downloadUserImage()
        }
    }
    
    private func downloadUserImage() {
        guard let url = URL(string: member.avatarNormal) else {
            return
        }
        
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.userImage = returnedImage
                self?.imageSubscribtion?.cancel()
            })
    }
    
}
