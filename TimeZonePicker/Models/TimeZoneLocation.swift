//
//  TimeZoneLocation.swift
//  TimeZonePicker
//
//  Created by John Grange on 9/23/17.
//  Copyright © 2017 SD Networks. All rights reserved.
//

import Foundation

public struct TimeZoneLocation: Codable, CustomStringConvertible {

    /// -90.0 to 90.0 (in decimal format)
    public let latitude: String
    /// -180.0 to 180.0 (in decimal format)
    public let longitude: String
    /// Unlocalized version of City
    internal let city: String
    /// Localized city name
    public var cityName: String {

        let bundle = Bundle(for: TimeZoneDataSource.self)

        return bundle.localizedString(forKey: self.city, value: nil, table: "Localizable_Cities")
    }
    /// Unlocalized version of Country
    internal let country: String
    /// Localized country name
    public var countryName: String {
        let bundle = Bundle(for: TimeZoneDataSource.self)

        return bundle.localizedString(forKey: self.country, value: nil, table: "Localizable_Countries")
    }
    /// the timeZone name as string
    public let timeZoneName: String
    /// the timeZone initlized from the timeZone name
    public var timeZone: TimeZone! {
        return TimeZone(identifier: self.timeZoneName)
    }

    /// Search convienience method , searches for string in description and nonLocalizedDescription
    ///
    /// - Parameter string: Search string to seach in city / country
    /// - Returns: true if found
    func contains(string: String) -> Bool {

        return
            self.description.lowercased().contains(string.lowercased())
                || self.nonLocalizedSearchDescription.lowercased().contains(string.lowercased())
    }

    private var nonLocalizedSearchDescription: String {
        return "\(self.city), \(self.country)"
    }

    /// Localized description of this timezone : City, Country format
    public var description: String {

        guard !self.countryName.isEmpty else {

            return self.cityName
        }

        return "\(self.cityName), \(self.countryName)"
    }
}

extension TimeZoneLocation: Equatable, Comparable {

    public static func==(lhs: TimeZoneLocation, rhs: TimeZoneLocation) -> Bool {
        return lhs.city == rhs.city && lhs.country == rhs.country && lhs.timeZoneName == rhs.timeZoneName
    }

    public static func<(lhs: TimeZoneLocation, rhs: TimeZoneLocation) -> Bool {
        return lhs.cityName < rhs.cityName
    }

    public static func<=(lhs: TimeZoneLocation, rhs: TimeZoneLocation) -> Bool {
        return lhs.cityName <= rhs.cityName
    }

    public static func>=(lhs: TimeZoneLocation, rhs: TimeZoneLocation) -> Bool {
        return lhs.cityName >= rhs.cityName
    }

    public static func>(lhs: TimeZoneLocation, rhs: TimeZoneLocation) -> Bool {
        return lhs.cityName > rhs.cityName
    }
}
