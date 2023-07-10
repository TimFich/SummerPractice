//
//  DetailsScreenViewController.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 09.07.2023.
//

import UIKit
import CalendarKit
import SnapKit

final class DetailsScreenViewController: UIViewController {
    
    // Properties
    var event: Event?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3 * 60 * 60)
        return dateFormatter
    }()
    
    // UI
    private lazy var nameOfEventLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionOfEventLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameOfEventLabel,
            descriptionOfEventLabel,
            startTimeLabel,
            endTimeLabel
        ])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - View life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
        }
    }
    
    private func configureLabels() {
        
        guard let name = event?.text,
              let description = event?.description,
              let startDate = event?.dateInterval.start,
              let endDate = event?.dateInterval.end else { return }
        
        nameOfEventLabel.text = "Name: \(name)"
        descriptionOfEventLabel.text = "Description: \(description)"
        startTimeLabel.text = "Start at: \(dateFormatter.string(from: startDate))"
        endTimeLabel.text = "End at: \(dateFormatter.string(from: endDate))"
    }
}
