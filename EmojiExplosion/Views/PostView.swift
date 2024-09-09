//
//  PostView.swift
//  EmojiExplosion
//
//  Created by Vinícius Salmont on 07/09/24.
//
import SwiftUI

struct PostView: View {
    let post: Post
    let onReaction: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            profileSection
            actionButtons
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color(.systemGray4), radius: 3, x: 0, y: 1)
    }

    private var profileSection: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)

            VStack(alignment: .leading, spacing: 4) {
                Text("John Doe")
                    .font(.headline)
                Text("@johndoe • 2h")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(post.content)
                    .font(.body)
                    .padding(.top, 2)
            }
        }
    }

    private var actionButtons: some View {
        HStack {
            ForEach(reactionData, id: \.emoji) { reaction in
                reactionButton(
                    emoji: reaction.emoji,
                    label: reaction.label,
                    systemImage: reaction.systemImage
                )
                Spacer()
            }
        }
        .padding(.top, 6)
        .foregroundColor(.gray)
    }

    private func reactionButton(emoji: String, label: String, systemImage: String) -> some View {
        Button(action: {
            onReaction(emoji)
        }) {
            HStack(spacing: 4) {
                Image(systemName: systemImage)
                Text(label)
                    .font(.subheadline)
            }
        }
    }

    private var reactionData: [(emoji: String, label: String, systemImage: String)] {
        [
            (emoji: "👍", label: "Like", systemImage: "hand.thumbsup.fill"),
            (emoji: "❤️", label: "Love", systemImage: "heart.fill"),
            (emoji: "🔥", label: "Super Like", systemImage: "flame.fill"),
        ]
    }
}

#Preview {
    PostView(post: .init(id: 0, content: "Hey")) { _ in
    }
}
