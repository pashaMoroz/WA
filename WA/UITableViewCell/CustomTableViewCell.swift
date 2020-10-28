//
//  CustomTableViewCell.swift
//  WA
//
//  Created by Pavel Moroz on 23.10.2020.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CustomTableViewCell"


    let cityLabel = UILabel()
    let timeLabel = UILabel()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()
    let recommendationLabel = UILabel()
    let imageOfWeather = UIImageView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        imageOfWeather.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendationLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(cityLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(imageOfWeather)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(recommendationLabel)

        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 5),
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            temperatureLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            recommendationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            recommendationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recommendationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageOfWeather.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 16),
            imageOfWeather.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            imageOfWeather.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            cityLabel.topAnchor.constraint(equalTo: imageOfWeather.bottomAnchor, constant: 5),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)

        ])

        imageOfWeather.contentMode = .scaleAspectFill
        recommendationLabel.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configurator(with url: String) {

        imageOfWeather.sd_setImage(with: URL(string: url))
    }

    func configureCell(model: CurrentCityWeatherListModel, indexPathRow: Int) {

        guard let temp = model.list?[indexPathRow].main?.temp else { return }
        guard let weatherImg = model.list?[indexPathRow].weather?[0].icon else { return }
        guard let weatherDescriprion = model.list?[indexPathRow].weather?[0].description else { return }
        guard let cityName = model.city?.name else { return }
        guard let countryName = model.city?.country else { return }

        //Вытягиваем дату с API
        guard let timeSting = model.list?[indexPathRow].dt_txt else { return }
        //Переводим вытянутую дату в формате Date
        let timeStringToDate = timeSting.toDate()
        //Извлекаем с даты один компенент (время)
        guard let hour = timeStringToDate?.hour() else { return }
        let temperature = Int(temp - 273.5) // перевод в градусы цельсия

        let imgUrlString = "https://openweathermap.org/img/wn/\(weatherImg)@2x.png"

        cityLabel.text = " \(cityName), \(countryName)"
        if indexPathRow == 0 {
            timeLabel.text = "Время \(hour):00, "
        } else {
            timeLabel.text = "В \(hour) будет"
        }

        recommendationLabel.text = createRecomendationText(temperature: temperature)
        temperatureLabel.text = "температура: \(temperature)°"
        imageOfWeather.sd_setImage(with: URL(string: imgUrlString))
        descriptionLabel.text = weatherDescriprion
    }

    private func createRecomendationText(temperature: Int) -> String {

        switch temperature {

        case _ where temperature > 0 && temperature < 10:

            return   "Не забудьте одеть куртку."

        case _ where temperature < 0:

            return  "Шапка - ваш лучший друг сегодня."

        case _ where temperature > 10:

            return "Можете не одеваться слишком тепло."

        default:
            return "Нет рекомендаций для вас."
        }
    }
}


