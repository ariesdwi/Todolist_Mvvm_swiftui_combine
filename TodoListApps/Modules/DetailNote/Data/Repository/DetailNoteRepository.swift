//
//  DetailNoteRepository.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import Combine

internal protocol DetailNoteRepository {
    func fetchNoteById(id: String) -> AnyPublisher<NoteModel?, NetworkError>
    func updateNoteDetails(param: UpdateNoteRequestDTO) -> AnyPublisher<EmptyResponse, NetworkError>
    func deleteNoteById(id: String) -> AnyPublisher<EmptyResponse, NetworkError>
}
