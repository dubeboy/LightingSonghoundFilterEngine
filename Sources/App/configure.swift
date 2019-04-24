import FluentSQLite
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentSQLiteProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    middlewares.use(FileMiddleware.self)
    services.register(middlewares)

    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    let dirConfig = DirectoryConfig.detect()
    services.register(dirConfig)
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    let db = try SQLiteDatabase(storage: .file(path: "\(dirConfig.workDir)locationModelValuesCache.db"))
    databases.add(database: db, as: .sqlite)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: LocationModelValue.self, database: .sqlite)
    services.register(migrations)
}
