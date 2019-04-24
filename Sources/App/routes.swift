import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    // router.get { req in
    //     return try 
    // }
    
    // // Basic "Hello, world!" example
    // router.get("hello") { req in
    //     return "Hello, world!"
    // }

    // Example of configuring a controller
    let firebaseAggregateController = FirebaseAggregate()
    let todo = TodoController()
    
    router.get("fire", use: firebaseAggregateController.searchForSongInArea)
    router.get(use: firebaseAggregateController.index)
    router.get("index", use: todo.index)
    router.post("todos", use: todo.create)
    router.delete("todos", Todo.parameter, use: todo.delete)
}
