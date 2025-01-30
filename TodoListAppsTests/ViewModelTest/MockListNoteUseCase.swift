//
//  MockListNoteUseCase.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import Combine
@testable import TodoListApps

final class MockListNoteUseCase: ListNoteUseCase {

    var fetchResult: Result<[NoteModel], Error> = .success([])
    var saveResult: Result<Bool, Error> = .success(true)
    var updateResult: Result<Void, Error> = .success(())
    var deleteResult: Result<Void, Error> = .success(())
    
    func fetch() -> AnyPublisher<[NoteModel]?, NetworkError> {
        switch fetchResult {
        case .success(let notes):
            return Just(notes)
                .map { $0 }
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            
        case .failure:
            
            return Fail(error: NetworkError.noData)
                .eraseToAnyPublisher()
        }
    }
    
    func save(param: TodoListApps.ListNoteParameter) -> AnyPublisher<Bool, TodoListApps.NetworkError> {
        switch saveResult {
        case .success(let success):
            return Just(success)
                .setFailureType(to: TodoListApps.NetworkError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! TodoListApps.NetworkError)
                .eraseToAnyPublisher()
        }
    }

    func update(param: TodoListApps.UpdateNoteParameter) -> AnyPublisher<TodoListApps.EmptyResponse, TodoListApps.NetworkError> {
        switch updateResult {
        case .success:
            return Just(TodoListApps.EmptyResponse())
                .setFailureType(to: TodoListApps.NetworkError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! TodoListApps.NetworkError)
                .eraseToAnyPublisher()
        }
    }

    func delete(id: String) -> AnyPublisher<TodoListApps.EmptyResponse, TodoListApps.NetworkError> {
        switch deleteResult {
        case .success:
            return Just(TodoListApps.EmptyResponse())
                .setFailureType(to: TodoListApps.NetworkError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! TodoListApps.NetworkError)  
                .eraseToAnyPublisher()
        }
    }
}
