//
//  Double.swift
//  V2EX
//
//  Created by kim on 2024/11/27.
//

import Foundation

extension Double {
    func asTimeAgoDisplay() -> String {
        return Date(timeIntervalSince1970: self).timeAgoDisplay()
    }
}
