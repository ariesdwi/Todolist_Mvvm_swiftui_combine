//
//  ListNoteUseCase.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation
import Combine

internal protocol ListNoteUseCase {
    func fetch() -> AnyPublisher<[NoteModel]?, NetworkError>
    func save(param: ListNoteParameter) -> AnyPublisher<Bool, NetworkError>
    func update(param: UpdateNoteParameter) -> AnyPublisher<EmptyResponse, NetworkError>
    func delete(id: String) -> AnyPublisher<EmptyResponse, NetworkError>
}

internal final class DefaultNoteListUseCase: ListNoteUseCase {
    private let repository: ListNoteRepository
    
    init(
        repository: ListNoteRepository
    ) {
        self.repository = repository
    }

    func fetch() -> AnyPublisher<[NoteModel]?, NetworkError> {
        repository.fetch()
    }
    
    func save(param: ListNoteParameter) -> AnyPublisher<Bool, NetworkError> {
        repository.save(param: param.toRequest())
    }
    
    func update(param: UpdateNoteParameter) -> AnyPublisher<EmptyResponse, NetworkError> {
        repository.update(param: param.toRequest())
    }
    
    func delete(id: String) -> AnyPublisher<EmptyResponse, NetworkError> {
        repository.delete(id: id)
    }
}
