//
//  String.swift
//  V2EX
//
//  Created by kim on 2024/11/27.
//

import Foundation
import SwiftUI

extension String {
    // 将 HTML 格式文本转成富文本
    func convertHTMLToAttributedString() -> AttributedString {
        do {
            let attr = try NSAttributedString(
                data: Data(self.utf8),
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
            var atttibutedString = AttributedString(attr)
            atttibutedString.foregroundColor = .body
            atttibutedString.font = .headline
            // 修改链接样式
            for run in atttibutedString.runs {
                if run.link != nil {
                    atttibutedString[run.range].foregroundColor = Color.theme.secondary
                    atttibutedString[run.range].underlineStyle = .single
                }
            }
            
            return atttibutedString
        } catch {
            return AttributedString()
        }
    }
    
    // 多语言适配
    var localized: String {
        @AppStorage("language") var language: AppLanguage = .auto
        if let path = Bundle.main.path(forResource: language.name, ofType: "lproj") {
            return NSLocalizedString(self, tableName: "V2EXLocalizable", bundle: Bundle(path: path) ?? .main, comment: "")
        } else {
            return self
        }
    }
}
