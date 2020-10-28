//
//  WeatherSettings.swift
//  WA
//
//  Created by Pavel Moroz on 28.10.2020.
//

import Foundation

final class WeatherSettings {

    private enum SettingKey: String {

        case note
    }

    static var notesForCurrentCity: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.note.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.note.rawValue

            if let note = newValue {
                print("value: \(note) was added to key \(key)")
                defaults.set(note, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
