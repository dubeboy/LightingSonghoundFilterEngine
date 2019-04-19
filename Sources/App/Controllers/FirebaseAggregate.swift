//
//  FirebaseAgrregate.swift
//  App
//
//  Created by Divine Dube on 2019/04/17.
//

import Foundation
import Vapor
import HTTP

class FirebaseAggregate {

    var FIRE_BASE_URL = "https://soundhound-1550224703779.firebaseio.com/"

    func create(_ req: Request) throws -> Future<[LocationModel]> {
        print("fefdfdsds")
        var j = try self.getQueryFirebaseData(req: req, location: "3", query: "swift")
        print("j:\(j)")
        return try req.content.decode(SearchModel.self).flatMap(to: [LocationModel].self) { searchModel in
            print("hello there the search model is \(searchModel)")
            let j = try self.getQueryFirebaseData(req: req, location: searchModel.location, query: searchModel.query)
            j.flatMap(to:  , )
            return j
        }
    }

    private func getQueryFirebaseData(req: Request, location: String, query: String) throws -> Future<[LocationModel]> {
        // ask for firebase data
        print("called")
        let url = "\(FIRE_BASE_URL)\(location).json"
        print("fire url: \(url)")
        let futureResponse: Future<Response> = try req.client().get(url)
        return futureResponse.flatMap(to: [LocationModel].self) { res in
            return res.content.decode([LocationModel].self)
        }
    }
}
