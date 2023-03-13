//
//  ArticlesViewModel+Utilities.swift
//  Newspaper
//
//  Created by Wayne Buchner on 10/3/2023.
//

import Foundation

extension ArticlesViewModel {

    static func sortArticles(articles: [Article]) -> [Article] {
        articles.sortListElements()
    }
}

extension Sequence where Iterator.Element == Article {

    /// sortListElements
    /// - Returns: Sorted [Article]
    func sortListElements() -> [Iterator.Element] {
        self.sorted { (item1, item2) -> Bool in
            return item1.timeStamp < item2.timeStamp
        }
    }
}
