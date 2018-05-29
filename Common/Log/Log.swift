//
//  File.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import XCGLogger

/// ログ出力用クラス
final public class Log {

    public enum DisplayLogLevel: Int {
        case  error, warrning, debug, info, none
    }

    var logLevel: DisplayLogLevel = .none

    // MARK: - private
    private static let instatnce = Log()

    // MARK: - Property
    static private let log: XCGLogger = {

        let log = XCGLogger.default

        #if DEBUG || ADHOC
            log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLevel: nil)
        #else
            log.setup(level: .none, showThreadName: false, showLevel: false, showFileNames: false, showLineNumbers: false, writeToFile: nil, fileLevel: nil)
        #endif

        let dateFormatter: DateFormatter = DateFormatter.defaultDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss:S"
        dateFormatter.locale = NSLocale.current
        log.dateFormatter = dateFormatter

        return log
    }()

    public class func sharedInstance() -> Log {
        return instatnce
    }

    public func setup(level: DisplayLogLevel) {
        logLevel = level
    }

    // MARK: - Public Method
    /**
     Output the debug level of log.

     - parameter message: ログ出力するオブジェクト
     */
    public class func d(_ message: Any = "", function: StaticString = #function , file: StaticString = #file , line: Int = #line ) {
        guard Log.sharedInstance().logLevel.rawValue >= DisplayLogLevel.debug.rawValue else {
            return
        }
        log.debug("\(message)", functionName: function, fileName: file, lineNumber: line)
    }

    /**
     Output the info level of log.

     - parameter message: ログ出力するオブジェクト
     */
    public class func i(_ message: Any = "", function: StaticString = #function , file: StaticString = #file , line: Int = #line ) {
        guard Log.sharedInstance().logLevel.rawValue >= DisplayLogLevel.info.rawValue else {
            return
        }
        log.info("\(message)", functionName: function, fileName: file, lineNumber: line)
    }

    /**
     Output the warning level of log.

     - parameter message: ログ出力するオブジェクト
     */
    public class func w(_ message: Any = "", function: StaticString = #function , file: StaticString = #file , line: Int = #line ) {
        guard Log.sharedInstance().logLevel.rawValue >= DisplayLogLevel.warrning.rawValue else {
            return
        }
        log.warning("\(message)", functionName: function, fileName: file, lineNumber: line)
    }

    /**
     Output the error level of log.

     - parameter message: ログ出力するオブジェクト
     */
    public class func e(_ message: Any = "", function: StaticString = #function , file: StaticString = #file , line: Int = #line ) {
        guard Log.sharedInstance().logLevel.rawValue >= DisplayLogLevel.error.rawValue else {
            return
        }
        log.error("\(message)", functionName: function, fileName: file, lineNumber: line)
    }


}
