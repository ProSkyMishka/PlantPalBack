//
//  CreateDrug.swift
//  
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

struct CreateDrug: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("drugs")
            .id()
            .field("name", .string, .required)
            .field("price", .int, .required)
            .field("description", .string, .required)
            .field("using_method", .string, .required)
            .field("imageURL", .string, .required)
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("drugs").delete()
    }
}

