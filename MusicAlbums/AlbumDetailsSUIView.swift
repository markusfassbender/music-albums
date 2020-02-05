//
//  AlbumDetailsSUIView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI

struct AlbumDetailsSUIView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray)
                    .aspectRatio(1, contentMode: .fill)
                VStack(alignment: .leading) {
                    Text("Title")
                        .foregroundColor(Color(Stylesheet.Color.title))
                    Text("Artist")
                        .foregroundColor(Color(Stylesheet.Color.subTitle))
                    Button(action: callButton) {
                        Image(systemName: "heart")
                    }
                }
                .padding()
            }
        }
    }
}

extension AlbumDetailsSUIView {
    func callButton() {
        print("call button")
    }
}

struct AlbumDetailsSUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsSUIView()
    }
}
