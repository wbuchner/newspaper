//
//  ArticlesViewModelTests.swift
//  NewspaperTests
//
//  Created by Wayne Buchner on 9/3/2023.
//

import XCTest
import Combine

@testable import Newspaper

final class ArticlesViewModelTests: XCTestCase {

    private let client = MockNewsClient()
    private var cancellables: Set<AnyCancellable> = []

    @MainActor
    func testFetchClient() async throws {
        // given
        let viewModel = ArticlesViewModel(client: client)
        let articles: [Article] = try! Article.decode(file: "Article.json", bundle: .test)!

        // when
        var state = await viewModel.$viewState.first().values.first(where: { _ in true })

        // then
        XCTAssertEqual(state, .loading)

        // when
        try? await viewModel.fetchArticles(url: Configuration().path)
        state = await viewModel.$viewState.first().values.first(where: { _ in true })

        // then
        XCTAssertNotEqual(state, .loading)
        XCTAssertEqual(state, .loaded(articles))

        // when
        try? await viewModel.fetchArticles(url: nil)
        state = await viewModel.$viewState.first().values.first(where: { _ in true })

        // then
        XCTAssertNotEqual(state, .loading)
        XCTAssertEqual(state, .failure(.missingURL))
    }
}
