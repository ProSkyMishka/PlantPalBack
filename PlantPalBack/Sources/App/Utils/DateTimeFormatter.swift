//
//  File.swift
//  
//
//  Created by Administrator on 18.07.2024.
//

import Foundation


class DateTimeFormatter {
    static var shared = DateTimeFormatter()
    
    private var dateFormatte = DateFormatter()
    
    init() {
        self.dateFormatte.locale = Locale(identifier: "en_GB")
        self.dateFormatte.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    func toString(date: Date) -> String {
        return dateFormatte.string(from: date)
    }
    
    func fromString(s: String) -> Date? {
        return dateFormatte.date(from: s)
    }
    
}
