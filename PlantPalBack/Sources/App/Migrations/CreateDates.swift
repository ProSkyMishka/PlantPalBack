//
//  File.swift
//  
//
//  Created by Administrator on 18.07.2024.
//

import Vapor
import Fluent

struct CreateDates: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("dates")
            .id()
            .field("date", .datetime, .required)
            .field("seconds", .int, .required)
            .field("device_id", .string, .required)
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("dates").delete()
    }
}
