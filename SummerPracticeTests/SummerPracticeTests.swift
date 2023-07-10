//
//  SummerPracticeTests.swift
//  SummerPracticeTests
//
//  Created by Тимур Миргалиев on 29.06.2023.
//

import XCTest
import CalendarKit
@testable import SummerPractice

final class SummerPracticeTests: XCTestCase {

    func testOfGetingEventFromJsonFile() throws {
        // given
        let interactor = CalendarScreenInteractor()
        
        // then
        interactor.getStartEvents { events in
            XCTAssertTrue(events.count == 3)
            XCTAssertEqual(events[0].text, "Мероприятие 1")
            XCTAssertEqual(events[0].description, "Описание мероприятия 1")
            XCTAssertEqual(events[0].dateInterval.start.timeIntervalSince1970, 1688926982)
            XCTAssertEqual(events[0].dateInterval.end.timeIntervalSince1970, 1688934182)
        }
    }
}
