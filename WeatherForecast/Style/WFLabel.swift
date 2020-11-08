//
//  WFLabel.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import UIKit

class WFLabel: UILabel {

    init(style: WFLabelStyle) {
        super.init(frame: .zero)

        font = style.font
        textColor = style.textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
