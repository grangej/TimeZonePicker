//
//  SwiftUIView.swift
//  
//
//  Created by John Grange on 12/28/21.
//

import SwiftUI

public struct TimeZonePickerView: View {
    
    public typealias TimeZonePickerCallback = (TimeZoneLocation) -> ()
    
    private var timeZonePicked: TimeZonePickerCallback?
    @StateObject private var dataSource: TimeZoneDataSource

    public init(initialSearchText: String?, timeZonePicked: @escaping TimeZonePickerCallback) throws {
        
        self.timeZonePicked = timeZonePicked
        let dataSource = try TimeZoneDataSource(initialSearchText: initialSearchText)
        self._dataSource = StateObject(wrappedValue: dataSource)
    }
    
    public var body: some View {
        VStack {
            List {
                ForEach(dataSource.filteredTimeZones) { timeZone in
                    Text(timeZone.description).onTapGesture {
                        timeZonePicked?(timeZone)
                    }
                }
            }.navigationTitle(String(localized: "Time Zone", table: nil, bundle: .module))
                .searchable(text: $dataSource.searchText)
        }

    }
}

struct TimeZonePickerView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            NavigationView {
                try! TimeZonePickerView(initialSearchText: nil) { location in
                    
                    print(location)
                }
            }
            .preferredColorScheme(.dark)
            .environment(\.locale, Locale.init(identifier: "zh-Hant"))
            NavigationView {
                try! TimeZonePickerView(initialSearchText: nil) { location in
                    
                    print(location)
                }
            }.environment(\.locale, Locale.init(identifier: "zh-Hant"))
            NavigationView {
                try! TimeZonePickerView(initialSearchText: nil) { location in
                    
                    print(location)
                }
            }.preferredColorScheme(.dark)
        }
        


    }
}
