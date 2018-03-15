//
//  String.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

// 正規表現用文字列
// 数値(半角)
fileprivate let kHalfNumber = "[0-9]+"
// 数値(全角)
fileprivate let kFullNumber = "[０-９]+"

extension String {

    var half: String {
        return convertFullToHalf(reverse: false)
    }

    var full: String {
        return convertFullToHalf(reverse: true)
    }

    var halfOnlyNumber: String {
        return convertFullToHalfNumber(reverse: false)
    }

    var fullOnlyNumber: String {
        return convertFullToHalfNumber(reverse: true)
    }

    private func convertFullToHalf(reverse: Bool) -> String {
        let str = NSMutableString(string: self) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return str as String
    }

    private func convertFullToHalfNumber(reverse: Bool) -> String {
        var str = self
        let pattern = reverse ? kHalfNumber : kFullNumber
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [] )
            let results = regex.matches(in: str, options: [], range: NSMakeRange(0, str.count))

            results.reversed().forEach {
                let subStr = (str as NSString).substring(with: $0.range)
                str = str.replacingOccurrences(
                    of: subStr,
                    with: reverse ? subStr.full : subStr.half
                )
            }
            return str
        } catch {
            return ""
        }
    }

    func isEmpty() -> Bool {
        return self.count == 0
    }

    func isExist() -> Bool {
        return self.count > 0
    }

    /*!
     バイト長

     - returns: バイト長
     */
    func byteLength() -> Int {
        return self.lengthOfBytes(using: String.Encoding.utf16)
    }

    func substring(from: Int = 0, to: Int = -1) -> String {

        let fromIndex: Int = from < 0 ? 0 : from
        let toIndex: Int = to > count ?  count : to

        return substring(with: index(startIndex, offsetBy: fromIndex)..<index(startIndex, offsetBy: toIndex))
    }

    func substring(length: Int) -> String {
        return substring(from: 0, to: length)
    }


    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    /*!
     フォーマットを指定し文字列を日付に変換
     デフォルトフォーマット：yyyy-MM-dd HH:mm:ss

     - parameter format: フォーマット

     - returns: Date
     */
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter.defaultDateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }


    /*!
     自身をTrimする(前後のスペース及び改行コードを削除)
     */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /*!
     URLエンコーディングを行った文字列を返却する

     - returns: URLエンコーディング済み文字列
     */
    func urlEncodingString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
    }

    /*!
     UTF-8の文字列長オーバーを判定する

     - parameter maxsize: 最大サイズ

     - returns: true:文字列長オーバー
     */
    func isOverMaxUTF8String(maxsize: Int) -> Bool {
        return lengthOfBytes(using: String.Encoding.utf8) > maxsize
    }

    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }

    /*!
     クエリを分解する

     - returns: クエリ情報をkey=パラメータ名、value=指定値の配列　で返却 keyは小文字で保存する
     */
    func splitQuery() -> [String: [String]] {
        var dict = [String: [String]]()
        let keyValues = self.trim().components(separatedBy: "&")
        for keyValue in keyValues {
            let params = keyValue.components(separatedBy: "=")
            if params.count == 2 {
                let key = params[0].lowercased()
                dict[key] = params[1].components(separatedBy: ",")
            }
        }
        return dict
    }

    func intValue() -> Int? {
        return Int(self)
    }

}
