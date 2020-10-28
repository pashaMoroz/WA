//
//  ListOfferModel.swift
//  WA
//
//  Created by Pavel Moroz on 22.10.2020.
//

import Foundation

class WeatherListModel: Codable  {
    var dt: Float?
    var main: MainWeatherModel?
    var dt_txt: String?
    var weather: [WeatherModel]?
}
