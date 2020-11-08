//
//  DailyWeatherViewController.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DailyWeatherDisplayLogic: AnyObject {
    func displayWeather(viewModel: DailyWeather.GetWeather.ViewModel)
    func displayError(_ error: Error)
}

class DailyWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    var interactor: DailyWeatherBusinessLogic?
    var router: (NSObjectProtocol & DailyWeatherRoutingLogic & DailyWeatherDataPassing)?
    private let dailyWeatherView = DailyWeatherView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)

        DailyWeatherConfigurator().configure(viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        interactor?.getWeather()
    }

    private func setup() {
        title = "Daily weather"

        view.addSubview(dailyWeatherView)

        dailyWeatherView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension DailyWeatherViewController: DailyWeatherDisplayLogic {

    func displayWeather(viewModel: DailyWeather.GetWeather.ViewModel) {
        dailyWeatherView.setupData(viewModel)
    }
}
