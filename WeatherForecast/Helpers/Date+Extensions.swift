//
//  Date+Extensions.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

extension Date {

    var weekday: String? {
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: self)

        if calendar.weekdaySymbols.indices.contains(day - 1) {
            return calendar.weekdaySymbols[day - 1]
        } else {
            return nil
        }
    }
}
