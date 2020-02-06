//
//  AlbumDetailsInformationView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI
import Models
import DataStore

struct AlbumDetailsInformationView: View {
    
    private struct Constants {
        static let minimumButtonSize = CGSize(width: 40, height: 40)
    }
    
    let album: Album
    
    @State private var isFavoriteAlbum: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(album.title)
                .foregroundColor(Color(Stylesheet.Color.title))
            Text(album.artist.name)
                .foregroundColor(Color(Stylesheet.Color.subTitle))
            Button(action: updateAlbum) {
                Image(systemName: buttonImageName)
            }
            .buttonStyle(ScalePressedButtonStyle())
            .frame(minWidth: Constants.minimumButtonSize.width,
                   minHeight: Constants.minimumButtonSize.height,
                   alignment: .topLeading)
        }.onAppear {
            self.isFavoriteAlbum = DataStore.shared.containsAlbum(self.album)
        }
    }
}

extension AlbumDetailsInformationView {
    
    var buttonImageName: String {
        isFavoriteAlbum ? "heart.fill" : "heart"
    }
    
    func updateAlbum() {
        do {
            if isFavoriteAlbum {
                try DataStore.shared.deleteAlbum(album)
            } else {
                try DataStore.shared.saveAlbum(album)
            }
        } catch {
            assertionFailure("album can not be stored!")
        }
        
        isFavoriteAlbum.toggle()
    }
}
