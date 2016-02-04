//
//  ValidationViewController.swift
//  Pizza
//
//  Created by Sergio Garcia on 4/2/16.
//  Copyright © 2016 Sergio Garcia. All rights reserved.
//

import UIKit

//MARK: Actions
extension ValidationViewController {
    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func acceptButtonAction(sender: AnyObject) {
        if validateSelection() {
            let alert = UIAlertController(title: "Oído en cocina", message: "¡Tu pizza estará disponible enseguida!", preferredStyle: .Alert)
            let acceptButton = UIAlertAction(title: "Aceptar", style: .Default, handler: nil)
            alert.addAction(acceptButton)
            self.presentViewController(alert, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Receta incompleta", message: "Selecciona mínimo algún ingrediente en todas las secciones para poder validar tu pizza.", preferredStyle: .Alert)
            let acceptButton = UIAlertAction(title: "Aceptar", style: .Default, handler: nil)
            alert.addAction(acceptButton)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func validateSelection() -> Bool {
        for step in Steps.values {
            guard let data = selection[step] where data.count > 0 else {
                return false
            }
        }
        return true
    }
}

//MARK: Life cycle
class ValidationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selection: [Steps: [String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: UITableViewDataSource
extension ValidationViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Steps.values.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selection[Steps(rawValue: section)!]?.count ?? 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let step = Steps(rawValue: section) {
            return step.pretty()
        } else {
            return nil
        }
    }
}

//MARK: UITableViewDelegate
extension ValidationViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "default")
        let title = selection[Steps(rawValue: indexPath.section)!]![indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
}