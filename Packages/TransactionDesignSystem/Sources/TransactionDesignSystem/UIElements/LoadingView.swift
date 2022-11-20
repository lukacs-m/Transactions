//
//  LoadingView.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import SwiftUI

public struct LoadingView: View {
    let title: LocalizedStringKey?

    /**
     Returns a Loading Screen.

     - Parameters:
        - text: The Text to display.
     */
    public init(title: LocalizedStringKey?) {
        self.title = title
    }

    public var body: some View {
        ZStack(alignment: .center) {
            Color.black.ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                .accessibility(hidden: true)
            if let title = title {
                VStack {
                    Spacer()
                    Text(title)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading View")
        .accessibility(identifier: "loadingview")
    }
}

struct LoadingView_Previews: PreviewProvider {
    static let text: LocalizedStringKey = "Loading"

    static var previews: some View {
        Group {
            LoadingView(title: text)
                .previewDisplayName("Light")
            LoadingView(title: text)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
