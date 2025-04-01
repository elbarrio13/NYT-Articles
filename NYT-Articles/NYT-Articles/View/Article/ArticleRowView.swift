//
//  ArticleRowView.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import SwiftUI

struct ArticleRowView: View {
    var article: CDArticle
    var body: some View {
        NavigationLink(destination: ArticleDetailView(article: article)) {
            HStack(alignment: .center) {
                AsyncImageView(
                    url: article.imageURL!
                )
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(5)
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.title!).lineLimit(2)
                    Text(article.section!)
                        .font(.caption.weight(.heavy))
                }
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationView {
        ArticleRowView(article: ArticleViewModel.shared.cdarticles![0])
    }
}
