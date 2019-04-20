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
            let futureFilteredLocationModels: Future<LocationModel> = j.map(to: LocationModel.self) { location -> [String: LocationModelValue] in
                print("the location keys is this: \(location.keys) and the locatio5n from firebase is \(location)")
                var myLocationModels: [String: LocationModelValue] = [:]
                // should usef lambda x or for _, _ rather than this
                // does not have speling features
                location.keys.forEach() { key in
                    if (location[key]!.name.lowercased().contains(searchModel.query.lowercased())) {
                        // populate my key
                        myLocationModels[key] = location[key]
                    }
                }
                //todo: bad way to handle absence
                return myLocationModels
            }
            return futureFilteredLocationModels
        }
    }
    // should cache the data to a local storage
    // to mak th search faster yoh
    private func getQueryFirebaseData(req: Request, location: String, query: String) throws -> Future<LocationModel> {
        // ask for firebase data
        print("called")
        // force because I know that the string is not null and will never be null
        let url = "\(FIRE_BASE_URL)\(location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!).json"
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
