//
//  Common.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//


import Foundation

/// This was used for testing purposes to fetch the articles from a json file
let exampleData: Result = ArticleViewModel.shared.fetchData(Constants.API.FILE_NAME)

/**
 Call this function to format a string to date, for the publish date of the articles

 - Parameter date: The string date to be formatted.
 - Returns: The string of a formatted date
 */
func formatDate(_ date: String)-> String {
    //let dateString = "2020-11-25T18:01:55Z"
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.Content.INPUT_FORMAT_DATE
    if let formatedDate = formatter.date(from: date) {
        formatter.dateFormat = Constants.Content.OUTPUT_FORMAT_DATE
       return formatter.string(from: formatedDate)
    } else {
        fatalError(Constants.Error.DATE_CONVERSION_ERROR)
    }
}
