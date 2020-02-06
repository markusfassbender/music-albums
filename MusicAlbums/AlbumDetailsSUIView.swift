//
//  AlbumDetailsSUIView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI
import Models
import NetworkService

struct AlbumDetailsSUIView: View {
    
    @State var album: Album
    
    @State private var cancelToken: CancelToken?
    @State private var isFavoriteAlbum: Bool = false
    
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
                
                VStack(alignment: .leading) {
                    AlbumDetailsInformationSUIView(album: album)
                    AlbumDetailsTracksSUIView(tracks: album.tracks)
                }
                .padding([.leading, .trailing, .bottom])
            }
            .scaledToFit()
        }
        .onAppear {
            self.loadDetails()
        }.onDisappear() {
            self.cancelToken?.cancel()
        }
    }
}

extension AlbumDetailsSUIView {
    private func loadDetails() {
        cancelToken?.cancel()
        
        let resource = Album.allDetails(for: album)
        let token = CancelToken()
        cancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) {
            switch $0 {
            case .success(let album):
                DispatchQueue.main.async {
                    self.album = album
                }
            case .failure(let error):
                print(error) // just don't update interface for now
            }
        }
    }
}
