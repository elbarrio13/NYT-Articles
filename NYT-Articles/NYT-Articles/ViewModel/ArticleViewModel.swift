//
//  ArticleViewModel.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import CoreData
import SwiftUI

class ArticleViewModel: ObservableObject {
    @Published var cdarticles: [CDArticle]? = []
    static let shared = ArticleViewModel()

    /**
     Call this function to fetch and decode data from an http api

     */
    func fetchData() async {
        do {
            let url = URL(
                string:
                    Constants.API.URL + Constants.API.API_KEY
            )!
            let (data, _) = try await URLSession.shared.data(from: url)

            do {
                let decodedData = try JSONDecoder().decode(
                    Result.self, from: data)
                parseData(article: decodedData)
            } catch {
                fatalError(
                    Constants.Error.COULD_NOT_PARSE + "\(data) "
                        + Constants.Error.AS + "\(Result.self):\n\(error)")
            }
        } catch {
            fatalError(Constants.Error.ERROR_FETCHING_DATA + "\(error)")
        }
    }

    /**
     Call this function to fetch and decode data from a json file. Just for testing purposes

     - Parameter filename: The filename string with extension.
     - Returns: The decoded data in a generic <T> model
     for the detail screen.
     */
    func fetchData<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard
            let file = Bundle.main.url(
                forResource: filename, withExtension: nil)
        else {
            fatalError(Constants.Error.ERROR_FINDING_FILE)
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError(Constants.Error.ERROR_LOADING_FILE + "\(error)")
        }

        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            parseData(article: decodedData as! Result)
            return decodedData
        } catch {
            fatalError(
                Constants.Error.COULD_NOT_PARSE + "\(data) "
                    + Constants.Error.AS + "\(T.self):\n\(error)")
        }
    }

    /**
     Call this function to parse the data from the API (Result) to a new model (CDArticles). This is not
     the most efficient way to do it, but it helps me to solve some issues with CoreData/SwiftData.

     - Parameter article: The list of articles that comes from the API in a different decoded model.
     */
    func parseData(article: Result) {
        article.results.forEach({ article in
            let newArticle = CDArticle(
                context: LocalArticleViewModel.shared.container
                    .viewContext)
            newArticle.section = article.section
            newArticle.title = article.title
            newArticle.imageURL =
                article.media.isEmpty
                ? "" : article.media[0].mediaMetaData[2].url
            newArticle.caption =
                article.media.isEmpty
                ? "" : article.media[0].caption
            newArticle.byline = article.byline
            newArticle.updatedDate = article.updated
            newArticle.abstract = article.abstract
            cdarticles!.append(newArticle)
        })
    }

}
