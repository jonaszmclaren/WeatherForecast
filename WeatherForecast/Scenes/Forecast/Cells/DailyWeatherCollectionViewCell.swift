//
//  DailyWeatherCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import UIKit
import SnapKit

class DailyWeatherCollectionViewCell: UICollectionViewCell, WFCollectionViewCell {

    // MARK: - Properties

    static let cellIdentifier = "DailyWeatherCollectionViewCell"
    private let nameLabel = WFLabel(style: .text)
    private let iconImageView = UIImageView()
    private let dayTemperatureLabel = WFLabel(style: .primary)
    private let nightTemperatureLabel = WFLabel(style: .secondary)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupData(_ data: Forecast.GetDailyWeather.ViewModel.Day) {
        nameLabel.text = data.dayName
        iconImageView.setWeatherIcon(withId: data.icon)
        dayTemperatureLabel.text = data.dayTemperature
        nightTemperatureLabel.text = data.nightTemperature
    }

    private func setupView() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        addSubview(dayTemperatureLabel)
        addSubview(nightTemperatureLabel)

        backgroundColor = .clear
        nameLabel.textAlignment = .center
        iconImageView.contentMode = .scaleAspectFit
        dayTemperatureLabel.textAlignment = .center
        nightTemperatureLabel.textAlignment = .center

        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(iconImageView.snp.top)
        }

        iconImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40.0)
        }

        dayTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom)
            $0.leading.bottom.equalToSuperview()
        }

        nightTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom)
            $0.leading.equalTo(dayTemperatureLabel.snp.trailing)
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(dayTemperatureLabel)
        }
    }
}
