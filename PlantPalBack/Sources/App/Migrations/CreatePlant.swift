//
//  CreatePlant.swift
//
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

struct CreatePlant: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("plants")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("imageURL", .string, .required)
            .field("temp", .string, .required)
            .field("humidity", .string, .required)
            .field("waterInterval", .int)
            .field("seconds", .int, .required)
            .field("MLID", .string, .required)
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("plants").delete()
    }
}
