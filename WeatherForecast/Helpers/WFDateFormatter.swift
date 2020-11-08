//
//  WFDateFormatter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 07/11/2020.
//

import Foundation

struct WFDateFormatter {

    static func stringLocal(from date: Date?, dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) -> String? {
        guard let date = date else {
            return nil
        }

        let df = DateFormatter()
        df.locale = Locale.current
        df.dateStyle = dateStyle
        df.timeStyle = timeStyle

        return df.string(from: date)
    }
}
