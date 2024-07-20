//
//  File.swift
//  
//
//  Created by Administrator on 18.07.2024.
//

import Vapor

struct DatesController: RouteCollection {
    let secondsInDay = 24 * 60 * 60
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let datesGroup = routes.grouped("dates")
        
        datesGroup.get(":device_id", use: getHandler)
        datesGroup.post(use: postHandler)
    }
    
    @Sendable func postHandler(_ req: Request) async throws -> [WateringDate] {
        guard let wateringList = try? req.content.decode(WateringDTO.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель продукта"))
        }
        
        let wateringDates: [WateringDate] = try await WateringDate
            .query(on: req.db)
            .filter("device_id", .equal, wateringList.device_id)
            .all()
        
        for w in wateringDates {
            try await w.delete(on: req.db)
        }

        var dates: [WateringDate] = [WateringDate]()
        
        guard let startDate = DateTimeFormatter.shared.fromString(s: wateringList.startDate) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось перевести дату в нужный формат \(wateringList.startDate)"))
        }
        
        for i in 0..<wateringList.repeats {
            let d = startDate.addingTimeInterval(TimeInterval(i * wateringList.interval * secondsInDay))
            let wateringDate = WateringDate(date: d, seconds: wateringList.seconds, device_id: wateringList.device_id)
            try await wateringDate.save(on: req.db)
            dates.append(wateringDate)
        }
        
        return dates
    }
    
    @Sendable func getHandler(_ req: Request) async throws -> [WateringDate] {
        print(req.parameters)
        let device_id = req.parameters.get("device_id")
        let wateringDates = try await WateringDate
            .query(on: req.db)
            .filter("device_id", .equal, device_id)
            .all()
        return wateringDates
    }
}
