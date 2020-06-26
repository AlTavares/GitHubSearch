//
//  ViewExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import SwiftUI

extension View {
    func asAnyView() -> AnyView {
        return AnyView(self)
    }

    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
