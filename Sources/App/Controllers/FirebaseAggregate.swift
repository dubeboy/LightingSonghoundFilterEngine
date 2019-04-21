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
        print("called")
        return LocationModelValue
            .query(on: req)
            .all()
            .flatMap(to: LocationModel.self, { LocationModelValue in
                if LocationModelValue.count == 0 {
                    return try self.queryFromFirebase(req: req, location: location, query: query)
                } else {
                    var myLocationModels: [String: LocationModelValue] = [:]
                    for (i, locModelValue) in LocationModelValue.enumerated() {
                        myLocationModels["\(i)"] = locModelValue
                    }
                    return try myLocationModels.encode(for: req)
                        .flatMap(to: LocationModel.self) { xy in
                            return try xy.content.decode(LocationModel.self)
                    }
                }
            })
   }

    
    private func queryFromFirebase(req: Request , location: String , query: String) throws -> Future<LocationModel> {
        let url = "\(FIRE_BASE_URL)\(location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!).json"
        print("fire url: \(url)")
        let futureResponse: Future<Response> = try req.client().get(url)  // do network call here
        return futureResponse.flatMap(to: LocationModel.self) { res in
            print("the response from firebase: \(res)")

            let locationManager = try res.content.decode(LocationModel.self)
            return locationManager
        }
    }
    
    private func saveLocationModelsToLocalDB(locationModel: Future<LocationModel>) {
        // save to local DB
    }

}
