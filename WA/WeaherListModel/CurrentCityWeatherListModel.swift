//
//  OfferModel.swift
//  WA
//
//  Created by Pavel Moroz on 22.10.2020.
//

import Foundation

class CurrentCityWeatherListModel: Codable {
    
    var cod: String
    var message: Float?
    var cnt: Float
    var list: [WeatherListModel]?
    var city: CityModel?
}
