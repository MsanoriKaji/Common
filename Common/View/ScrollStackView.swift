//
//  ScrollStackView.swift
//  Common
//
//  Created by ma_kaji on 2018/05/29.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import Library

// ScrollViewとStackViewによる共通部品
class ScrollStackView: UIScrollView {
    let stackView = UIStackView()

    var viewHeight: CGFloat {
        return self.height
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// StackView/ScrollViewへの追加の設定はsetupをoverrideして実装
    func setup() {
        self.addFixSubView(stackView)
        stackView.axis = .vertical

    }

    func addArrangedSubview(view: UIView?) {
        guard let addView = view else {
            return
        }
        stackView.addArrangedSubview(addView)
        stackView.layoutIfNeeded()
        updateContentSize()
    }

    private func updateContentSize() {
        self.contentSize = CGSize(width: 0.0, height: stackView.height)
    }
}
