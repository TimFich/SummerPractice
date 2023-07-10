//
//  CalendarScreenPresenter.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 01.07.2023.
//

import UIKit
import CalendarKit

protocol ICalendarScreenPresenter: AnyObject {
    var dataSource: [Event] { get set }
    
    func wantsToOpenDetails(event: Event)
    func needToGetStartEvents()
}

final class CalendarScreenPresenter: ICalendarScreenPresenter {

    // Dependencies
    private var interactor: ICalendarScreenInteractor
    weak var view: ICalendarScreenViewController?
    
    // Properties
    private let addEventMB: IAddEventModuleBuilder = AddEventModuleBuilder()
    var dataSource: [Event] = []
    private let mbOutput: CalendarScreenModuleBuilderOutput!
    
    // MARK: - Initialization
    
    init(interactor: ICalendarScreenInteractor,
         view: ICalendarScreenViewController,
         output: CalendarScreenModuleBuilderOutput) {
        self.interactor = interactor
        self.view = view
        self.mbOutput = output
    }
    
    // MARK: - Public
    
    func wantsToOpenDetails(event: Event) {
        mbOutput.openDetailsScreen(event: event)
    }
    
    func needToGetStartEvents() {
        interactor.getStartEvents {
            self.dataSource = $0
            self.view?.reloadCalendar()
        }
    }
}

// MARK: - CalendarScreenInteractorOutput

extension CalendarScreenPresenter: CalendarScreenInteractorOutput {
}
