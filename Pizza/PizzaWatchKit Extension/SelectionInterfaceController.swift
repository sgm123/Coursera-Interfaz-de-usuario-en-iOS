//
//  InterfaceController.swift
//  PizzaWatchKit Extension
//
//  Created by Sergio García on 20/2/16.
//  Copyright © 2016 Sergio Garcia. All rights reserved.
//

import WatchKit
import Foundation

private var selection = [Steps: [String]]()

class SelectionInterfaceController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    @IBOutlet var nextButton: WKInterfaceButton!
    
    static let firstStep = Steps.Size
    var currentStep = SelectionInterfaceController.firstStep
    
    @IBAction func nextButtonAction() {
        let nextStep = Steps(rawValue: currentStep.rawValue + 1)
        if let nextStep = nextStep {
            pushControllerWithName("SelectionInterfaceController", context: ["nextStep": nextStep.rawValue])
        } else {
            pushControllerWithName("ValidationInterfaceController", context: ["selection": toRaw()])
        }
    }
    
    func toRaw() -> [Int: [String]] {
        var rawSel = [Int: [String]]()
        for sel in selection {
            rawSel[sel.0.rawValue] = sel.1
        }
        return rawSel
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let context = context {
            if let currentStep = context["nextStep"] as? Int, nextStep = Steps(rawValue: currentStep) {
                self.currentStep = nextStep
            }
        }
        loadData()
    }

    override func willActivate() {
        super.willActivate()
        loadData()
    }

    
    func loadData() {
        self.tableView.setNumberOfRows(self.currentStep.count(), withRowType: DefaultTableRowController.identifier)
        let data = self.currentStep.data()
        for (index, value) in data.enumerate() {
            let row = self.tableView.rowControllerAtIndex(index) as! DefaultTableRowController
            row.mainLabel.setText(value)
            
            if let currrentSelection = selection[currentStep] where currrentSelection.contains(value) {
                row.check.setHidden(false)
            } else {
                row.check.setHidden(true)
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        var data = self.currentStep.data()
        let value = data[rowIndex]
        if let currrentSelection = selection[self.currentStep] where currrentSelection.contains(value) {
            // Remove
            if self.currentStep == .Ingredients {
                var currentValues = selection[self.currentStep] ?? [String]()
                if currentValues.contains(value) {
                    currentValues.removeAtIndex(currentValues.indexOf(value)!)
                }
                selection[self.currentStep] = currentValues
            } else {
                selection[self.currentStep] = [String]()
            }
        } else {
            // Add
            if self.currentStep == .Ingredients {
                var currentValues = selection[self.currentStep] ?? [String]()
                if !currentValues.contains(value) &&
                    currentValues.count < 5 {
                        currentValues.append(value)
                }
                selection[self.currentStep] = currentValues
            } else {
                selection[self.currentStep] = [value]
            }
        }
//        table.setRowTypes([DefaultTableRowController.identifier])
//        table.reloadData()
        loadData()
    }

}


