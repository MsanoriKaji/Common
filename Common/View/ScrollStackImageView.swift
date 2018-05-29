//
//  ScrollStackImageView.swift
//  Common
//
//  Created by ma_kaji on 2018/05/29.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

import UIKit

final class ScrollStackImageView: ScrollStackView {
    public let urls: [String]
    public var dispWidth = UIScreen.main.bounds.size.width

    init(urls: [String]) {
        self.urls = urls
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        super.setup()

        for urlString in urls {
            guard let url = URL(string: urlString) else {
                continue
            }
            let imageView = UIImageView()
            imageView.isHidden = true // 通信成功までは非表示
            stackView.addArrangedSubview(imageView)

            imageView.kf.setImage(with: url,
                                  completionHandler: { [weak self] (image, error, _, _) in
                                    guard let weakSelf = self,
                                        let image = image,
                                        error == nil else {
                                            return
                                    }

                                    imageView.snp.makeConstraints { make in
                                        let ratio = image.size.height / image.size.width
                                        make.width.equalTo(weakSelf.dispWidth)
                                        make.height.equalTo(imageView.snp.width).multipliedBy(ratio)
                                    }
                                    imageView.isHidden = false

            })

        }
    }

}
