//
//  NumberFormattingHelper.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 07/11/2020.
//

import Foundation

struct NumberFormattingHelper {

    static func prepareTextWithFormat(fromDouble number: Double?, inText text: String) -> String {
        if let number = number {
            return String(format: text, number.toInt.stringValue)
        } else {
            return "-"
        }
    }

    static func prepareTextWithFormat(fromInt number: Int?, inText text: String) -> String {
        if let number = number {
            return String(format: text, number.stringValue)
        } else {
            return "-"
        }
    }
}
