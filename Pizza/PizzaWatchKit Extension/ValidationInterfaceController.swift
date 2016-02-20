//
//  ValidationInterfaceController.swift
//  Pizza
//
//  Created by Sergio García on 20/2/16.
//  Copyright © 2016 Sergio Garcia. All rights reserved.
//

import WatchKit
import Foundation


class ValidationInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    var selection: [Steps: [String]]!
    @IBAction func validateBUttonAction() {
    }
    @IBOutlet var validateButton: WKInterfaceButton!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let context = context, selectionRaw = context["selection"] as? [Int: [String]] {
            self.selection = fromRaw(selectionRaw)
        }
    }
    
    func fromRaw(rawSel: [Int: [String]]) -> [Steps: [String]] {
        var selection = [Steps: [String]]()
        for sel in rawSel {
            if let step = Steps(rawValue: sel.0) {
                selection[step] = sel.1
            }
        }
        return selection
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        loadData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func loadData() {
        var toalData = 0
        
        for sel in self.selection {
            toalData += sel.1.count
        }
        
        self.tableView.setNumberOfRows(toalData, withRowType: LabelTableRowController.identifier)
        
        for var i = 0; i < toalData; i++ {
            let row = self.tableView.rowControllerAtIndex(i) as! LabelTableRowController
            
            var value: String?
            var myIndfex = i
            if let size = selection[.Size] where value == nil {
                if myIndfex < size.count {
                    value = selection[.Size]?[myIndfex] ?? ""
                    row.mainLabel.setTextColor(Steps.Size.color())
                } else {
                    myIndfex -= size.count
                }
            }

            
            if let type = selection[.Types] where value == nil {
                if myIndfex < type.count {
                    value = selection[.Types]?[myIndfex] ?? ""
                    row.mainLabel.setTextColor(Steps.Types.color())
                } else {
                    myIndfex -= type.count
                }
            }
            
            if let cheese = selection[.Cheese] where value == nil {
                if myIndfex < cheese.count {
                    value = selection[.Cheese]?[myIndfex] ?? ""
                    row.mainLabel.setTextColor(Steps.Cheese.color())
                } else {
                    myIndfex -= cheese.count
                }
            }
            
            if let ingredients = selection[.Ingredients] where value == nil {
                if myIndfex < ingredients.count {
                    value = selection[.Ingredients]?[myIndfex] ?? ""
                    row.mainLabel.setTextColor(Steps.Ingredients.color())
                } else {
                    myIndfex -= ingredients.count
                }
            }
            
            row.mainLabel.setText(value)
        }
    }
    
}
