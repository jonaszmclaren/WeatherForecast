//
//  CurrentWeatherView.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//

import UIKit
import MapKit

class CurrentWeatherView: UIView {

    // MARK: - Properties

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let iconImageView = UIImageView()
    private let nameLabel = WFLabel(style: .title)
    private let descriptionLabel = WFLabel(style: .secondary)
    private let stackView = UIStackView()
    private let temperatureLabel = WFLabel(style: .primary)
    private let feelsLikeLabel = WFLabel(style: .primary)
    private let tempMinLabel = WFLabel(style: .primary)
    private let tempMaxLabel = WFLabel(style: .primary)
    private let pressureLabel = WFLabel(style: .primary)
    private let humidityLabel = WFLabel(style: .primary)
    private let windSpeedLabel = WFLabel(style: .primary)
    private let windDegreesLabel = WFLabel(style: .primary)
    private let mapView = MKMapView()

    // MARK: - Init

    init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupData(_ data: CurrentWeather.GetCurrentWeather.ViewModel) {
        iconImageView.setWeatherIcon(withId: data.icon)
        nameLabel.text = data.name
        descriptionLabel.text = data.description
        temperatureLabel.text = data.temperature
        feelsLikeLabel.text = data.feelsLike
        tempMinLabel.text = data.tempMin
        tempMaxLabel.text = data.tempMax
        pressureLabel.text = data.pressure
        humidityLabel.text = data.humidity
        windSpeedLabel.text = data.windSpeed
        windDegreesLabel.text = data.windDegrees

        if let coordinates = data.coordinates {
            mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)), animated: false)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self)
            $0.height.equalTo(self).offset(safeAreaInsets.top).priority(.low)
        }
    }

    private func setupView() {
        backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.spacing = 20.0

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(feelsLikeLabel)
        stackView.addArrangedSubview(tempMinLabel)
        stackView.addArrangedSubview(tempMaxLabel)
        stackView.addArrangedSubview(pressureLabel)
        stackView.addArrangedSubview(humidityLabel)
        stackView.addArrangedSubview(windSpeedLabel)
        stackView.addArrangedSubview(windDegreesLabel)

        contentView.addSubview(mapView)

        nameLabel.textAlignment = .center
        iconImageView.contentMode = .scaleAspectFit
        descriptionLabel.textAlignment = .center

        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self)
            $0.height.equalTo(self).offset(safeAreaInsets.top).priority(.low)
        }

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        iconImageView.snp.makeConstraints {
            $0.width.equalTo(nameLabel).dividedBy(3.0)
            $0.height.equalTo(iconImageView.snp.width)
            $0.top.leading.bottom.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
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
        }

        mapView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200.0)
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
}
