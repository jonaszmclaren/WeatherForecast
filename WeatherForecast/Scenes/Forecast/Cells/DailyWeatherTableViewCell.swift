//
//  DailyWeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import UIKit
import SnapKit

protocol DailyWeatherTableViewCellProtocol: AnyObject {
    func cellSelected(index: Int)
}

class DailyWeatherTableViewCell: UITableViewCell, WFTableViewCell {

    // MARK: - Properties

    static let cellIdentifier = "DailyWeatherTableViewCell"
    private let collectionView = WFCollectionView(style: .compact, cellTypes: [DailyWeatherCollectionViewCell.self])
    private var days: [Forecast.GetDailyWeather.ViewModel.Day] = []
    weak var delegate: DailyWeatherTableViewCellProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupData(_ data: [Forecast.GetDailyWeather.ViewModel.Day]) {
        days = data
        collectionView.reloadData()
    }

    private func setupView() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(96.0)
        }
    }
}

extension DailyWeatherTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? DailyWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setupData(days[indexPath.row])

        return cell
    }
}

extension DailyWeatherTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellSelected(index: indexPath.row)
    }
}
