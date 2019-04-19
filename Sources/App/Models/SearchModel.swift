//
//  SearchModel.swift
//  App
//
//  Created by Divine Dube on 2019/04/17.
//

import Foundation
import Vapor

struct SearchModel: Content {
    var location: String
    var query: String
}
