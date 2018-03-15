//
//  ApiClientError.swift
//  Common
//
//  Created by 加地　正法 on 2018/03/15.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation

public enum ApiClientErrorType: Error, Comparable {
    case APIError
    case NetworkError
    case JsonParseError
    case MappingError
    case UnknownError
    case Canceled

    init(errorCode: String, causes: [String]) {
        switch errorCode {
        case ApiClientErrorType.APIError.toCode(): self = .APIError
        case ApiClientErrorType.NetworkError.toCode(): self = .NetworkError
        case ApiClientErrorType.JsonParseError.toCode(): self = .JsonParseError
        case ApiClientErrorType.MappingError.toCode(): self = .MappingError
        case ApiClientErrorType.Canceled.toCode(): self = .Canceled
        default:
            self = ApiClientErrorType.UnknownError
        }
    }

    public func toCode() -> String {
        let statusCode: String

        switch self {
        case .APIError:
            statusCode = "APIError"
        case .NetworkError:
            statusCode = "NetworkError"
        case .JsonParseError:
            statusCode = "JsonParseError"
        case .MappingError:
            statusCode = "MappingError"
        case .UnknownError:
            statusCode = "UnKnownError"
        case .Canceled:
            statusCode = "Canceled"
        }

        return statusCode
    }
}

public func  == (lhs: ApiClientErrorType, rhs: ApiClientErrorType) -> Bool {
    return lhs.toCode() == rhs.toCode()
}

public func  != (lhs: ApiClientErrorType, rhs: ApiClientErrorType) -> Bool {
    return lhs.toCode() != rhs.toCode()
}

public func  <= (lhs: ApiClientErrorType, rhs: ApiClientErrorType) -> Bool {
    return lhs.toCode() <= rhs.toCode()
}

public func  >= (lhs: ApiClientErrorType, rhs: ApiClientErrorType) -> Bool {
    return lhs.toCode() >= rhs.toCode()
}

public func  < (lhs: ApiClientErrorType, rhs: ApiClientErrorType) -> Bool {
    return lhs.toCode() < rhs.toCode()
}

public func  > (lhs: ApiClientErrorType, rhs: ApiClientErrorType) -> Bool {
    return lhs.toCode() > rhs.toCode()
}

public struct ApiClientError {
    var type: ApiClientErrorType = ApiClientErrorType.UnknownError
    var response: ApiResponse?

    init (response: ApiResponse?){
        guard let response: ApiResponse = response else {
            return
        }
        type = ApiClientErrorType(errorCode: response.code, causes: response.causes)
        self.response = response
    }

    init (type: ApiClientErrorType) {
        self.type = type
    }
}
