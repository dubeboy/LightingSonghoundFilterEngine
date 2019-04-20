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

    //todo: should rename to search and should be a get with params
    func create(_ req: Request) throws -> Future<LocationModel> {
        print("fefdfdsds")
        return try req.content.decode(SearchModel.self).flatMap(to: LocationModel.self) { searchModel in
            print("hello there the search model is \(searchModel)")
            let j = try self.getQueryFirebaseData(req: req, location: searchModel.location, query: searchModel.query)
            let futureFilteredLocationModels: Future<LocationModel> = j.map(to: LocationModel.self) { location in
                if (location.name.contains(searchModel.query)) {
                    return location
                }
                return LocationModel(name: "", songID: "")
            }
            return futureFilteredLocationModels
        }
    }

    private func getQueryFirebaseData(req: Request, location: String, query: String) throws -> Future<LocationModel> {
        // ask for firebase data
        print("called")
        let url = "\(FIRE_BASE_URL)\(location).json".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print("fire url: \(url)")
        let futureResponse: Future<Response> = try req.client().get(url)
        return futureResponse.flatMap(to: LocationModel.self) { res in
            print("the response from firebase: \(res)")
            do {
                let locationManager = try res.content.decode(LocationModel.self)
                return locationManager
            } catch {
                throw Abort(.noContent)
            }
        }
    }
}
