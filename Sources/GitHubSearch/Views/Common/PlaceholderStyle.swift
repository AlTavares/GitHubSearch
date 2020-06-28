//
//  PlaceholderStyle.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 28/06/20.
//

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: Text

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                placeholder
            }
            content
        }
    }
}
