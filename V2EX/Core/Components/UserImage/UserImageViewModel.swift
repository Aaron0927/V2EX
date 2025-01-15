//
//  UserImageViewModel.swift
//  V2EX
//
//  Created by kim on 2024/11/21.
//

import Foundation
import Combine
import SwiftUI

class UserImageViewModel: ObservableObject {
    
    @Published var userImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: UserImageDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(member: MemberModel) {
        self.dataService = UserImageDataService(member: member)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$userImage
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.userImage = returnedImage
            }
            .store(in: &cancelables)

    }
}
