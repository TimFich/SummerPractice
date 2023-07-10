//
//  CalendarScreenViewController.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 01.07.2023.
//

import Foundation
import UIKit
import CalendarKit

protocol ICalendarScreenViewController: AnyObject {
    func reloadCalendar()
}

class CalendarScreenViewController: DayViewController, ICalendarScreenViewController {
    
    // Properties
    var presenter: ICalendarScreenPresenter!
    
    // UI
    private lazy var addTaskButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapButton))
        button.tintColor = .red
        return button
    }()
    
    
    // MARK: - View life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.needToGetStartEvents()
        configureUI()
    }
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return presenter.dataSource
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let event = eventView.descriptor as? Event else { return }
        
        presenter.wantsToOpenDetails(event: event)
    }
    
    // MARK: - Private
    
    private func configureUI() {
        title = "Your Diary"
        navigationItem.rightBarButtonItem = addTaskButton
    }
    
    func reloadCalendar() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func didTapButton() {
        let addEventVC = AddEventModuleBuilder().build(output: self)
        present(addEventVC, animated: true)
    }
}

extension CalendarScreenViewController: AddEventScreenViewControllerOutput {
    func updateView(event: Event) {
        presenter.dataSource.append(event)
        reloadCalendar()
    }
}
