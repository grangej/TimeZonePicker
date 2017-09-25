//
//  TimeZonePickerViewController.swift
//  TimeZonePicker
//
//  Created by John Grange on 9/23/17.
//  Copyright © 2017 SD Networks. All rights reserved.
//

import UIKit
import SafariServices

public class TimeZonePickerTableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: TimeZoneDataSource!

    private let initialSearchText: String?
    
    public var delegate: TimeZonePickerViewControllerDelegate?
    
    /// Initilize a TimeZonePickerViewController
    public init(initialSearchText: String? = nil, delegate: TimeZonePickerViewControllerDelegate? = nil) throws {
        
        self.initialSearchText = initialSearchText
        self.dataSource = try TimeZoneDataSource()
        
        if let initialSourceText = initialSearchText {
            
            self.dataSource.filter(searchString: initialSourceText)
        }
        self.delegate = delegate
        
        let bundle = Bundle(for: TimeZonePickerTableViewController.self)
        
        super.init(nibName: "TimeZonePickerTableViewController", bundle: bundle)
    }
    
    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.initialSearchText = nil
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        
        self.initialSearchText = nil

        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let bundle = Bundle(for: TimeZonePickerTableViewController.self)

        let cellNib = UINib(nibName: "TimeZonePickerTableViewCell", bundle: bundle)
        
        self.tableView.register(cellNib, forCellReuseIdentifier: "TimeZonePickerTableViewCell")
        
        self.navigationItem.title = bundle.localizedString(forKey: "Time Zone", value: nil, table: "Localizable")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.text = self.initialSearchText
        self.searchBar.becomeFirstResponder()
        self.dataSource.delegate = self
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension TimeZonePickerTableViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let timeZone = self.dataSource.filteredTimeZones[indexPath.row]
        
        self.delegate?.timeZonePickerViewController(viewController: self, didSelectTimeZone: timeZone)
    }
}

extension TimeZonePickerTableViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZonePickerTableViewCell", for: indexPath)
        
        let item = self.dataSource.filteredTimeZones[indexPath.row]
        
        cell.textLabel?.text = item.description
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.filteredTimeZones.count
    }
}

extension TimeZonePickerTableViewController: UISearchBarDelegate {
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.delegate?.timeZonePickerViewControllerDidCancel(viewController: self)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.dataSource.filter(searchString: searchText)
    }
}

extension TimeZonePickerTableViewController: TimeZoneDataSourceDelegate {
    
    public func timeZoneDataSourceDidUpdate(timeZoneDataSource: TimeZoneDataSource) {
        
        self.tableView?.reloadData()
    }
}
