//
//  SongModel.swift
//  Songhound
//
//  Created by Divine Dube on 2019/03/01.
//  Copyright © 2019 Divine Dube. All rights reserved.
//

import Foundation
import Vapor
//import ObjectMapper

struct SongModel: Content {
    var id: UInt = 0
    var name: String = ""
    var artistName: String = ""
    var albumName: String = ""
    var genre: String = ""
    var popularity: Int = 0
    var artworkURL: String = ""
   // var artist: ArtistModel = ArtistModel()
}

/*
     try this so that we can remove the songs model
 
     func mapping(map: Map) {
     distance <- map["distance.value"]
     }
 */
//
//extension SongModel: Mappable {
//    init?(map: Map) {
//    }
//
//    mutating func mapping(map: Map) {
//        id <- map["collectionId"]
//        name <- map["trackName"]
//        artworkURL <- map["artworkUrl100"]
//        artistName <- map["artistName"]
//        albumName <- map["collectionName"]
//        genre <- map["genre"]
//        // initialise the artist also
//        artist.name <- map["artistName"]
//        artist.artistID <- map["artistId"]
//    }
//}
