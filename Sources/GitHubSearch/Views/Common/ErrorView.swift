//
//  ErrorView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import SwiftUI

struct ErrorView: View {
    var error: Error
    var retryHandler: (() -> Void)?
    var body: some View {
        VStack {
            Image(systemSymbol: retryHandler != nil ? .goforward : .exclamationmarkTriangle)
                .resizable()
                .frame(width: 50, height: 50)
                .onTapGesture {
                    self.retryHandler?()
            }
            Text(error.errorDescription ?? "An error occurred")
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: ImageLoader.ImageNotAvailable())
    }
}
