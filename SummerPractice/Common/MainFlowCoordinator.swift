//
//  MainFlowCoordinator.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 01.07.2023.
//

import UIKit
import CalendarKit

protocol FlowCoordinatorProtocol: AnyObject {
    func start(animated: Bool)
}

final class MainFlowCoordinator: FlowCoordinatorProtocol {
    
    //  Properties
    weak var parentViewController: UINavigationController?

    // MARK: - Initialization

    init(parentViewController: UINavigationController?) {
        self.parentViewController = parentViewController
    }

    func start(animated: Bool) {
        let mainBuilder = CalendarScreenModuleBuilder(output: self)
        let view = mainBuilder.build()
        parentViewController?.pushViewController(view, animated: animated)
    }
}

extension MainFlowCoordinator: CalendarScreenModuleBuilderOutput {
    func openDetailsScreen(event: Event) {
        let vc = DetailsEventScreenMobuleBuilder().build() as! DetailsScreenViewController
        vc.event = event
        parentViewController?.pushViewController(vc, animated: true)
    }
}
