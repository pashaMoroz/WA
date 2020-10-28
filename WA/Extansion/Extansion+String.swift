//
//  Extansion+String.swift
//  WA
//
//  Created by Pavel Moroz on 25.10.2020.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd hh:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}
