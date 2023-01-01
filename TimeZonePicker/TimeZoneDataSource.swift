//
//  TimeZoneDataSource.swift
//  TimeZonePicker
//
//  Created by John Grange on 9/23/17.
//  Copyright © 2017 SD Networks. All rights reserved.
//

import Foundation
import Combine

public protocol TimeZoneDataSourceDelegate: AnyObject {

    func timeZoneDataSourceDidUpdate(timeZoneDataSource: TimeZoneDataSource)
}

/// Initilizes the timezones and supports filtering
/// note: The filterTimeZones will be blank until valid filter search text is applied
public class TimeZoneDataSource: ObservableObject {

    /// All timeZones
    public var timeZones: [TimeZoneLocation] = [TimeZoneLocation]()

    /// Filtered list of timeZones (use filter(searchString: "search text") to apply filter
    @Published public var filteredTimeZones: [TimeZoneLocation] = [TimeZoneLocation]() {

        didSet {

            DispatchQueue.main.async {

                self.delegate?.timeZoneDataSourceDidUpdate(timeZoneDataSource: self)

            }
        }
    }
    
    @Published public var searchText: String = ""

    public weak var delegate: TimeZoneDataSourceDelegate?
    private var cancelBag = Set<AnyCancellable>()
    
    public init(initialSearchText: String?) throws {

        self.searchText = initialSearchText ?? ""
        
        let bundle = Bundle.module
        let path = bundle.path(forResource: "all_cities_adj", ofType: "plist")!

        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)

        let decoder = PropertyListDecoder()

        var timeZones = try decoder.decode([TimeZoneLocation].self, from: data)

        self.timeZones = timeZones

        DispatchQueue(label: "init timeZones").async {

            timeZones.sort()

            if let initialSearchText = initialSearchText {

                self.filter(searchString: initialSearchText)
            }
        }
        
        
        $searchText.removeDuplicates().sink { [weak self] searchText in
            
            self?.filter(searchString: searchText)
        }.store(in: &cancelBag)
    }

    /// Search all timeZones for a string in city or country
    /// note: this search is done both in english and in the current system langauge
    //  (i.e. search text is searched against a localized city / country AND english city / country
    ///
    /// - Parameter searchString: Search text to search in city / country
    public func filter(searchString: String?) {

        defer {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        
        guard let searchString = searchString, !searchString.isEmpty else {
            self.filteredTimeZones = timeZones
            return
        }

        let timeZones = self.timeZones.filter({ (timeZoneCity) -> Bool in

            return timeZoneCity.contains(string: searchString)
        })
        
        DispatchQueue.main.async {
            self.filteredTimeZones = timeZones
        }

    }

    /// Return the first TimeZoneLocation that matches the city and country
    ///
    /// - Parameters:
    ///   - city: The City to search for
    ///   - country: The Country to search for
    /// - Returns: TimeZoneLocation that matches the city and state or nil if not found
    public func timeZone(city: String, country: String) -> TimeZoneLocation? {

        return self.timeZones.first(where: { (timeZoneLocation) -> Bool in

            return timeZoneLocation.city.lowercased() == city.lowercased() &&
                timeZoneLocation.country.lowercased() == country.lowercased()
        })
    }

    /// Return the first TimeZoneLocation that matches the TimeZoneName
    ///
    /// - Parameter timeZoneName: The name of the timeZone (ie. "UTC")
    /// - Returns: TimeZoneLocation that matches the time zone name or nil if not found
    public func timeZone(timeZoneName: String) -> TimeZoneLocation? {

        return self.timeZones.first(where: { (timeZoneLocation) -> Bool in

            return timeZoneLocation.timeZoneName.lowercased() == timeZoneName.lowercased()
        })
    }
}
