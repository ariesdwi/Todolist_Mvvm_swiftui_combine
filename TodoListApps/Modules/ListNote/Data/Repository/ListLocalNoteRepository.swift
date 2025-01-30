//
//  LocalListNoteRepository.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation
import Combine
import CoreData

internal final class ListLocalNoteRepository: ListNoteRepository {
    
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TodoListApps")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
        
    func fetch() -> AnyPublisher<[NoteModel]?, NetworkError> {
        return Future<[NoteModel]?, NetworkError> { promise in
            let context = self.container.viewContext
            context.perform {
                let fetchRequest: NSFetchRequest<NoteLocalEntity> = NoteLocalEntity.fetchRequest() 

                do {
                    let localNotes = try context.fetch(fetchRequest)
                    let models = localNotes.compactMap { $0.toDomain() }
                    promise(.success(models))
                } catch {
                    promise(.failure(.noData))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(param: ListNoteRequestDTO) -> AnyPublisher<Bool, NetworkError> {
        return Future<Bool, NetworkError> { promise in
            let context = self.container.viewContext
            context.perform {
                let entity = NoteLocalEntity(context: context)
                entity.id = param.id
                entity.title = param.title
                entity.todoCount = param.todoCount
                entity.completed = false
                entity.descriptionnote = param.description
                entity.priority = param.priority
                
                do {
                    try context.save()
                    promise(.success(true))
                } catch {
                    promise(.failure(.noData))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(param: UpdateNoteRequestDTO) -> AnyPublisher<EmptyResponse, NetworkError> {
        return Future<EmptyResponse, NetworkError> { promise in
            let context = self.container.viewContext
            context.perform {
                let fetchRequest: NSFetchRequest<NoteLocalEntity> = NoteLocalEntity.fetchRequest() 

                fetchRequest.predicate = NSPredicate(format: "id == %@", param.id)
                
                do {
                    if let entity = try context.fetch(fetchRequest).first {
                        entity.completed = param.completed
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
    
    func delete(id: String) -> AnyPublisher<EmptyResponse, NetworkError> {
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
