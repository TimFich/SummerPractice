//
//  AddEventScreenInteractor.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 08.07.2023.
//

import Foundation
import CalendarKit

protocol IAddEventScreenInteractor: AnyObject {
}

protocol AddEventScreenInteractorOutput: AnyObject {
}

class AddEventScreenInteractor: IAddEventScreenInteractor {
    
    // Properties
    weak var output: AddEventScreenInteractorOutput!

}
