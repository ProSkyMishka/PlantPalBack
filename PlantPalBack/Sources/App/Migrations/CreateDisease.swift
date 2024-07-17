//
//  CreateDisease.swift
//  
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

struct CreateDisease: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("diseases")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("drugs", .array(of: .string), .required)
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("diseases").delete()
    }
}


