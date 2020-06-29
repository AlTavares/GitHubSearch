//
//  MarkdownView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 29/06/20.
//

import SwiftUI
import WebKit

struct MarkdownView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    let content: String
    private var bag = CancelBag()
    let webView = WKWebView()

    init(content: String) {
        self.content = content

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        webView.addSubview(activityIndicator)

        webView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        webView.publisher(for: \.isLoading)
            .sink { isLoading in
                isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            }.store(in: &bag)
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.loadHTMLString(createHTML(), baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(createHTML(), baseURL: nil)
    }
}

private extension MarkdownView {
    func createHTML() -> String {
        """
                <!DOCTYPE html>
                <html>
                <head>
                <meta name="viewport" content="width=\(UIScreen.main.bounds.width), initial-scale=1">
                <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/4.0.0/github-markdown.min.css">
                </head>
                <body>
                    \(content)
                </body>
                </html>
        """
    }
}
