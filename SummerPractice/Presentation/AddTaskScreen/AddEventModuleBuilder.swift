//
//  AddEventModuleBuilder.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 08.07.2023.
//

import Foundation
import UIKit

protocol IAddEventModuleBuilder: AnyObject {
    func build(output: AddEventScreenViewControllerOutput)-> UIViewController
}

final class AddEventModuleBuilder: IAddEventModuleBuilder {
    func build(output: AddEventScreenViewControllerOutput) -> UIViewController {
        let interactor = AddEventScreenInteractor()
        let view = AddEventScreenViewController()
        let presenter = AddEventScreenPresenter(interactor: interactor, view: view)
        view.presenter = presenter
        view.output = output
        return view
    }
}
