//
//  AsyncImageView.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import SwiftUI

struct AsyncImageView: View {
    var url: String
    var body: some View {
        if url.isEmpty {
            Image(systemName: Constants.Content.PHOTO_IMAGE)
        } else {
            AsyncImage(
                url: URL(
                    string: url)
            ) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFit()
                    
                } else if phase.error != nil {
                    Image(systemName: Constants.Content.NEWSPAPER_IMAGE)
                } else {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    AsyncImageView(url: exampleData.results[4].media[0].mediaMetaData[2].url)
}
