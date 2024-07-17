//
//  User.swift
//  
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Fluent
import Vapor

final class User: Model, Content {
    static var schema: String = "users"
    
    @ID var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "password") var password: String
    @Field(key: "login") var login: String
//    @Field(key: "language") var language: String
    @Field(key: "avatar") var avatar: String
    @Field(key: "flowers") var flowers: [String]
//    @Field(key: "role") var role: String
    @Field(key: "likes") var likes: [String]
    
    final class Public: Content {
        var id: UUID?
        var name: String
        var login: String
//        var language: String
        var avatar: String
        var flowers: [String]
//        var role: String
        var likes: [String]
        
        init(id: UUID? = nil, name: String, login: String, /*language: String,*/ avatar: String, flowers: [String], /*role: String,*/ likes: [String]) {
            self.id = id
            self.name = name
            self.login = login
//            self.language = language
            self.avatar = avatar
            self.flowers = flowers
//            self.role = role
            self.likes = likes
        }
    }
}

extension User: ModelAuthenticatable {
    static var usernameKey = \User.$login
    static var passwordHashKey = \User.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}

extension User {
    func convertToPublic() -> User.Public {
        let pub = Public(id: self.id, name: self.name, login: self.login, /*language: self.language,*/ avatar: self.avatar, flowers: self.flowers/*, role: self.role*/, likes: self.likes)
        return pub
    }
}

enum Roles: String {
    case user = "user"
    case admin = "admin"
}
