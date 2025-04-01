//
//  AppConstants.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import Foundation

struct Constants {
    struct Content {
        static let ARTICLES = "Articles"
        static let OK = "Ok"
        static let LOADING_ARTICLES = "Loading articles..."
        static let INPUT_FORMAT_DATE = "yyyy-MM-dd HH:mm:ss"
        static let OUTPUT_FORMAT_DATE = "d MMM y, HH:mm:ss"
        static let MONITOR = "Monitor"
        static let SAVE_ARTICLE = "Save article locally"
        static let ARTICLE_DOWNLOADED = "Article downloaded"
        static let ARTICLE_REMOVED = "Article removed from downloads"
        static let NO_INTERNET = "No Internet Connection"
        static let CHECK_CONNECTION =
            "Please check your connection and try again."
        static let NETWORK_NOT_AVAILABLE = "Network not available"
        static let TURN_ON_MOBILE_WIFI =
            "Turn on mobile data or use Wi-Fi to access data"
        static let DOWNLOAD_ARTICLE = "Download and article first"
        static let OFFLINE_ARTICLES = "Offline Articles"
        static let PHOTO_IMAGE = "photo"
        static let NEWSPAPER_IMAGE = "newspaper"
        static let NEWSPAPER_IMAGE_FILL = NEWSPAPER_IMAGE + ".fill"
        static let WIFI_EXCLAMATION_IMAGE = "wifi.exclamationmark"
        static let FOLDER_IMAGE = "folder"
        static let ARROR_DOWN_IMAGE = "arrow.down.circle"
    }

    struct API {
        static let URL =
            "https://api.nytimes.com/svc/mostpopular/v2/shared/7.json?api-key="
        static let API_KEY = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
        static let FILE_NAME = "articles.json"
    }

    struct Data {
        static let CONTAINER_NAME = "ArticlesContainer"
        static let ARTICLE_ENTITY = "CDArticle"
    }

    struct Error {
        static let AS = "as "
        static let DATE_CONVERSION_ERROR = "Date conversion failed"
        static let ERROR_FETCHING_DATA = "Error fetching data: "
        static let ERROR_FINDING_FILE =
            "Couldn't find \(API.FILE_NAME) in main bundle."
        static let ERROR_LOADING_FILE =
            "Couldn't load \(API.FILE_NAME) from main bundle:\n"
        static let COULD_NOT_PARSE = "Couldn't parse "
        static let ERROR_LOADING_CORE_DATA = "Error loading core data. "
        static let LOADED_CORE_DATA = "Loaded core data."
        static let ERROR_SAVIG_DATA = "Error saving data. "
        static let ERROR_FETCHING_ARTICLES = "Error fetching articles. "
    }
}
