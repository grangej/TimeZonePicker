//
//  TimeZonePickerViewController.swift
//  TimeZonePicker
//
//  Created by John Grange on 9/23/17.
//  Copyright © 2017 SD Networks. All rights reserved.
//

import UIKit

public protocol TimeZonePickerViewControllerDelegate: AnyObject {

    func timeZonePickerViewControllerDidCancel(viewController: TimeZonePickerTableViewController)
    func timeZonePickerViewController(viewController: TimeZonePickerTableViewController,
                                      didSelectTimeZone timeZone: TimeZoneLocation)
}

public class TimeZonePickerViewController: UINavigationController {

    public init(initialSearchText: String? = nil, delegate: TimeZonePickerViewControllerDelegate? = nil) throws {

        super.init(nibName: nil, bundle: nil)

        let timeZonePicker = try TimeZonePickerTableViewController(initialSearchText: initialSearchText,
                                                                   delegate: delegate)

        self.setViewControllers([timeZonePicker], animated: false)
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
