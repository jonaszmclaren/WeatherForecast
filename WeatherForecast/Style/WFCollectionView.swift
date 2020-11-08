//
//  WFCollectionView.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//

import UIKit

protocol WFCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { get }
}

class WFCollectionView: UICollectionView {

    init(style: WFCollectionViewStyle, cellTypes: [WFCollectionViewCell.Type]) {
        super.init(frame: .zero, collectionViewLayout: style.layout)

        cellTypes.forEach { cell in
            register(cell.self, forCellWithReuseIdentifier: cell.cellIdentifier)
        }

        backgroundColor = .systemBackground
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
