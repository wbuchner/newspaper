//
//  RelatedAssets.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import Foundation

struct RelatedAssets: Decodable {
    let id: Int?
    let categories: [Article.Category]?
    let authors: [Article.Author]?
    let url: String?
    let lastModified: Int?
    let sponsored: Bool?
    let assetType: Article.AssetType?
    let headline: String?
    let timeStamp: Int?
}
