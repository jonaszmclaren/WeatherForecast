//
//  ForecastView.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import UIKit

class ForecastView: UIView {

    // MARK: - Properties

    private let tableView = WFTableView(cellTypes: [CurrentWeatherTableViewCell.self, DailyWeatherTableViewCell.self])

    // MARK: - Init

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupView(dataSourceAndDelegate: (UITableViewDataSource & UITableViewDelegate)) {
        backgroundColor = .systemBackground
        
        addSubview(tableView)
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func reloadData() {
        tableView.reloadData()
    }
}
