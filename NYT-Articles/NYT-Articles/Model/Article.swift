//
//  Article.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import Foundation
import CoreData

// MARK: - Result
class Result: Decodable, Identifiable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Article
class Article: Decodable {
    var uri: String
    var url: String
    var id: Int
    var assetID: Int
    var source: String
    var publishedDate: String
    var updated: String
    var section: String
    var subsection: String
    var nytdsection: String
    var adxKeywords: String
    var column: String?
    var byline: String
    var type: String
    var title: String
    var abstract: String
    var desFacet: [String]
    var orgFacet: [String]
    var perFacet: [String]
    var geoFacet: [String]
    var media: [Media]
    var etaID: Int

    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case adxKeywords = "adx_keywords"
        case column
        case byline
        case type
        case title
        case abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }

    init(
        uri: String, url: String, id: Int, assetID: Int, source: String,
        publishedDate: String, updated: String, section: String,
        subsection: String, nytdsection: String, adxKeywords: String,
        column: String?, byline: String, type: String, title: String,
        abstract: String, desFacet: [String], orgFacet: [String],
        perFacet: [String], geoFacet: [String], media: [Media], etaID: Int
    ) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetID = assetID
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
}

// MARK: - Media
class Media: Codable {
    var type: String
    var subtype: String
    var caption, copyright: String
    var approvedForSyndication: Int
    var mediaMetaData: [MediaMetaData]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetaData = "media-metadata"
    }

    init(
        type: String, subtype: String, caption: String, copyright: String,
        approvedForSyndication: Int, mediaMetaData: [MediaMetaData]
    ) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetaData = mediaMetaData
    }
}

// MARK: - MediaMetadatum
class MediaMetaData: Codable {
    let url: String
    let format: String
    let height, width: Int

    init(url: String, format: String, height: Int, width: Int) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}
