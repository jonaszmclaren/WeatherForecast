//
//  WFTableView.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//

import UIKit

protocol WFTableViewCell: UITableViewCell {
    static var cellIdentifier: String { get }
}

class WFTableView: UITableView {

    init(cellTypes: [WFTableViewCell.Type]) {
        super.init(frame: .zero, style: .plain)

        cellTypes.forEach { cell in
            register(cell.self, forCellReuseIdentifier: cell.cellIdentifier)
        }

        tableFooterView = UIView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
