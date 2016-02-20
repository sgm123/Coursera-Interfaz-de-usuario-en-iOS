//
//  Constants.swift
//  Pizza
//
//  Created by Sergio García on 20/2/16.
//  Copyright © 2016 Sergio Garcia. All rights reserved.
//

import UIKit

enum Steps: Int {
    case Size = 0
    case Types
    case Cheese
    case Ingredients
    
    static let values: [Steps] = [.Size, .Types, .Cheese, .Ingredients]
    func pretty() -> String {
        switch self {
        case .Size:
            return "Tamaño"
        case .Types:
            return "Tipo"
        case .Cheese:
            return "Queso"
        case .Ingredients:
            return "Ingredientes"
        }
    }
    
    func count() -> Int {
        return self.data().count
    }
    
    func data() -> [String] {
        switch self {
        case .Size:
            return sizes
        case .Types:
            return types
        case .Cheese:
            return cheeses
        case .Ingredients:
            return ingredients
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .Size:
            return UIColor.brownColor()
        case .Types:
            return UIColor.redColor()
        case .Cheese:
            return UIColor.yellowColor()
        case .Ingredients:
            return UIColor.greenColor()
        }
    }
}

let sizes = ["chica", "mediana", "grande"]
let types = ["delgada", "crujiente", "gruesa"]
let cheeses = ["mozarela", "cheddar", "parmesano", "sin queso"]
let ingredients = ["jamón", "pepperoni", "pavo", "salchicha", "aceituna", "cebolla", "pimiento", "piña", "anchoa"]
