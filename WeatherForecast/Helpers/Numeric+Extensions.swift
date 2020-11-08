//
//  Numeric+Extensions.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

extension Double {

    var toInt: Int {
        return Int(self.rounded())
    }
}

extension Optional where Wrapped == Double {

    var stringValue: String {
        return self != nil ? String(self!) : "-"
    }

    var toInt: Int? {
        return self != nil ? Int(self!.rounded()) : nil
    }
}

extension Int {

    var stringValue: String {
        return String(self)
    }
}
