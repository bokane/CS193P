//
//  Theme.swift
//  Memorize
//
//  Created by Bo Kane on 3/15/21.
//

import Foundation
import SwiftUI

struct Theme<CardContent> where CardContent: Equatable {
    var themeName: String
    var themeColor: Color
    var numCards: Int
    var themeEmojis: Array<CardContent>
}



