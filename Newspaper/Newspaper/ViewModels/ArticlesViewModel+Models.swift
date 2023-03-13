//
//  ArticlesViewModel+Models.swift
//  Newspaper
//
//  Created by Wayne Buchner on 13/3/2023.
//

import Foundation

extension ArticlesViewModel {

    /// CategoryViewModel
    /// used to wrap the display values for the interface grid.
    struct CategoryViewModel: Identifiable {
        let id = UUID()
        let categoryDisplayName: String
        let articles: [ArticleViewModel]
    }

    struct ArticleViewModel: Identifiable {
        let id = UUID()
        let headline: String
        let theAbstract: String
        let byLine: String
        let thumbnailURL: URL
        let accessibility: AccessibilityInfo
        let link: String
    }
}
