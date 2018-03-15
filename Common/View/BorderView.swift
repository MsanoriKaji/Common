//
//  BorderView.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit

public struct BorderStyle: OptionSet {
    public let rawValue: Int

    public init( rawValue : Int) {
        self.rawValue = rawValue
    }

    static let None = BorderStyle( rawValue: 0 ) // 0
    static let Top = BorderStyle( rawValue: 1 << 0) // 1
    static let Bottom = BorderStyle( rawValue: 1 << 1) // 2
    static let Left = BorderStyle( rawValue:  1 << 2) // 4
    static let Right = BorderStyle( rawValue: 1 << 3) // 8

    static let All: BorderStyle  = [.Top, .Bottom, .Left, .Right]
    static let Side: BorderStyle = [.Left, .Right]
}

public class BorderView : UIView {

    @IBInspectable public var borderWidth: CGFloat = 0.0
    @IBInspectable public var borderColor: UIColor = UIColor.clear
//    @IBInspectable
    public var borderStyleType: BorderStyle = .None

    @IBInspectable var borderStyle: Int {
        get {
            return self.borderStyleType.rawValue
        }
        set( type ) {
            self.borderStyleType = BorderStyle(rawValue: type)
        }
    }


    func drawBorder(borderStyle: BorderStyle, borderWidth: CGFloat, borderColor: UIColor?) {

        self.borderStyleType = borderStyle
        self.borderWidth = borderWidth
        self.borderColor = borderColor ?? UIColor.clear

        self.setNeedsLayout()

    }

    override public func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setLineWidth(borderWidth)
        context.setStrokeColor(borderColor.cgColor)

        if borderStyleType.contains(.Top) {
            context.move(to: CGPoint.zero)
            context.addLine(to: CGPoint(x: width, y: 0.0))
            context.strokePath()
        }

        if borderStyleType.contains(.Bottom) {
            context.move(to: CGPoint(x: 0.0, y: height))
            context.addLine(to: CGPoint(x: width, y: height))
            context.strokePath()
        }

        if borderStyleType.contains(.Left) {
            context.move(to: CGPoint.zero)
            context.addLine(to: CGPoint(x: 0.0, y: height))
            context.strokePath()
        }

        if borderStyleType.contains(.Right) {
            context.move(to: CGPoint(x: width, y: 0))
            context.addLine(to: CGPoint(x: width, y: height))
            context.strokePath()
        }
    }
}
