//
//  Color.swift
//  V2EX
//
//  Created by kim on 2024/11/13.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let body = Color("BodyColor")
    let secondary = Color("SecondaryColor")
    let background = Color("BackgroundColor")
    let surface = Color("SurfaceColor")
    let border = Color("BorderColor")
    let caption = Color("CaptionColor")
    let title = Color("TitleColor")
    let tabBarNormal = Color("TabBarButtonSelectedColor")
    let dager = Color("DangerColor")
    let dark = Color("DarkColor")
}
