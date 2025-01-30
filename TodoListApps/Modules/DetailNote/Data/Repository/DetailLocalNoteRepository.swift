//
//  DetailLocalNoteRepository.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import Foundation
import Combine
import CoreData

internal final class LocalDetailNoteRepository: DetailNoteRepository {
    private let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "TodoListApps")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func fetchNoteById(id: String) -> AnyPublisher<NoteModel?, NetworkError> {
        return Future<NoteModel?, NetworkError> { promise in
            let context = self.container.viewContext
            context.perform {
                let fetchRequest: NSFetchRequest<NoteLocalEntity> = NoteLocalEntity.fetchRequest() 
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)

                do {
                    if let entity = try context.fetch(fetchRequest).first {
                        promise(.success(entity.toDomain()))
                    } else {
                        promise(.failure(.noData))
                    }
                } catch {
                    promise(.failure(.genericError(error: error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateNoteDetails(param: UpdateNoteRequestDTO) -> AnyPublisher<EmptyResponse, NetworkError> {
        return Future<EmptyResponse, NetworkError> { promise in
            let context = self.container.viewContext
            context.perform {
                let fetchRequest: NSFetchRequest<NoteLocalEntity> = NoteLocalEntity.fetchRequest() 
                fetchRequest.predicate = NSPredicate(format: "id == %@", param.id)

                do {
                    if let entity = try context.fetch(fetchRequest).first {
                        entity.title = param.title
                        entity.descriptionnote = param.description
                        entity.priority = param.priority
                        
                        try context.save()
                        promise(.success(EmptyResponse()))
                    } else {
                        promise(.failure(.noData))
                    }
                } catch {
                    promise(.failure(.genericError(error: error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteNoteById(id: String) -> AnyPublisher<EmptyResponse, NetworkError> {
        return Future<EmptyResponse, NetworkError> { promise in
            let context = self.container.viewContext
            context.perform {
                let fetchRequest: NSFetchRequest<NoteLocalEntity> = NoteLocalEntity.fetchRequest() 
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)

                do {
                    if let entity = try context.fetch(fetchRequest).first {
                        context.delete(entity)
                        try context.save()
                        promise(.success(EmptyResponse()))
                    } else {
                        promise(.failure(.noData))
                    }
                } catch {
                    promise(.failure(.genericError(error: error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
