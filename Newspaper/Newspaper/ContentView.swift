//
//  ContentView.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import SwiftUI
import WebKit
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = ArticlesViewModel()

    var body: some View {
        container {
            switch viewModel.viewState {
            case .loaded(let items):
                articleView(articles: items)
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

    func articleView(articles: [ArticlesViewModel.CategoryViewModel]) -> some View {
        List(articles) { article in

            Section(header: Text(article.categoryDisplayName).fontWeight(.bold)) {

                ForEach(article.articles) { asset in

                    VStack(alignment: .leading, spacing: 6) {
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
                            .cancelOnDisappear(true)
                            .resizable()
                                .frame(width: 175, height: 128)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                                .aspectRatio(contentMode: .fit)



                        Text(asset.theAbstract ?? "").font(.title2)
                        Text(asset.byLine ?? "").font(.subheadline)
                    }
                }
            }
        }
    }

    var loadingView: some View {
        Color(.white)
            .ignoresSafeArea()
            .overlay(ProgressView())
    }

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

    func linkView(url: String?) -> some View {
        return WebView(urlString: url)
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String?
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}

struct LinkView: View {
    var body: some View {
        WebView(urlString: "https://google.com")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().articleView(articles:  try! [ArticlesViewModel.example()])
    }
}
