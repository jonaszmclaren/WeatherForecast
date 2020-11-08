//
//  WFStyle.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import UIKit

enum WFLabelStyle {
    case title
    case text
    case primary
    case secondary

    var font: UIFont {
        switch self {
        case .title:
            return UIFont.systemFont(ofSize: 20.0, weight: .black)
        case .text:
            return UIFont.systemFont(ofSize: 15.0, weight: .regular)
        case .primary, .secondary:
            return UIFont.systemFont(ofSize: 17.0, weight: .medium)
        }
    }

    var textColor: UIColor {
        switch self {
        case .title, .text, .primary:
            return .label
        case .secondary:
            return .secondaryLabel
        }
    }
}

enum WFCollectionViewStyle {
    case compact

    var layout: UICollectionViewLayout {
        switch self {
        case .compact:
            let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: 8.0, left: 20.0, bottom: 8.0, right: 20.0)
            flowLayout.itemSize = CGSize(width: 80.0, height: 80.0)
            flowLayout.minimumLineSpacing = 20.0
            flowLayout.scrollDirection = .horizontal

            return flowLayout
        }
    }
}
