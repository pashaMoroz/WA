//
//  ResourceType.swift
//  TrackerFramework
//
//  Created by Алексей Пархоменко on 28.09.2020.
//

import Foundation

public protocol ResourceType {
  var baseURL: URL { get }
  var endpoint: Endpoint { get }
  var task: Task { get }
  var headers: [String: String] { get }
}

enum WheatherApp {
    case fetchWheather(searchTerm: String)
}

extension WheatherApp: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org") else {
          // should handle this case better
          fatalError("URL doesn't work")
        }
        return url
    }
    
    var endpoint: Endpoint {
        switch self {
        case .fetchWheather:
            return .get(path: "data/2.5/forecast")
            //return .get(path: "data/2.5/weather")
        }
    }
    
    var task: Task {
        switch self {
        case .fetchWheather(let searchTerm):
            var params: [String: String] = [:]
            params["q"] = searchTerm
            params["appid"] = String(Configuration.WheatherAppSettings.APIkey)
            params["lang"] = String("ru")

            return .requestWithParameters(params)
        }
    }
    
    var headers: [String : String] {
        return ["Authorization": "Client-ID \(Configuration.WheatherAppSettings.APIkey)"]
    }
}


