//
//  Date.swift
//  V2EX
//
//  Created by kim on 2024/11/20.
//

import Foundation

extension Date {
    // 时间戳 -》 Date -> String
    /**
     xx 分钟前
     xx 小时前
     xx 天前
     xx 周前
     xx 年前
     yyyy/MM/dd
     */
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        let year = 365 * day
        
        if secondsAgo < minute {
            return String(format: "%ld 秒前".localized, secondsAgo)
        } else if secondsAgo < hour {
            return String(format: "%ld 分钟前".localized, secondsAgo / minute)
        } else if secondsAgo < day {
            return String(format: "%ld 小时前".localized, secondsAgo / hour)
        } else if secondsAgo < week {
            return String(format: "%ld 天前".localized, secondsAgo / day)
        } else if secondsAgo < month {
            return String(format: "%ld 周前".localized, secondsAgo / week)
        } else if secondsAgo < year {
            return String(format: "%ld 月前".localized, secondsAgo / month)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter.string(from: self)
        }
    }
    
    
    // yyyy-MM-dd
    private var hyphenFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    func asHyphenString() -> String {
        hyphenFormatter.string(from: self)
    }
    
    // yyyy年MM月dd日
    private var chineseFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    
    func asChineseDateString() -> String {
        chineseFormatter.string(from: self)
    }
}
