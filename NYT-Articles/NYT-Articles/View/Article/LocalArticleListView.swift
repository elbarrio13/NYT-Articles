//
//  LocalArticle.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import SwiftUI

struct LocalArticleListView: View {
    @StateObject private var localViewModel = LocalArticleViewModel()
    @State var localArticles = false

    var body: some View {

        NavigationStack {
            VStack {
                if localViewModel.localArticles!.count > 0 {
                    List {
                        ForEach(localViewModel.localArticles!) { article in
                            ArticleRowView(article: article)
                        }
                        .onDelete(
                            perform:
                                withAnimation {
                                    localViewModel.delete
                                }
                        )
                    }
                    .listStyle(GroupedListStyle())
                } else {
                    ContentUnavailableView(
                        Constants.Content.DOWNLOAD_ARTICLE,
                        systemImage: Constants.Content.NEWSPAPER_IMAGE_FILL)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text(Constants.Content.OFFLINE_ARTICLES))
        }
        .refreshable {
            localViewModel.fetchArticles()
        }
        .onAppear {
            localViewModel.fetchArticles()
        }
    }
}

#Preview {
    LocalArticleListView()
}
