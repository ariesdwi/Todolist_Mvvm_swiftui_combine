//
//  ListNoteLocalEntity.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation
import CoreData

extension NoteLocalEntity {
    func toDomain() -> NoteModel {
        return NoteModel(
            id: self.id ?? "",
            title: self.title ?? "",
            descriptionnote: self.descriptionnote ?? "",
            todoCount: Int(self.todoCount),
            completed: self.completed,
            priority: NoteModel.Priority(rawValue: self.priority ?? "Low") ?? .low         )
    }
}
