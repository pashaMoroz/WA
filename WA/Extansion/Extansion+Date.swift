//
//  Extansion+Date.swift
//  WA
//
//  Created by Pavel Moroz on 25.10.2020.
//

import Foundation

extension Date
{
    func hour() -> Int
    {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: self as Date)
        guard let hour = components.hour else { return 0}

        return hour
    }
}
