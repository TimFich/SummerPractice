//
//  DetailsEventScreenMobuleBuilder.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 09.07.2023.
//

import UIKit

protocol IDetailsEventScreenMobuleBuilder: AnyObject {
    func build() -> UIViewController
}

final class DetailsEventScreenMobuleBuilder: IDetailsEventScreenMobuleBuilder {
    func build() -> UIViewController {
        DetailsScreenViewController()
    }
}
