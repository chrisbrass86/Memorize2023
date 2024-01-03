//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Christoph Braß on 21.11.23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
