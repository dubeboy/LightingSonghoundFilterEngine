//
//  LocationModel.swift
//  App
//
//  Created by Divine Dube on 2019/04/18.
//

import Foundation
import Vapor
import FluentSQLite

typealias LocationModel = [String: LocationModelValue]

struct LocationModelValue: SQLiteModel {
    var id: Int?
    var name: String
    var songID: Int
}

/// Allows `LocationModelValue` to be used as a dynamic migration.
extension LocationModelValue: Migration { }

/// Allows `LocationModelValue` to be encoded to and decoded from HTTP messages.
extension LocationModelValue: Content { }

/// Allows `LocationModelValue` to be used as a dynamic parameter in route definitions.
extension LocationModelValue: Parameter { }
