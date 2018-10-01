//
//  MealController.swift
//  App
//
//  Created by Andrew McKnight on 9/30/18.
//

import Foundation
import Routing
import Vapor

final class MealController {
    func index(_ req: Request) throws -> Future<View> {
        return Meal.query(on: req).all().flatMap(to: View.self) { meals in
            let context = ["meals": meals]
            return try req.view().render("home", context)
        }
    }
    
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Meal.self).flatMap { meal in
            return meal.save(on: req).map(to: Response.self) { _ in
                return req.redirect(to: "/")
            }
        }
    }
    
    func list(_ req: Request) -> Future<[Meal]> {
        return Meal.query(on: req).all()
    }
}
