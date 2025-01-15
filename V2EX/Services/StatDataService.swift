//
//  StatDataService.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import Foundation
import Combine

class StatDataService: ObservableObject {
    
    @Published var stat: SiteStatModel = SiteStatModel(topicMax: 0, memberMax: 0)
    
    private var statSubscribtion: AnyCancellable?
    
    init() {
        getSiteStat()
    }
    
    private func getSiteStat() {
        guard let url = URL(string: "https://www.v2ex.com/api/site/stats.json") else {
            return
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        statSubscribtion = NetworkingManager.download(url: url)
            .decode(type: SiteStatModel.self, decoder: jsonDecoder)
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedStat in
                self?.stat = returnedStat
                self?.statSubscribtion?.cancel()
            })
    }
}
