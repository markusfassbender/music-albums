//
//  ScalePressedButtonStyle.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 05.02.20.
//

import SwiftUI

struct ScalePressedButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
