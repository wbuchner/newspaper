//
//  LinkView.swift
//  Newspaper
//
//  Created by Wayne Buchner on 13/3/2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlString: String?
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
    let url: String
    var body: some View {
        return WebView(urlString: url)
    }
}
