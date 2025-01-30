//
//  ListNoteRequestDTO.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation

internal struct ListNoteRequestDTO: Codable {
    let id: String
    let title: String
    let description: String
    let todoCount: Int32
    let priority: String
}

