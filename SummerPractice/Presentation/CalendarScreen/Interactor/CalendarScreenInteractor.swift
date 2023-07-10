//
//  CalendarScreenInteractor.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 01.07.2023.
//

import Foundation
import CalendarKit

protocol ICalendarScreenInteractor: AnyObject {
    func getStartEvents(completion: @escaping (([Event]) -> Void))
}

protocol CalendarScreenInteractorOutput: AnyObject {
}

final class CalendarScreenInteractor: ICalendarScreenInteractor {
    
    // Properties
    weak var output: CalendarScreenInteractorOutput!
    
    private let decoder = JSONDecoder()
    
    func getStartEvents(completion: @escaping (([Event]) -> Void)) {
        if let url = Bundle.main.url(forResource: "file", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let searchData = try decoder.decode([EventModel].self, from: data)
                
                let events = searchData.map {
                    let event = Event()
                    event.text = $0.name
                    event.description = $0.description
                    event.dateInterval = DateInterval(start: Date(timeIntervalSince1970: $0.startDate),
                                                      end: Date(timeIntervalSince1970: $0.endDate))
                    return event
                }
                
                completion(events)
            } catch {
                print("error:\(error)")
            }
        }
    }
}
