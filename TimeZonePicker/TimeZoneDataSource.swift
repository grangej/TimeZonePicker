//
//  TimeZoneDataSource.swift
//  TimeZonePicker
//
//  Created by John Grange on 9/23/17.
//  Copyright © 2017 SD Networks. All rights reserved.
//

import Foundation

public protocol TimeZoneDataSourceDelegate: class {

    func timeZoneDataSourceDidUpdate(timeZoneDataSource: TimeZoneDataSource)
}

/// Initilizes the timezones and supports filtering
/// note: The filterTimeZones will be blank until valid filter search text is applied
public class TimeZoneDataSource {

    /// All timeZones
    public var timeZones: [TimeZoneLocation] = [TimeZoneLocation]()

    /// Filtered list of timeZones (use filter(searchString: "search text") to apply filter
    public var filteredTimeZones: [TimeZoneLocation] = [TimeZoneLocation]() {

        didSet {

            self.delegate?.timeZoneDataSourceDidUpdate(timeZoneDataSource: self)
        }
    }

    public weak var delegate: TimeZoneDataSourceDelegate?

    public init() throws {

        let bundle = Bundle(for: TimeZoneDataSource.self)

        let path = bundle.path(forResource: "all_cities_adj", ofType: "plist")!

        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)

        let decoder = PropertyListDecoder()

        var timeZones = try decoder.decode([TimeZoneLocation].self, from: data)

        DispatchQueue(label: "init timeZones").async {

            timeZones.sort()

            DispatchQueue.main.async {

                self.timeZones = timeZones
            }
        }
    }

    /// Search all timeZones for a string in city or country
    /// note: this search is done both in english and in the current system langauge
    //  (i.e. search text is searched against a localized city / country AND english city / country
    ///
    /// - Parameter searchString: Search text to search in city / country
    public func filter(searchString: String) {

        self.filteredTimeZones = self.timeZones.filter({ (timeZoneCity) -> Bool in

            return timeZoneCity.contains(string: searchString)
        })

    }
}
