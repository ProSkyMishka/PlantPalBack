//
//  PlantsController.swift
//
//
//  Created by Михаил Прозорский on 07.07.2024.
//

import Vapor

struct PlantsController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let plantsGroup = routes.grouped("plants")
        
        plantsGroup.get(use: getAllHandler)
//        plantsGroup.post(use: createHandler)
        plantsGroup.get(":MLID", use: getHandler)
//        plantsGroup.put(":id", use: updateHandler)
    }
    
    
    @Sendable func createHandler(_ req: Request) async throws -> Plant {
        guard let plant = try? req.content.decode(Plant.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель продукта"))
        }
        
        try await plant.save(on: req.db)
        
        return plant
    }
    
    @Sendable func updateHandler(_ req: Request) async throws -> Plant {
        guard let plant = try await Plant.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        let plantUpdate = try req.content.decode(Plant.self)
        
        plant.name = plantUpdate.name
        plant.description = plantUpdate.description
        plant.imageURL = plantUpdate.imageURL
        plant.temp = plantUpdate.temp
        plant.humidity = plantUpdate.humidity
        plant.waterInterval = plantUpdate.waterInterval
        plant.seconds = plantUpdate.seconds
        plant.MLID = plantUpdate.MLID
        
        try await plant.save(on: req.db)
        
        return plant
    }
    
    @Sendable func getHandler(_ req: Request) async throws -> Plant {
        let mlid = req.parameters.get("MLID")
        guard let plant = try await Plant
            .query(on: req.db)
            .filter("MLID", .equal, mlid)
            .first() else {
            throw Abort(.notFound)
        }
        return plant
    }
    
    @Sendable func getAllHandler(_ req: Request) async throws -> [Plant] {
        let plants = try await Plant.query(on: req.db).all()
        return plants
    }
}
