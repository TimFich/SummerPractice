//
//  DatePickerWithLabelView.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 08.07.2023.
//

import UIKit
import SnapKit

protocol DatePickerWithLabelViewOutput: AnyObject {
    func needToSendNewDate(pickerDate: Date, isStartDateChanged: Bool)
}

final class DatePickerWithLabelView: UIView {

    // Dependencies
    private var output: DatePickerWithLabelViewOutput!
    
    // UI
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerDidChangeValue), for: .valueChanged)
        return datePicker
    }()
    
    // MARK: - Initialization
    
    init(textOfLabel: String, output: DatePickerWithLabelViewOutput) {
        super.init(frame: .zero)
        self.output = output
        self.layer.cornerRadius = 5
        configureUI()
        label.text = textOfLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configureUI() {
        self.addSubview(datePicker)
        datePicker.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview().inset(4)
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalTo(datePicker.snp.centerY)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(datePicker).offset(8)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func datePickerDidChangeValue() {
        if label.text == "Starts at:" {
            output.needToSendNewDate(pickerDate: datePicker.date, isStartDateChanged: true)
        } else {
            output.needToSendNewDate(pickerDate: datePicker.date, isStartDateChanged: false)
        }
    }
}
