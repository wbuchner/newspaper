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
        case loaded([Article])
        case failure(RequestErrors)
    }

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
                viewState = .loaded(response)
                updateArticles()
            }
        } catch {
            viewState = .failure(RequestErrors.errorFetchingData)
            isErrorHidden = false
        }
    }

    private func updateArticles() {
        guard case .loaded = viewState else {
            viewState = .failure(RequestErrors.errorFetchingData)
            isErrorHidden = false
            return
        }
    }
}
