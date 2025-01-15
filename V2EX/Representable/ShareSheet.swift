//
//  ShareSheet.swift
//  V2EX
//
//  Created by kim on 2025/1/15.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any] // 要分享的内容
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No updates needed
    }
}

