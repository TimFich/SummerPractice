//
//  EventModel.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 09.07.2023.
//

import Foundation

struct EventWrapper: Codable {
    let events: [EventModel]
}

struct EventModel: Codable {
    let name: String
    let description: String
    let startDate: Double
    let endDate: Double

    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case name, description
    }
}
