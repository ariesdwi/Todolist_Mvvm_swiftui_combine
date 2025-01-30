//
//  UpdateNoteRequest.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//


import Foundation

internal struct UpdateNoteRequestDTO: Codable {
    let id: String
    let title: String
    let completed: Bool
    let description: String
    let priority: String
}
