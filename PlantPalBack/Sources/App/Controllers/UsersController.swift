//
//  UsersController.swift
//
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor

struct UsersController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let usersGroup = routes.grouped("users")
        usersGroup.post("signIn", use: createHandler)
        usersGroup.post("auth", use: authHandler)
        
        let basicMW = User.authenticator()
        let guardMW = User.guardMiddleware()
        let protectedGroup = usersGroup.grouped(basicMW, guardMW)
        
        protectedGroup.get(use: getHandler)
        protectedGroup.put(":id", use: updateHandler)
    }
    
    
    @Sendable func createHandler(_ req: Request) async throws -> User.Public {
        guard let user = try? req.content.decode(User.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель продукта"))
        }
        
        user.password = try Bcrypt.hash(user.password)
        try await user.save(on: req.db)
        
        return user.convertToPublic()
    }
    
    @Sendable func updateHandler(_ req: Request) async throws -> User.Public {
        guard let user = try await User.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let userUpdate = try req.content.decode(User.self)
        
        userUpdate.password = try Bcrypt.hash(userUpdate.password)
        
        user.name = userUpdate.name
        user.password = userUpdate.password
        user.login = userUpdate.login
//        user.language = userUpdate.language
        user.avatar = userUpdate.avatar
        user.flowers = userUpdate.flowers
//        user.role = userUpdate.role
        user.likes = userUpdate.likes
        
        try await user.save(on: req.db)
        
        return user.convertToPublic()
    }
    
    @Sendable func getHandler(_ req: Request) async throws -> User.Public {
        guard let user = req.auth.get(User.self) else {
            throw Abort(.unauthorized)
        }
        return user.convertToPublic()
    }
    
    @Sendable func authHandler(_ req: Request) async throws -> User.Public {
        let userDTO = try req.content.decode(AuthUserDTO.self)
        guard let user = try await User
            .query(on: req.db)
            .filter("login", .equal, userDTO.login)
            .first() else {
            throw Abort(.unauthorized)
        }
        
        let isPassEqual = try Bcrypt.verify(userDTO.password, created: user.password)
        
        guard isPassEqual else {
            throw Abort(.unauthorized)
        }
        
        return user.convertToPublic()
    }
}

struct AuthUserDTO: Content {
    let login: String
    var password: String
}
