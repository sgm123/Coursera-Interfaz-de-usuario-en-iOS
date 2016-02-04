//
//  ViewController.swift
//  Pizza
//
//  Created by Sergio Garcia on 4/2/16.
//  Copyright © 2016 Sergio Garcia. All rights reserved.
//

import UIKit


enum Steps: Int {
    case Size = 0
    case Type
    case Cheese
    case Ingredients
    
    static let values: [Steps] = [.Size, .Type, .Cheese, .Ingredients]
    func pretty() -> String {
        switch self {
        case .Size:
            return "Tamaño"
        case .Type:
            return "Tipo"
        case .Cheese:
            return "Queso"
        case .Ingredients:
            return "Ingredientes"
        }
    }
}

private let sizes = ["chica", "mediana", "grande"]
private let types = ["delgada", "crujiente", "gruesa"]
private let cheeses = ["mozarela", "cheddar", "parmesano", "sin queso"]
private let ingredients = ["jamón", "pepperoni", "pavo", "salchicha", "aceituna", "cebolla", "pimiento", "piña", "anchoa"]

private var selection = [Steps: [String]]()

//MARK: Actions
extension SelectionViewController {
    @IBAction func nextButtonAction(sender: AnyObject) {
        let nextStep = Steps(rawValue: currentStep.rawValue + 1)
        if let nextStep = nextStep {
            
            let selectionController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(SelectionViewController.identifier) as! SelectionViewController
            
            selectionController.currentStep = nextStep
            self.navigationController?.pushViewController(selectionController, animated: true)
        } else {
            self.performSegueWithIdentifier("showDetailsController", sender: nil)
        }
    }
}

//MARK: Life cycle
class SelectionViewController: UIViewController {
    static let identifier = "SelectionViewController"
    @IBOutlet weak var tableView: UITableView!

    var currentStep = Steps.Size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = currentStep.pretty()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsController" {
            let validationController = (segue.destinationViewController as! UINavigationController).viewControllers.first as! ValidationViewController
            validationController.selection = selection
        }
        
    }
}


//MARK: UITableViewDataSource
extension SelectionViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentStep {
        case .Size:
            return sizes.count
        case .Type:
            return types.count
        case .Cheese:
            return cheeses.count
        case .Ingredients:
            return ingredients.count
        }
    }
}

//MARK: UITableViewDelegate
extension SelectionViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "default")
        var data = [String]()
        switch currentStep {
        case .Size:
            data = sizes
        case .Type:
            data = types
        case .Cheese:
            data = cheeses
        case .Ingredients:
            data = ingredients
        }
        let value = data[indexPath.row]
        cell.textLabel?.text = value
        
        if let currrentSelection = selection[currentStep] where currrentSelection.contains(value) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var data = [String]()
        switch self.currentStep {
        case .Size:
            data = sizes
        case .Type:
            data = types
        case .Cheese:
            data = cheeses
        case .Ingredients:
            data = ingredients
        }
        let value = data[indexPath.row]
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
                if !currentValues.contains(value) {
                    currentValues.append(value)
                }
                selection[self.currentStep] = currentValues
            } else {
                selection[self.currentStep] = [value]
            }
        }
        tableView.reloadData()
    }
}
