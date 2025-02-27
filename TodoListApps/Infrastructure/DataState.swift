//
//  DataState.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation

enum DataState<T>: Equatable {
    case initiate
    case loading
    case failed(reason: NetworkError)
    case inProgress(progress: Double)
    case success(data: T)

    public var value: T? {
        if case .success(let data) = self {
            return data
        }
        return nil
    }

    public var error: Error? {
        if case .failed(let error) = self {
            return error
        }
        return nil
    }

    public static func == (lhs: DataState<T>, rhs: DataState<T>) -> Bool {
        lhs.localIdentifier == rhs.localIdentifier
    }

    private var localIdentifier: Int {
        switch self {
        case .initiate: 0
        case .loading: 1
        case .failed: 2
        case .inProgress: 3
        case .success: 4
        }
    }
}
