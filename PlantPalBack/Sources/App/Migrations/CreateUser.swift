//
//  CreateUser.swift
//
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("password", .string, .required)
            .field("login", .string, .required)
//            .field("languige", .string, .required)
            .field("avatar", .string)
            .field("flowers", .array(of: .string))
//            .field("role", .string, .required)
            .field("likes", .array(of: .string))
            .unique(on: "login")
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("users").delete()
    }
}
