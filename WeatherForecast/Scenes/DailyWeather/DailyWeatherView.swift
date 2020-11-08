//
//  DailyWeatherView.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//

import UIKit

class DailyWeatherView: UIView {

    // MARK: - Properties

    private let iconImageView = UIImageView()
    private let dayLabel = WFLabel(style: .title)
    private let descriptionLabel = WFLabel(style: .secondary)
    private let stackView = UIStackView()
    private let dayTemperatureLabel = WFLabel(style: .primary)
    private let nightTemperatureLabel = WFLabel(style: .primary)
    private let minTemperatureLabel = WFLabel(style: .primary)
    private let maxTemperatureLabel = WFLabel(style: .primary)
    private let sunriseLabel = WFLabel(style: .primary)
    private let sunsetLabel = WFLabel(style: .primary)
    private let pressureLabel = WFLabel(style: .primary)
    private let humidityLabel = WFLabel(style: .primary)

    // MARK: - Init

    init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupData(_ data: DailyWeather.GetWeather.ViewModel) {
        iconImageView.setWeatherIcon(withId: data.icon)
        dayLabel.text = data.day
        descriptionLabel.text = data.description
        dayTemperatureLabel.text = data.dayTemperature
        nightTemperatureLabel.text = data.nightTemperature
        minTemperatureLabel.text = data.minTemperature
        maxTemperatureLabel.text = data.maxTemperature
        sunriseLabel.text = data.sunrise
        sunsetLabel.text = data.sunset
        pressureLabel.text = data.pressure
        humidityLabel.text = data.humidity
    }

    private func setupView() {
        backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.spacing = 20.0

        let containerView = UIView()
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(dayLabel)
        containerView.addSubview(descriptionLabel)

        addSubview(stackView)
        stackView.addArrangedSubview(dayTemperatureLabel)
        stackView.addArrangedSubview(nightTemperatureLabel)
        stackView.addArrangedSubview(minTemperatureLabel)
        stackView.addArrangedSubview(maxTemperatureLabel)
        stackView.addArrangedSubview(sunriseLabel)
        stackView.addArrangedSubview(sunsetLabel)
        stackView.addArrangedSubview(pressureLabel)
        stackView.addArrangedSubview(humidityLabel)

        dayLabel.textAlignment = .center
        iconImageView.contentMode = .scaleAspectFit
        descriptionLabel.textAlignment = .center

        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        iconImageView.snp.makeConstraints {
            $0.width.equalTo(dayLabel).dividedBy(3.0)
            $0.height.equalTo(iconImageView.snp.width)
            $0.top.leading.bottom.equalToSuperview()
        }

        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(20.0)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(iconImageView.snp.topMargin)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(20.0)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(iconImageView.snp.bottomMargin)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.greaterThanOrEqualTo(safeAreaLayoutGuide.snp.bottomMargin).inset(20.0).priority(.low)
        }
    }
}
