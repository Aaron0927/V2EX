//
//  SiteStatModel.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import Foundation

/**
 URL:
 https://www.v2ex.com/api/site/stats.json
 
 Response:
 {
     "topic_max" : 1092273,
     "member_max" : 721847
 }
 */

struct SiteStatModel: Codable {
    
    let topicMax: Int
    let memberMax: Int
    
}
