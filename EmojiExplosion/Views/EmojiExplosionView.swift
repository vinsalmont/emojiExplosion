//
//  EmojiExplosionView.swift
//
//
//  Created by Vinícius Salmont on 02/09/24.
//

import SwiftUI

public struct EmojiExplosionView: View {
    public let emoji: String
    @State private var emojis: [Emoji] = []

    public init(emoji: String) {
        self.emoji = emoji
    }

    public var body: some View {
        ZStack {
            ForEach(emojis) { emojiConfetti in
                Text(emojiConfetti.symbol)
                    .font(.system(size: CGFloat.random(in: 20 ... 50)))
                    .position(emojiConfetti.position)
                    .scaleEffect(emojiConfetti.scale)
                    .opacity(emojiConfetti.opacity)
                    .animation(emojiConfetti.animation, value: emojis)
            }
        }
        .onAppear {
            withAnimation {
                explodeConfetti()
            }
        }
    }

    private func explodeConfetti() {
        let centerX = UIScreen.main.bounds.width / 2
        let centerY = UIScreen.main.bounds.height / 2

        for _ in 0 ..< 50 {
            let randomX = CGFloat.random(in: -200 ... 200)
            let randomY = CGFloat.random(in: -200 ... 200)
            let position = CGPoint(x: centerX, y: centerY)
            let targetPosition = CGPoint(x: centerX + randomX, y: centerY + randomY)

            let emojiConfetti = Emoji(
                symbol: emoji,
                position: position,
                scale: 1.0,
                opacity: 1.0,
                animation: .easeOut(duration: 1)
                    .delay(Double.random(in: 0 ... 0.2))
            )

            emojis.append(emojiConfetti)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let index = emojis.firstIndex(of: emojiConfetti) {
                    emojis[index].position = targetPosition
                    emojis[index].scale = CGFloat.random(in: 0.5 ... 1.5)
                    emojis[index].opacity = 0
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            emojis.removeAll()
        }
    }
}
