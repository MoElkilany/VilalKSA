
//
//  APIResult.swift
//  SCISP
//
//  Created by Mostafa Aboghida on 07/05/2023.
//
import Moya

enum APIResult<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum APIError: Error {
    case errorMessage(message: String, status: Int)
    case requestFailed
    case unknownError

    static func mapError(_ error: Error) -> APIError {
        if let apiError = error as? APIError {
            return apiError
        } else {
            return .unknownError
        }
    }

    static func moyaError(_ error: MoyaError) -> APIError {
        switch error {
        case .underlying(let underlyingError):
            if let apiError = underlyingError as? APIError {
                return apiError
            }
        default:
            break
        }
        return .unknownError
    }
}

