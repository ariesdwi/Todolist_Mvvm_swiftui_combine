//
//  ListNoteRow.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//


import SwiftUI

struct ListNoteRow: View {
    // MARK: - Properties
    var text: String
    var description: String
    var priority: NoteModel.Priority
    @Binding var isCompleted: Bool
    var onMarkComplete: () -> Void
    var onDelete: () -> Void

    // MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(text)
                    .font(.headline)
                    .strikethrough(isCompleted, color: .gray)
                    .foregroundColor(isCompleted ? .gray : .primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                // Description
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .truncationMode(.tail)

                // Priority
                Text("Priority: \(priority.rawValue)")
                    .font(.footnote)
                    .foregroundColor(colorForPriority(priority))
            }

            Spacer()

            // Mark Complete Button
            Button(action: onMarkComplete) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .green : .blue)
                    .imageScale(.large)
            }
            .buttonStyle(BorderlessButtonStyle())

            // Delete Button
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .imageScale(.large)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
        .accessibilityElement(children: .combine)
    }

    // Helper for priority colors
    private func colorForPriority(_ priority: NoteModel.Priority) -> Color {
        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        case .all:
            return .black
        }
    }
}
