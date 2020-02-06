//
//  AlbumDetailsTracksView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI
import Models

struct OrderedTrack {
    let rank: Int
    let title: String
}

struct AlbumDetailsTracksView: View {
    
    let orderedTracks: [OrderedTrack]
    
    init(tracks: [String]?) {
        if let tracks = tracks, !tracks.isEmpty {
            orderedTracks = zip(1...tracks.count, tracks)
                .map { OrderedTrack(rank: $0, title: $1) }
        } else {
            orderedTracks = []
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("tracks")
                .font(.title)
                .padding(.bottom)
            
            ForEach(orderedTracks, id: \.rank) { track in
                Text("\(track.rank) \(track.title)")
            }
        }
    }
}
