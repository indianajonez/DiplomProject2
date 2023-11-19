//
//  Album.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import Foundation

struct Album {
    var name: String
    var image: String
    var songs: [Song]
}
    
extension Album {
    static func get() -> [Album] {
        return [
            Album(name: "Acoustic", image: "acoustic", songs: [
                Song(name: "Acoustic Breez", image: "acoustic", artist: "Bensound", fileName: "bensound-itmighttakeawhile"),
                Song(name: "Acoustic Haha", image: "acoustic", artist: "Bensound", fileName: "bensound-pleasewatchmyback"),
            ]),
            Album(name: "Cinematic", image: "cinematic", songs: [
                Song(name: "Advanture", image: "cinematic", artist: "Bensound", fileName: "bensound-elevation"),
                Song(name: "Better Days", image: "cinematic", artist: "Bensound", fileName: "bensound-everyminuteisaneternity"),
                Song(name: "Epic", image: "cinematic", artist: "Bensound", fileName: "bensound-jambomambo"),
            ]),
            Album(name: "Jazz", image: "jazz", songs: [
                Song(name: "All That", image: "jazz", artist: "Bensound", fileName: "bensound-growingold"),
                Song(name: "All That", image: "jazz", artist: "Bensound", fileName: "bensound-jumpingbean"),
                
                
            ]),
            
        ]
        
    }
}

