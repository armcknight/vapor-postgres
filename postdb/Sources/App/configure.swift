import FluentPostgreSQL
import Leaf
import Vapor

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register providers
    try services.register(FluentPostgreSQLProvider())
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Configure database service
    let pgConfig: PostgreSQLDatabaseConfig
    if let configuredDatabaseURL = ProcessInfo.processInfo.environment["DATABASE_URL"] {
        pgConfig = PostgreSQLDatabaseConfig(url: configuredDatabaseURL, transport: .cleartext)!
        print("using environment variable")
    } else {
        pgConfig = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "andrew", database: "vapor_pg_test", password: nil, transport: .cleartext)
        print("using debug")
    }
    let postgres = PostgreSQLDatabase(config: pgConfig)
    var databases = DatabasesConfig()
    databases.add(database: postgres, as: .psql)
    services.register(databases)
    
    // Configure database migrations
    var migrations = MigrationConfig()
    migrations.add(model: Meal.self, database: .psql)
    services.register(migrations)
}
