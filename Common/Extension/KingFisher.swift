//
//  KingFisher.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/14.
//  Copyright © 2018年 加地　正法. All rights reserved.
//  Note: https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet

import Foundation
import Kingfisher

final class KingfisherUtil: NSObject {

    static func setup() {
        // 必要に応じて書きを実行
//        // Cookieを共有させるためにURLSessionConfiguration.defaultを使う
//        KingfisherManager.shared.downloader.sessionConfiguration
//            = URLSessionConfiguration.default
    }
}

extension Kingfisher where Base: ImageView {

    /// エラーイメージを指定して画像を取得
    ///
    /// - Parameters:
    ///   - with: リソース
    ///   - errorImage: エラー時画像
    ///   - placeholder: プレースホルダー
    ///   - options: オプション
    ///   - isDispLoading: ローディングインジケータの表示有無
    ///   - progressBlock: ローディング中処理
    ///   - completionHandler: 完了時処理
    func setImage(with: Resource?,
                  errorImage: UIImage? = nil,
                  placeholder: UIImage? = nil,
                  options: KingfisherOptionsInfo? = nil,
                  isDispLoading: Bool = false,
                  progressBlock: ((Int64, Int64) -> Void)? = nil,
                  completionHandler: ((Image?, NSError?, CacheType, URL?) -> Void)? = nil
        ) {

        if isDispLoading {
            self.base.showIndicator()
        }

        setImage(with: with,
                 placeholder: placeholder,
                 options: options,
                 progressBlock: progressBlock,
                 completionHandler: {
                    [weak base] (image, error, type, url) in
                    guard let weakBase = base else {
                        return
                    }
                    // インジケータを非表示にする
                    if isDispLoading {
                        weakBase.hideIndicator()
                    }
                    let isError = error != nil || image == nil

                    if let errorImage = errorImage, isError {
                        weakBase.image = errorImage
                    }
                    completionHandler?(image, error, type, url)
            }
        )
    }

}
