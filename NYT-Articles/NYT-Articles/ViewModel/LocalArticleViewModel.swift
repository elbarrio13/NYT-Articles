//
//  LocalArticleViewModel.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import CoreData
import SwiftUI

class LocalArticleViewModel: ObservableObject {
    @Published var localArticles: [CDArticle]?
    static let shared = LocalArticleViewModel()

    let container: NSPersistentContainer

    init() {
        self.container = NSPersistentContainer(name: Constants.Data.CONTAINER_NAME)
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(Constants.Error.ERROR_LOADING_CORE_DATA + "\(error)")
            } else {
                debugPrint(Constants.Error.LOADED_CORE_DATA)
            }
        }
        fetchArticles()
    }

    /**
     Call this function to commit unsaved changes to the container
.
     */
    func save() {
        do {
            try container.viewContext.save()
            fetchArticles()
        } catch {
            debugPrint(Constants.Error.ERROR_SAVIG_DATA + "\(error)")
        }
    }

    /**
     Call this function to fetch all the articles stored locally.
.
     */
    func fetchArticles() {
        let request = NSFetchRequest<CDArticle>(entityName: Constants.Data.ARTICLE_ENTITY)
        do {
            localArticles = try container.viewContext.fetch(request)
        } catch {
            debugPrint(Constants.Error.ERROR_FETCHING_ARTICLES + "\(error)")
        }
    }

    /**
     Call this function to fetch an article stored locally by its title.

     - Parameter title: The title of the article to be fetch.
     - Returns: A bool indicating if the article was stored locally.
     */
    func fetchByTitle(with title: String) -> Bool {
        let request = NSFetchRequest<CDArticle>(entityName: Constants.Data.ARTICLE_ENTITY)
        do {
            request.predicate = NSPredicate(format: "title == %@", title)
            localArticles = try container.viewContext.fetch(request)
            if localArticles?.first != nil {
                return true
            }
        } catch {
            debugPrint(Constants.Error.ERROR_FETCHING_ARTICLES + "\(error)")
        }
        return false
    }

    /**
     Call this function to store an article locally.

     - Parameter article: The article to be added.
     */
    func add(article: CDArticle) {
        var newArticle = CDArticle(context: container.viewContext)
        newArticle.section = article.section
        newArticle.title = article.title
        newArticle.imageURL = article.imageURL
        newArticle.caption = article.caption
        newArticle.byline = article.byline
        newArticle.updatedDate = article.updatedDate
        newArticle.abstract = article.abstract
        save()
    }

    /**
     Call this function to delete a dowloaded article.

     - Parameter article: The article to be eliminated.
     */
    func delete(article: CDArticle) {
        let article = localArticles!.first(where: { $0.title == article.title }
        )!
        container.viewContext.delete(article)
        save()
    }

    /**
     Call this function to delete a dowloaded article.

     - Parameter indexSet: The index of article to be eliminated.
     */
    func delete(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let article = localArticles![index]
        container.viewContext.delete(article)
        save()
    }
}
