//
//  URLImage.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import SwiftUI

struct URLImageView: View {
    @ObservedObject private var imageLoader = ImageLoader()
    var placeholder: AnyView

    static let defaultPlaceholder = Image(systemSymbol: .camera)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 50)
        .asAnyView()

    init(url: URLConvertible,
         placeholder: AnyView = Self.defaultPlaceholder) {
        self.placeholder = placeholder
        imageLoader.loadImage(from: url)
    }

    var body: some View {
        StateView(state: imageLoader.state,
                  idleView: { self.wrapped(view: self.placeholder)},
                  loadedView: {
                      Image(uiImage: $0)
                          .resizable()
                          .asAnyView()
                  },
                  loadingView: { self.wrapped(
                      view: ActivityIndicator(isAnimating: true, style: .medium).asAnyView()
                  ) },
                  errorView: errorView)
    }

    private func wrapped(view: AnyView) -> AnyView {
        VStack {
            Spacer()
            view
            Spacer()
        }.asAnyView()
    }

    private func errorView(_ error: Error) -> AnyView {
        wrapped(view: VStack {
            URLImageView.defaultPlaceholder
            Text(error.errorDescription ?? "")
        }.asAnyView())
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(url: "https://lh3.googleusercontent.com/tm1DbZrAP0uBM-OJhLwvKir1Le5LglRF_bvbaNi6m-F_pIyttsWQz040soRY9pWA9PgNEYFA_fBkg_keYixRXCAjz9Q=s0w=200")
            .scaledToFit()
    }
}
