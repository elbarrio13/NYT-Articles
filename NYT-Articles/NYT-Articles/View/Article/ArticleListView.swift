//
//  ContentView.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var viewModel = ArticleViewModel()
    @StateObject private var networkMonitor = NetworkMonitor.shared
    @State var localArticles = false

    var body: some View {

        NavigationStack {
            VStack {
                if let articles = viewModel.cdarticles {
                    if networkMonitor.getNetworkState() == true {
                        List(articles, id: \.self.id) { article in
                            ArticleRowView(article: article)
                        }
                        .listStyle(GroupedListStyle())
                    } else {
                        ContentUnavailableView(
                            Constants.Content.NO_INTERNET,
                            systemImage: Constants.Content.WIFI_EXCLAMATION_IMAGE,
                            description: Text(
                                Constants.Content.CHECK_CONNECTION)
                        ).alert(isPresented: .constant(true)) {
                            Alert(
                                title: Text(Constants.Content.NETWORK_NOT_AVAILABLE),
                                message: Text(
                                    Constants.Content.TURN_ON_MOBILE_WIFI
                                ), dismissButton: .default(Text(Constants.Content.OK)))
                        }

                    }
                } else {
                    ProgressView(Constants.Content.LOADING_ARTICLES)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text(Constants.Content.ARTICLES))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button(
                            action: {
                                localArticles = true
                            },
                            label: {
                                Image(systemName: Constants.Content.FOLDER_IMAGE)
                            }
                        ).navigationDestination(isPresented: $localArticles) {
                            LocalArticleListView()                            
                        }
                }
            }
            
        }
        .refreshable {
            await viewModel.fetchData()
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    ArticleListView()
}
