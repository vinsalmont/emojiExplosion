//
//  FeedView.swift
//  EmojiExplosion
//
//  Created by Vinícius Salmont on 07/09/24.
//

import SwiftUI

struct FeedView: View {
    @State private var selectedEmoji = ""
    @State private var showExplosion = false

    let posts = [
        Post(id: 1, content: "Had the best coffee today! ☕️"),
        Post(id: 2, content: "Just finished a 5k run 🏃‍♂️"),
        Post(id: 3, content: "Vacation vibes 🌴"),
    ]

    var body: some View {
        ZStack {
            ScrollView {
                ForEach(posts) { post in
                    PostView(
                        post: post,
                        onReaction: { emoji in
                            selectedEmoji = emoji
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                showExplosion = true
                            }
                        }
                    )
                    .disabled(showExplosion)
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .blur(radius: showExplosion ? 10 : 0)

            if showExplosion {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()

                EmojiExplosionView(emoji: selectedEmoji)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showExplosion = false
                        }
                    }
            }
        }
        .animation(.easeInOut, value: showExplosion)
    }
}

#Preview {
    FeedView()
}
