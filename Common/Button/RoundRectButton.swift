//
//  RoundRectButton.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
final class RoundRectButton: UIButton {

    // MARK: - Properties
    /// 角丸半径
    @IBInspectable internal var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    /// 境界線の太さ
    @IBInspectable internal var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /// 境界線の色
    @IBInspectable internal var borderColor: UIColor? {
        didSet {
            setNeedsLayout()
        }
    }

    /// ハイライト時の境界線の色
    @IBInspectable internal var highlightedBorderColor: UIColor? = nil {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Initializing / Deinitializing
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override internal func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    /**
     初期化
     */
    func commonInit() {
        clipsToBounds = true
    }

    // MARK: - Life Cycle
    override internal func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth

        var setColor: CGColor?

        if state == UIControlState.highlighted {
            setColor = highlightedBorderColor?.cgColor
        } else {
            setColor = borderColor?.cgColor
        }
        if let label = titleLabel, setColor == nil {
            setColor = label.textColor.cgColor
        }
        layer.borderColor = setColor
    }

}
