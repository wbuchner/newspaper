//
//  ArticlesViewModel.swift
//  Newspaper
//
//  Created by Wayne Buchner on 8/3/2023.
//

import Foundation
import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {

    private var client: NewsClient

    @Published private(set) var viewState: ViewState

    @Published var isErrorHidden = true

    init(client: NewsClient = NewsClient(),
         state: ViewState = ViewState.loading) {
        viewState = .loading
        self.client = client
    }
    /// ViewState
    /// loading states for the view
    enum ViewState: Equatable {
        static func == (lhs: ArticlesViewModel.ViewState, rhs: ArticlesViewModel.ViewState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading): return true
            case (.loading, .loaded): return false
            case (.loading, .failure): return false
            case (.loaded, .loaded): return true
            case (.loaded, .failure): return true
            case (.failure, .failure): return true
            case (.failure, .loading): return false
            case (.failure(_), .loaded(_)): return false
            case (.loaded(_), .loading): return false
            }
        }

        case loading
        case loaded([CategoryViewModel])
        case failure(RequestErrors)
    }

    /// fetchArticles
    /// - Parameter url: String
    /// - wraps a value the `.loaded` `viewState` based on success of the `NewsClient` call
    /// - throws an wrapped error in the `viewState`
    @MainActor func fetchArticles(url: URL?) async throws {
        viewState = .loading
        guard let url else {
            viewState = .failure(RequestErrors.missingURL)
            return
        }
        if !UIApplication.shared.canOpenURL(url) {
            viewState = .failure(RequestErrors.missingURL)
        }
        do {
            if let response = try await client.fetch(url: url) {
                let model = CategoryViewModel(
                    categoryDisplayName: response.displayName ?? "",
                    articles: response.assets?.map {
                        ArticleViewModel(
                            headline: $0.headline ?? "",
                            theAbstract: $0.theAbstract ?? "",
                            byLine: $0.byLine ?? "",
                            thumbnailURL: ($0.thumbnail?.thumbnailURL)!,
                            accessibility: $0.accessibility,
                            link: $0.url)
                    } ?? []
                )
                viewState = .loaded([model])
                updateArticles()
            }
        } catch {
            viewState = .failure(RequestErrors.errorFetchingData)
            isErrorHidden = false
        }
    }

    /// updateArticles
    /// - updates the wrapped value in the `.error` `viewState`
    private func updateArticles() {
        guard case .loaded = viewState else {
            viewState = .failure(RequestErrors.errorFetchingData)
            isErrorHidden = false
            return
        }
    }
}

extension ArticlesViewModel {
    // just a quick way to mock in data to the contentView for preview. Usually
    // I would not do this. Its a little of a double up but SwiftUI has its flaws
    // And as long as the data is sound, its only used for previewing the UI
    static func example() throws -> CategoryViewModel {
        guard let url = Bundle.main.url(forResource: "articles.json", withExtension: nil) else {
            throw FileNotFound()
        }
        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(Articles.self, from: data)
        let model = CategoryViewModel(
            categoryDisplayName: response.displayName ?? "",
            articles: response.assets?.map {
                ArticleViewModel(
                    headline: $0.headline ?? "",
                    theAbstract: $0.theAbstract ?? "",
                    byLine: $0.byLine ?? "",
                    thumbnailURL: ($0.thumbnail?.thumbnailURL)!,
                    accessibility: $0.accessibility,
                    link: $0.url)
            } ?? []
        )
        return model
    }
}
private struct FileNotFound: Error { }
