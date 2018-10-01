import FluentPostgreSQL
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
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Configure database service
    let pgconfig = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "andrew", database: "vapor_pg_test", password: nil, transport: .cleartext)
    let postgres = PostgreSQLDatabase(config: pgconfig)
    var databases = DatabasesConfig()
    databases.add(database: postgres, as: .psql)
    services.register(databases)
    
    // Configure database migrations
    let migrations = MigrationConfig()
    services.register(migrations)
}
