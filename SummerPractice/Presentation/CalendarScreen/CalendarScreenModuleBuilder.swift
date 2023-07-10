//
//  CalendarScreenModuleBuilder.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 01.07.2023.
//

import Foundation
import CalendarKit
import UIKit

protocol ICalendarScreenModuleBuilder: AnyObject {
    func build() -> UIViewController
}

protocol CalendarScreenModuleBuilderOutput: AnyObject {
    func openDetailsScreen(event: Event)
}

final class CalendarScreenModuleBuilder: ICalendarScreenModuleBuilder {
    
    // Dependencies
    private weak var output: CalendarScreenModuleBuilderOutput?
    
    // MARK: - Initialization
    
    init(output: CalendarScreenModuleBuilderOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let interactor = CalendarScreenInteractor()
        let view = CalendarScreenViewController()
        let presenter = CalendarScreenPresenter(interactor: interactor, view: view, output: output!)
        interactor.output = presenter
        view.presenter = presenter
        return view
    }
}
