//
//  UIColor.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class func color(hex: UInt32) -> UIColor {
        return UIColor.color(hexStr: String(hex), alpha:1.0)
    }

    class func color(hexStr: String, alpha: CGFloat = 1.0) -> UIColor {
        let str = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: str)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            Log.d( "Invalid value")
            return UIColor.clear
        }
    }

}
