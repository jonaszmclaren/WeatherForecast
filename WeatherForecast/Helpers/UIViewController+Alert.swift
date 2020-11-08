//
//  UIViewController+Alert.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 31/10/2020.
//

import UIKit
import Toast

protocol AlertableViewController {
    func displayToast(message: String)
    func displayError(_ error: Error)
}

extension UIViewController: AlertableViewController {

    func displayToast(message: String) {
        var style = ToastStyle()
        style.cornerRadius = 16.0
        style.verticalPadding = 20.0
        style.horizontalPadding = 20.0

        view.makeToast(message, point: CGPoint(x: view.bounds.size.width / 2.0, y: view.bounds.size.height - 60.0), title: nil, image: nil, style: style, completion: nil)

    }

    func displayError(_ error: Error) {
        displayToast(message: error.localizedDescription)
    }
}
