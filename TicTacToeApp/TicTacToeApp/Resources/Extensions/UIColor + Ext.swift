//
//  UIColor + Ext.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 30.09.2024.
//

import UIKit

extension UIColor {
    
    // функция преобразует hexadecimal RGB value, которое мы берем из макета в фигме, в UIColor object
    
    func hex(_ rgbValue: UInt64) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat (1.0))
    }
    
}
