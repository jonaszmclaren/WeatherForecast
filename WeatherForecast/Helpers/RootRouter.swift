//
//  RootRouter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import Foundation
import UIKit

enum Scene {
    case forecast
    case currentWeather
    case dailyWeather

    var viewController: UIViewController {
        switch self {
        case .forecast:
            return ForecastViewController()
        case .currentWeather:
            return CurrentWeatherViewController()
        case .dailyWeather:
            return DailyWeatherViewController()
        }
    }
}

class RootRouter {

    // MARK: - Properties

    let rootViewController: UINavigationController

    // MARK: - Init

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    // MARK: - Methods

    func start() {
        routeTo(scene: .forecast)
    }

    func routeTo(scene: Scene) {
        routeTo(scenes: [scene])
    }

    func routeTo(scenes: [Scene]) {
        let vcStack = scenes.map { $0.viewController }

        rootViewController.setViewControllers(vcStack, animated: true)
    }

    func routeTo(viewController: UIViewController) {
        routeTo(viewControllerStack: [viewController])
    }

    func routeTo(viewControllerStack: [UIViewController]) {
        rootViewController.setViewControllers(viewControllerStack, animated: true)
    }
}
