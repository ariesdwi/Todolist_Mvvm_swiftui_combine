//
//  DetailNoteUseCase.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import Combine
import Foundation

internal protocol DetailNoteUseCase {
    func fetchNoteById(id: String) -> AnyPublisher<NoteModel?, NetworkError>
    func updateNoteDetails(param: UpdateNoteRequestDTO) -> AnyPublisher<EmptyResponse, NetworkError>
    func deleteNoteById(id: String) -> AnyPublisher<EmptyResponse, NetworkError>
}

internal final class DefaultDetailNoteUseCase: DetailNoteUseCase {
    private let repository: DetailNoteRepository
    
    init(
        repository: DetailNoteRepository
    ) {
        self.repository = repository
    }

    func fetchNoteById(id: String) -> AnyPublisher<NoteModel?, NetworkError> {
        repository.fetchNoteById(id: id)
    }
    
    func updateNoteDetails(param: UpdateNoteRequestDTO) -> AnyPublisher<EmptyResponse, NetworkError> {
        repository.updateNoteDetails(param: param)
    }
    
    func deleteNoteById(id: String) -> AnyPublisher<EmptyResponse, NetworkError> {
        repository.deleteNoteById(id: id)
    }
}
