import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.http.server.configuration.address = .hostname("0.0.0.0", port: 8080)
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "0.0.0.0",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "plantpal_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "plantpal_password",
        database: Environment.get("DATABASE_NAME") ?? "plantpal_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateDisease())
    app.migrations.add(CreateDrug())
    app.migrations.add(CreateUser())
    app.migrations.add(CreatePlant())
    app.migrations.add(CreateDates())
    app.migrations.add(Filling())
    
    try await app.autoMigrate().get()

    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    // cors middleware should come before default error middleware using at: .beginning
    app.middleware.use(cors, at: .beginning)

    // register routes
    try routes(app)
}
