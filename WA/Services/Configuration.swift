//
//  Configuration.swift
//  WA
//
//  Created by Pavel Moroz on 25.10.2020.
//

import Foundation

struct Configuration {

    struct WheatherAppSettings {

        static let shared = Configuration()
        private init() {}

        static let host         = "api.openweathermap.org"
        static let APIkey     = Secrets.APIKey

        struct Secrets {

            static let APIKey: String = "e8f8c11acd331717484c72be109ea4a2"
        }
    }
}
