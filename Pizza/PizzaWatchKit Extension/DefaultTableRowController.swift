//
//  DefaultTableRowController.swift
//  Pizza
//
//  Created by Sergio García on 20/2/16.
//  Copyright © 2016 Sergio Garcia. All rights reserved.
//

import WatchKit

class DefaultTableRowController: NSObject {
    static let identifier = "DefaultTableRowController"
    @IBOutlet var mainLabel: WKInterfaceLabel!
    @IBOutlet var check: WKInterfaceImage! {
        didSet {
            check.setTintColor(UIColor.whiteColor())        
        }
    }
    
    
}
