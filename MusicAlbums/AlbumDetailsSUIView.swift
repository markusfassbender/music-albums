//
//  AlbumDetailsSUIView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI
import Models

struct AlbumDetailsSUIView: View {
    
    @State private var isFavoriteAlbum: Bool = false
    
    let album: Album
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                    
                    if album.image != nil {
                        Image(uiImage: album.image!)
                        .resizable()
                    }
                }
                .aspectRatio(1, contentMode: .fill)
                AlbumDetailsInformationSUIView(album: album)
                    .padding()
                AlbumDetailsTracksSUIView(tracks: album.tracks)
                    .padding()
            }
        }
    }
}
