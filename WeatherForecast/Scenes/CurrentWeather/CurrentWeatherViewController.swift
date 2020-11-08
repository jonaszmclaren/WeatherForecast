//
//  CurrentWeatherViewController.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CurrentWeatherDisplayLogic: AnyObject {
    func displayCurrentWeather(viewModel: CurrentWeather.GetCurrentWeather.ViewModel)
    func displayError(_ error: Error)
}

class CurrentWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    var interactor: CurrentWeatherBusinessLogic?
    var router: (NSObjectProtocol & CurrentWeatherRoutingLogic & CurrentWeatherDataPassing)?
    private let currentWeatherView = CurrentWeatherView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)

        CurrentWeatherConfigurator().configure(viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        interactor?.getCurrentWeather()
    }

    private func setup() {
        title = "Current weather"

        view.addSubview(currentWeatherView)

        currentWeatherView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CurrentWeatherViewController: CurrentWeatherDisplayLogic {

    func displayCurrentWeather(viewModel: CurrentWeather.GetCurrentWeather.ViewModel) {
        currentWeatherView.setupData(viewModel)
    }
}
