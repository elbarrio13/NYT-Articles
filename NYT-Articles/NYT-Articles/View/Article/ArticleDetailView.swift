//
//  ArticleDetailView.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import SwiftUI

struct ArticleDetailView: View {
    @StateObject private var viewModel = LocalArticleViewModel()
    @State var isDownloaded = false
    @State var showingAlert = false
    var article: CDArticle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(article.title!)
                    .font(.title)
                Group {
                    AsyncImageView(
                        url: article.imageURL!
                    )
                    .clipped()
                    .cornerRadius(5)
                    Text(
                        article.caption!
                    )
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.byline!)
                        .font(.caption.weight(.heavy))
                        .foregroundColor(.secondary)

                    Text(formatDate(article.updatedDate!))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Text(article.abstract!).font(.subheadline)

            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .navigationTitle(article.section!)
        .navigationBarTitleDisplayMode(.inline).toolbar {

            Button(action: {
                withAnimation {
                    self.isDownloaded
                        ? viewModel.delete(article: article)
                        : viewModel.add(article: article)
                    self.isDownloaded.toggle()
                    self.showingAlert = true
                }
            }) {
                Label(
                    Constants.Content.SAVE_ARTICLE,
                    systemImage: Constants.Content.ARROR_DOWN_IMAGE + "\(self.isDownloaded ? ".fill" : "")"
                )

            }
        }
        .onAppear {
            self.isDownloaded = viewModel.fetchByTitle(
                with: article.title!)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(
                    self.isDownloaded
                    ? Constants.Content.ARTICLE_DOWNLOADED
                    : Constants.Content.ARTICLE_REMOVED),
                dismissButton: .default(Text(Constants.Content.OK))
            )
        }
    }
}

#Preview {
    NavigationView {
        ArticleDetailView(
            article: LocalArticleViewModel.shared.localArticles![0])
    }
}
