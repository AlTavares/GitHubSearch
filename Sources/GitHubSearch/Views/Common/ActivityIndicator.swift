//
//  ActivityIndicator.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
