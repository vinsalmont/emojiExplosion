//
//  EmojiExplosion.swift
//  EmojiExplosion
//
//  Created by Vinícius Salmont on 07/09/24.
//

import SwiftUI

struct Emoji: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var position: CGPoint
    var scale: CGFloat
    var opacity: Double
    var animation: Animation
}
