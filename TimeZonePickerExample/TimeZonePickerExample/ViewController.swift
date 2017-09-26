//
//  ViewController.swift
//  TimeZonePickerExample
//
//  Created by John Grange on 9/18/17.
//  Copyright © 2017 SD Networks. All rights reserved.
//

import UIKit
import TimeZonePicker

class ViewController: UIViewController {

    @IBOutlet weak var timeZoneLabel: UILabel!

    private var selectedTiemZone: TimeZoneLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let timeZoneDataSource = try? TimeZoneDataSource(initialSearchText: nil)

        if let timeZoneLocation = timeZoneDataSource?.timeZone(city: "Tokyo", country: "Japan") {

            print(timeZoneLocation.cityName)
        }
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func timeZonePickerPressed(_ sender: Any) {

        guard let timeZonePicker = try? TimeZonePickerViewController(initialSearchText: self.selectedTiemZone?.cityName,
                                                                     delegate: self) else {
            return
        }

        self.present(timeZonePicker, animated: true, completion: nil)
    }

}

extension ViewController: TimeZonePickerViewControllerDelegate {

    func timeZonePickerViewControllerDidCancel(viewController: TimeZonePickerTableViewController) {

        self.dismiss(animated: true, completion: nil)
    }

    func timeZonePickerViewController(viewController: TimeZonePickerTableViewController, didSelectTimeZone
        timeZone: TimeZoneLocation) {

        self.timeZoneLabel.text = timeZone.description
        self.selectedTiemZone = timeZone

        self.dismiss(animated: true) {

            print(timeZone)

        }
    }
}
