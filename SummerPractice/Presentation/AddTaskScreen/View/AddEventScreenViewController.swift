//
//  AddEventScreenViewController.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 06.07.2023.
//

import UIKit
import SnapKit
import CalendarKit

private enum Constants {
    static let textForTitleOfScreen: String = "Please enter all data for your event"
    static let placeholderOfNameTextField: String = "Enter the name of event"
    static let placeholderOfDescriptionTextField: String = "Enter the description for the event"
}

protocol IAddEventScreenViewController: AnyObject {
    func needToShowAlert(titleOfAlert: String, messageOfAlert: String)
    func updateCalendar(event: Event)
}

protocol AddEventScreenViewControllerOutput: AnyObject {
    func updateView(event: Event)
}

class AddEventScreenViewController: UIViewController, IAddEventScreenViewController {
    
    // Properties
    var presenter: IAddEventScreenPresenter!
    weak var output: AddEventScreenViewControllerOutput!
    
    private var startDateBuffer = Date()
    private var endDateBuffer = Date()
    
    // UI
    private lazy var titleOfScreenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.text = Constants.textForTitleOfScreen
        return label
    }()
    
    private lazy var nameOfEventTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.placeholderOfNameTextField
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var descriptionForTheEventTextFieled: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.placeholderOfDescriptionTextField
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var startTimePickerView: DatePickerWithLabelView = {
       return DatePickerWithLabelView(textOfLabel: "Starts at:", output: self)
    }()
    
    private lazy var endTimePickerView: DatePickerWithLabelView = {
        return DatePickerWithLabelView(textOfLabel: "End at:", output: self)
     }()
    
    private lazy var stackViewOfPickers: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            startTimePickerView,
            endTimePickerView
        ])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5
        return stackView
    }()
    
    private lazy var addEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add event", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addEventButtonDidTaped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View life cyrcle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Public
    
    func needToShowAlert(titleOfAlert: String, messageOfAlert: String) {
        let alertController = UIAlertController(title: titleOfAlert,
                                                message: messageOfAlert,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil)
        )
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func updateCalendar(event: Event) {
        output.updateView(event: event)
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = UIColor(red: 239/255, green: 238/255, blue: 246/255, alpha: 1)
        
        view.addSubview(titleOfScreenLabel)
        titleOfScreenLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview().inset(16)
            
        }
        
        view.addSubview(nameOfEventTextField)
        nameOfEventTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(titleOfScreenLabel.snp.bottom).offset(32)
            $0.height.equalTo(40)
        }
        
        view.addSubview(descriptionForTheEventTextFieled)
        descriptionForTheEventTextFieled.snp.makeConstraints {
            $0.top.equalTo(nameOfEventTextField.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        view.addSubview(stackViewOfPickers)
        stackViewOfPickers.snp.makeConstraints {
            $0.top.equalTo(descriptionForTheEventTextFieled.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(addEventButton)
        addEventButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(56)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func addEventButtonDidTaped() {
        presenter.needToSaveEvent(name: nameOfEventTextField.text,
                                  description: descriptionForTheEventTextFieled.text,
                                  startDate: startDateBuffer,
                                  endDate: endDateBuffer)
    }
}

// MARK: - DatePickerWithLabelViewOutput

extension AddEventScreenViewController: DatePickerWithLabelViewOutput {
    func needToSendNewDate(pickerDate: Date, isStartDateChanged: Bool) {
        if isStartDateChanged {
            startDateBuffer = pickerDate
        } else {
            endDateBuffer = pickerDate
        }
    }
}
