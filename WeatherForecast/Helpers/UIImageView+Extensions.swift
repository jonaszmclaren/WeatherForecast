//
//  UIImageView+Extensions.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setWeatherIcon(withId id: String?) {
        let placeholder = UIImage(systemName: "photo.fill")
        if let id = id {
            let url = URL(string: String(format: Constants.weatherIconPath, id))
            kf.setImage(with: url, placeholder: placeholder)
        } else {
            image = placeholder
        }
    }
}
