//
//  WFNavigationController.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import UIKit

class WFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = .wfTint
    }
}
