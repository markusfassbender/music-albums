//
//  AlbumDetailsInformationSUIView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI
import Models
import DataStore

struct AlbumDetailsInformationSUIView: View {
    
    let album: Album
    
    @State private var isFavoriteAlbum: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(album.title)
                .foregroundColor(Color(Stylesheet.Color.title))
            Text(album.artist.name)
                .foregroundColor(Color(Stylesheet.Color.subTitle))
            Button(action: updateAlbum) {
                Image(systemName: isFavoriteAlbum ? "heart.fill" : "heart")
            }
            .buttonStyle(ScalePressedButtonStyle())
            .frame(minWidth: 40, minHeight: 40, alignment: .topLeading)
        }.onAppear {
            self.isFavoriteAlbum = DataStore.shared.containsAlbum(self.album)
        }
    }
}

extension AlbumDetailsInformationSUIView {
    
    func updateAlbum() {
        do {
            if isFavoriteAlbum {
                try DataStore.shared.deleteAlbum(album)
            } else {
                try DataStore.shared.saveAlbum(album)
            }
        } catch {
            fatalError("album can not be stored!")
        }
        
        isFavoriteAlbum.toggle()
    }
}
