//
//  File.swift
//  
//
//  Created by Administrator on 19.07.2024.
//

import Vapor

struct WateringController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let datesGroup = routes.grouped("water")
        
        datesGroup.get(":device_id", use: getHandler)
        datesGroup.post(use: postNowHandler)
    }
    
    @Sendable func getHandler(_ req: Request) async throws -> [String:Double] {
        let device_id = req.parameters.get("device_id")
        let obj = try await WateringDate
            .query(on: req.db)
            .filter("device_id", .equal, device_id)
            .sort(\.$date)
            .first()
        
        guard let obj = obj else {
            throw Abort(.custom(code: 404, reasonPhrase: "Устройство с device_id \(device_id ?? "none") не найдено"))
        }
        
        if (Date() >= obj.date) {
            try await obj.delete(on: req.db)
            return ["watering": 1, "timedelta": 0.25, "seconds": Double(obj.seconds)]
        }
        return ["watering": 0, "timedelta": 0.25, "seconds": Double(obj.seconds)]
    }
    
    @Sendable func postNowHandler(_ req: Request) async throws -> [WateringDate] {
        guard let wateringList = try? req.content.decode(NowWateringDTO.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель продукта"))
        }
        let wateringDate = WateringDate(date: Date(), seconds: wateringList.seconds, device_id: wateringList.device_id)
        try await wateringDate.save(on: req.db)
        
        let wateringDates: [WateringDate] = try await WateringDate
            .query(on: req.db)
            .filter("device_id", .equal, wateringList.device_id)
            .all()
        
        return wateringDates
        
    }
}
