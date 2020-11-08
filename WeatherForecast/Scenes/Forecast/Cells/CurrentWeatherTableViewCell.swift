//
//  CurrentWeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import UIKit
import SnapKit

class CurrentWeatherTableViewCell: UITableViewCell, WFTableViewCell {

    // MARK: - Properties

    static let cellIdentifier = "CurrentWeatherTableViewCell"
    private let nameLabel = WFLabel(style: .title)
    private let iconImageView = UIImageView()
    private let titleLabel = WFLabel(style: .primary)
    private let temperatureLabel = WFLabel(style: .primary)
    private let feelsLikeLabel = WFLabel(style: .secondary)

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupData(_ data: Forecast.GetCurrentWeather.ViewModel) {
        nameLabel.text = data.name
        iconImageView.setWeatherIcon(withId: data.icon)
        titleLabel.text = data.title
        temperatureLabel.text = data.temperature
        feelsLikeLabel.text = data.feelsLike
    }

    private func setupView() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator

        let containerView = UIView()
        addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(temperatureLabel)
        addSubview(feelsLikeLabel)

        nameLabel.textAlignment = .center
        iconImageView.contentMode = .scaleAspectFit
        titleLabel.textAlignment = .center
        temperatureLabel.textAlignment = .center
        feelsLikeLabel.textAlignment = .center

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.0)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(20.0).priority(.low)
            $0.trailing.greaterThanOrEqualToSuperview().inset(20.0).priority(.low)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(iconImageView)
        }

        iconImageView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8.0)
            $0.width.height.equalTo(50.0)
            $0.top.bottom.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)        }

        feelsLikeLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(32.0)
        }
    }
}
