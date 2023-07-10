//
//  AddEventScreenPresenter.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 08.07.2023.
//

import Foundation
import CalendarKit

protocol IAddEventScreenPresenter: AnyObject {
    func needToSaveEvent(name: String?,
                         description: String?,
                         startDate: Date,
                         endDate: Date)
}

final class AddEventScreenPresenter: IAddEventScreenPresenter {
    
    // Dependencies
    private var interactor: IAddEventScreenInteractor
    weak var view: IAddEventScreenViewController?
    
    // MARK: - Initialization
    
    init(interactor: IAddEventScreenInteractor, view: IAddEventScreenViewController) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Public
    
    func needToSaveEvent(name: String?,
                         description: String?,
                         startDate: Date,
                         endDate: Date) {
        
        if validateData(name: name,
                        description: description,
                        startDate: startDate,
                        endDate: endDate) {
            let event = Event()
            event.text = name!
            event.description = description!
            event.dateInterval = DateInterval(start: startDate, end: endDate)
            
            view?.updateCalendar(event: event)
            view?.needToShowAlert(titleOfAlert: "Your event has been added", messageOfAlert: "")
        } else {
            view?.needToShowAlert(titleOfAlert: "Check your data", messageOfAlert: "")
        }
    }
    
    // MARK: - Private
    
    private func validateData(name: String?,
                              description: String?,
                              startDate: Date,
                              endDate: Date) -> Bool {
        guard let name = name,
              let description = description else { return false}
        
        if name.isEmpty || description.isEmpty || startDate > endDate { return false }
        
        return true
    }
}
