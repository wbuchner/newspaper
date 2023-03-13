//
//  ContentView.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    // An Observable View Model
    @StateObject private var viewModel = ArticlesViewModel()

    // The selected asset
    @State private(set) var selectedItem : Article?

    var body: some View {
        container {
            switch viewModel.viewState {
            case .loaded(let items):
                assetView(articles: items)
            case .loading:
                loadingView
            case .failure(let error):
                errorView(error: error)
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchArticles(url: Configuration().path)
                } catch {
                    print("🚨", error)
                }
            }
        }
        .padding(0)
    }
}

private extension ContentView {

    // This container allows the interface to display multipler SwiftUI Views
    func container<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack {
            VStack(spacing: 0) {
                content()
            }
            .navigationTitle("Articles")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.red)
    }

    // Addaptive colums with set width and Heights
    var columns: [GridItem] {
        return [
            .init(.adaptive(minimum: 300, maximum: 400 ), alignment: .top)
        ]
    }

    // View displayed when the `ArticlesViewModel` viewState == .loaded
    func assetView(articles: [ArticlesViewModel.CategoryViewModel]) -> some View {

        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                ForEach(articles.first!.articles) { asset in
                    LazyVStack(alignment: .leading, spacing: 12) {
                        KFImage.url(asset.thumbnail?.thumbnailURL)
                            .setProcessor(DefaultImageProcessor.default)
                            .placeholder {
                                // Placeholder while downloading.
                                Image(systemName: "arrow.2.circlepath.circle")
                                    .font(.largeTitle)
                                    .opacity(0.3)
                            }
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .cancelOnDisappear(false)
                            .resizable()
                            .frame(minWidth: 175, maxWidth: .infinity, minHeight: 128)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                                .aspectRatio(contentMode: .fit)
                                .accessibilityHidden(true)
                        Text(asset.headline ?? "")
                            .font(.headline)
                        Text(asset.theAbstract ?? "")
                            .font(.title3)
                            .accessibilityHidden(true)
                        Text(asset.byLine ?? "")
                            .font(.subheadline)
                            .accessibilityHidden(true)
                        Spacer()
                    }
                    .accessibilityHidden(false)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(asset.accessibility.label)
                    .padding(10)
                    .onTapGesture {
                        $selectedItem.wrappedValue = asset
                    }.sheet(item: $selectedItem) { asset in
                        LinkView(url: asset.url!)
                    }
                }
            }
        }
    }

    // View displayed when the `ArticlesViewModel` viewState == .loading
    var loadingView: some View {
        Color(.white)
            .ignoresSafeArea()
            .overlay(ProgressView())
    }

    // View displayed when the `ArticlesViewModel` viewState == .error
    func errorView(error: RequestErrors) -> some View {
        container {
            switch error {
            case .errorFetchingData:
                VStack {
                    Text("Error fetching Data Try Again.")
                    Button("Try Again") {
                        Task {
                            do {
                                try await viewModel.fetchArticles(url: Configuration().path)
                            } catch {
                                throw RequestErrors.errorFetchingData
                            }
                        }
                    }.padding()
                        .foregroundColor(.black)
                        .background(Color(UIColor.lightGray))
                        .clipShape(Capsule())
                }.border(.clear)
            case .missingURL: Text("Could not complete request")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    // For SwiftUI preview in the Canvas
    static var previews: some View {
        ContentView().assetView(articles:  try! [ArticlesViewModel.example()])
    }
}
