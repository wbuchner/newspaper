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
        let model = ArticlesViewModel.CategoryViewModel(
            categoryDisplayName: "Category",
            articles: articles
        )
        // when
        var state = await viewModel.$viewState.first().values.first(where: { _ in true })

        // then
        XCTAssertEqual(state, .loading)

        // when
        try? await viewModel.fetchArticles(url: Configuration().path)
        state = await viewModel.$viewState.first().values.first(where: { _ in true })

        // then
        XCTAssertNotEqual(state, .loading)
        XCTAssertEqual(state, .loaded([model]))

        // when
        try? await viewModel.fetchArticles(url: nil)
        state = await viewModel.$viewState.first().values.first(where: { _ in true })

        // then
        XCTAssertNotEqual(state, .loading)
        XCTAssertEqual(state, .failure(.missingURL))
    }

    func testSortArticles() throws {
        // given
        let articles: Articles = try! Articles.decodeDict(file: "articles.json", bundle: .test)!
        let unsortedArticles = [1520647701, 1520647658, 1520646312, 1520647146, 1520644137, 1520647407, 1520646765, 1520647357, 1520647353, 1520647423, 1520634608, 1520646235, 1520646239, 1520646482, 1520647153, 1520641316, 1520647080, 1520647073, 1520646864, 1520646712, 1520643392, 1520647200, 1520647187, 1520644176, 1520646747, 1520644944, 1520646715, 1520646737, 1520646872]
        let sortedArticles = [1520641316, 1520644176, 1520646737, 1520646872, 1520646715, 1520647073, 1520647187, 1520646712, 1520647080, 1520646864, 1520647200, 1520646747, 1520644944, 1520646239, 1520644137, 1520643392, 1520646765, 1520634608, 1520647353, 1520646235, 1520647153, 1520646482, 1520647357, 1520646312, 1520647146, 1520647407, 1520647423, 1520647658, 1520647701]

        // when articles are unsorted
        let assets = try XCTUnwrap(articles.assets)

        // then
        XCTAssertEqual(assets.map { $0.id }, unsortedArticles)

        // when
        let sorted = ArticlesViewModel.sortArticles(articles: assets)

        // then
        XCTAssertEqual(sorted.map { $0.id } , sortedArticles)
    }

    func testSmallestThumbnail() throws {
        // given
        let articles: Articles = try! Articles.decodeDict(
            file: "articles.json",
            bundle: .test)!

        // when
        let article = try XCTUnwrap(articles.assets?.first)

        // then
        XCTAssertEqual(article.thumbnail?.width, 375.0)
        XCTAssertEqual(article.thumbnail?.height, 250.0)
    }

    func testAccessibility() async throws {
        // A $28k ‘polish’ helped this north shore home break record by $1m by Michael Bleby, on Monday, March 13, 2023, Double tap to select article

        // given
        let viewModel = ArticlesViewModel(client: client)
        var state = await viewModel.$viewState.first().values.first(where: { _ in true })
        // when
        try? await viewModel.fetchArticles(url: Configuration().path)
        state = await viewModel.$viewState.first().values.first(where: { _ in true })
        if case .loaded(let model) = state {
            let article = try XCTUnwrap(model.first?.articles.first)
            XCTAssertEqual(
                "Silicon Valley Bank collapse: Unpredictable contagion and big risk lessons by James Thomson, on Saturday, March 11, 2023, Double tap to select article",
                article.accessibility.label)
        }
    }
}
