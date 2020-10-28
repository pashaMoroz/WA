//
//  HTTPNetworkingDataFetcher.swift
//  UnsplashApp
//
//  Created by Алексей Пархоменко on 16.10.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation
import UIKit

enum NetResult<T> {
    case success(T)
    case failure
}

class HTTPNetworkingDataFetcher {
    
    var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)?
    
    private let networking: HTTPNetworking<WheatherApp>
    
    init(networking: HTTPNetworking<WheatherApp> = HTTPNetworking<WheatherApp>()) {
        self.networking = networking
        self.isWaitingForConnectivityHandler = self.networking.isWaitingForConnectivityHandler
    }
    
    func fetchWeatherFrom(searchTerm: String, completion: @escaping (NetResult<CurrentCityWeatherListModel>) -> ()) {
        networking.request(.fetchWheather(searchTerm: searchTerm)) { (result) in
            switch result {
            case .success(let data):
                self.decodeJSON(type: CurrentCityWeatherListModel.self, from: data) { (result) in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let jsonError):
                        print(jsonError)
                        print(jsonError.localizedDescription)
                        completion(.failure)
                    }
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                completion(.failure)
            }
        }
    }

    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()

        do {
            let objects = try decoder.decode(type.self, from: data)
            completion(.success(objects))
        } catch let jsonError {
            completion(.failure(jsonError))
        }

//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print(json)
//        } catch let error {
//
//        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }

        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}

