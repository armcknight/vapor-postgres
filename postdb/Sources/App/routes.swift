import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    let mealController = MealController()
    router.get("", use: mealController.index)
    router.get("list", use: mealController.list)
    router.get("meals", use: mealController.index)
    router.post("meals", use: mealController.create)
}
