//
//  Habit.swift
//  HabitTracker
//
//  Created by Jake King on 13/08/2021.
//

import Foundation

struct Habit: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int
}
