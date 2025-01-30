//
//  ListNoteRepository.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation
import Combine

internal protocol ListNoteRepository {
    func fetch() -> AnyPublisher<[NoteModel]?, NetworkError>
    func save(param: ListNoteRequestDTO) -> AnyPublisher<Bool, NetworkError>
    func update(param: UpdateNoteRequestDTO) -> AnyPublisher<EmptyResponse, NetworkError>
    func delete(id: String) -> AnyPublisher<EmptyResponse, NetworkError>
}
