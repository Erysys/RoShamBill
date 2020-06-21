//
//  SettingsTableViewController.swift
//  RoShamBill
//
//  Created by Joel on 12/1/19.
//  Copyright © 2019 Joel. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var settings: Settings!
    
    var minPickerValue: Int!
    var maxPickerValue: Int!
    
    var minNumberPickerOptions: [Int] = []
    var maxNumberPickerOptions: [Int] = []
    
    let minNumberPickerCellIndexPath = IndexPath(row: 1, section: 0)
    let maxNumberPickerCellIndexPath = IndexPath(row: 3, section: 0)
    let minNumberLabelCellIndexPath = IndexPath(row: 0, section: 0)
    let maxNumberLabelCellIndexPath = IndexPath(row: 2, section: 0)
    
    var isMinNumberShown: Bool = false {
        didSet {
            minNumberPicker.isHidden = !isMinNumberShown
        }
    }
    
    var isMaxNumberShown: Bool = false {
        didSet {
            maxNumberPicker.isHidden = !isMaxNumberShown
        }
    }
    
    @IBOutlet var minNumberLabel: UILabel!
    @IBOutlet var maxNumberLabel: UILabel!
    
    @IBOutlet var minNumberPicker: UIPickerView!
    @IBOutlet var maxNumberPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.minNumberPicker.delegate = self
        self.minNumberPicker.dataSource = self
        self.maxNumberPicker.delegate = self
        self.maxNumberPicker.dataSource = self
        
        minPickerValue = settings.minNumber
        maxPickerValue = settings.maxNumber
        
        for count in 1...999 {
            minNumberPickerOptions.append(count)
            maxNumberPickerOptions.append(count + 1)
        }
        minNumberPicker.selectRow(settings.minNumber - 1, inComponent: 0, animated: true)
        maxNumberPicker.selectRow(settings.maxNumber - 2, inComponent: 0, animated: true)
        
        updateViews()
    }
    
    func updateViews() {
        let minRow = minNumberPicker.selectedRow(inComponent: 0)
        let maxRow = maxNumberPicker.selectedRow(inComponent: 0)
        minNumberLabel.text = String(minNumberPickerOptions[minRow])
        maxNumberLabel.text = String(maxNumberPickerOptions[maxRow])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == minNumberPicker {
            minPickerValue = minNumberPickerOptions[row]
            minNumberLabel.text = String(minPickerValue)
            if minPickerValue >= maxPickerValue {
                maxNumberPicker.selectRow(minPickerValue - 1, inComponent: 0, animated: true)
                updateViews()
                }
            } else {
            maxPickerValue = maxNumberPickerOptions[row]
            maxNumberLabel.text = String(maxPickerValue)
            if maxPickerValue <= minPickerValue {
                minNumberPicker.selectRow(maxPickerValue - 2, inComponent: 0, animated: true)
                updateViews()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case minNumberPickerCellIndexPath:
            if isMinNumberShown {
                return 216.0
            } else {
                return 0.0
            }
        case maxNumberPickerCellIndexPath:
            if isMaxNumberShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case minNumberLabelCellIndexPath:
            if isMinNumberShown {
                isMinNumberShown = false
            } else if isMaxNumberShown {
                isMaxNumberShown = false
                isMinNumberShown = true
            } else {
                isMinNumberShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case maxNumberLabelCellIndexPath:
            if isMaxNumberShown {
                isMaxNumberShown = false
            } else if isMinNumberShown {
                isMinNumberShown = false
                isMaxNumberShown = true
            } else {
                isMaxNumberShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 999
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == minNumberPicker {
        return String(minNumberPickerOptions[row])
        } else {
          return String(maxNumberPickerOptions[row])
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveButtonSegue" {
            self.settings.minNumber = minPickerValue
            self.settings.maxNumber = maxPickerValue
            Settings.saveToFile(settings: self.settings)
        }
    }
}
