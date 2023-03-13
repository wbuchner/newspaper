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
        let articles: [Article]
    }
}
