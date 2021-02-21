//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Bo Kane on 2/19/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
        }
    }
}
