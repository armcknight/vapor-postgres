//
//  Meal.swift
//  App
//
//  Created by Andrew McKnight on 9/30/18.
//

import FluentPostgreSQL
import Foundation
import Vapor

final class Meal: PostgreSQLModel {
    var id: Int?
    var description: String
    
    init(description: String) {
        self.description = description
    }
}

extension Meal: Migration {}
extension Meal: Content {}
extension Meal: Parameter {}
