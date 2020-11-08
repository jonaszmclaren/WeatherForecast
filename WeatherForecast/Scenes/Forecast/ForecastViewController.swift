//
//  ForecastViewController.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol ForecastDisplayLogic: AnyObject {
    func displayCurrentWeather(viewModel: Forecast.GetCurrentWeather.ViewModel)
    func displayDailyWeather(viewModel: Forecast.GetDailyWeather.ViewModel)
    func displayError(_ error: Error)
}

class ForecastViewController: UIViewController {
    
    // MARK: - Properties

    var interactor: ForecastBusinessLogic?
    var router: (NSObjectProtocol & ForecastRoutingLogic & ForecastDataPassing)?
    private let forecastView = ForecastView()
    private var currentWeather: Forecast.GetCurrentWeather.ViewModel?
    private var dailyWeather: [Forecast.GetDailyWeather.ViewModel.Day] = []

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)

        ForecastConfigurator().configure(viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        let city = "Warszawa"
        interactor?.getCurrentWeather(request: Forecast.GetCurrentWeather.Request(city: city))
        interactor?.getDailyWeather(request: Forecast.GetDailyWeather.Request(city: city))
    }

    private func setup() {
        title = "Weather forecast"

        view.addSubview(forecastView)

        forecastView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        forecastView.setupView(dataSourceAndDelegate: self)
    }
}

extension ForecastViewController: ForecastDisplayLogic {

    func displayCurrentWeather(viewModel: Forecast.GetCurrentWeather.ViewModel) {
        currentWeather = viewModel
        forecastView.reloadData()
    }

    func displayDailyWeather(viewModel: Forecast.GetDailyWeather.ViewModel) {
        dailyWeather = viewModel.days
        forecastView.reloadData()
    }
}

extension ForecastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Forecast.Section.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Forecast.Section(rawValue: indexPath.row) {
        case .currentWeather:
            guard let currentWeather = currentWeather, let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.cellIdentifier, for: indexPath) as? CurrentWeatherTableViewCell else {
                return UITableViewCell()
            }

            cell.setupData(currentWeather)

            return cell
        case .dailyWeather:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.cellIdentifier, for: indexPath) as? DailyWeatherTableViewCell else {
                return UITableViewCell()
            }

            cell.setupData(dailyWeather)
            cell.delegate = self

            return cell
        case .none:
            return UITableViewCell()
        }
    }
}

extension ForecastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Forecast.Section(rawValue: indexPath.row) {
        case .currentWeather:
            router?.routeToCurrentWeather()
        default:
            return
        }
    }
}

extension ForecastViewController: DailyWeatherTableViewCellProtocol {

    func cellSelected(index: Int) {
        router?.routeToDailyWeather(index: index)
    }
}
