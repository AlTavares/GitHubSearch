//
//  ImageLoader.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Combine
import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
    struct ImageNotAvailable: LocalizedError {
        var errorDescription: String? {
            "Image not available"
        }
    }

    @Published var state: ValueState<UIImage> = .idle
    @Locatable private var cache: ImageCache
    private var task: AnyCancellable?

    func loadImage(from url: URLConvertible) {
        state = .loading
        task?.cancel()
        guard let url = url.url else {
            return state = .error(ImageNotAvailable())
        }
        if let image = cache[url] {
            state = .loaded(image)
        }
        task = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                try UIImage(data: data).unwrap()
            }
            .receive(on: DispatchQueue.main)
            .cache(to: cache, key: url)
            .map(ValueState.loaded)
            .catch { Just(ValueState.error($0)) }
            .assign(to: \.state, on: self)
    }
}
