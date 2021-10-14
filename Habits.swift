//
//  Habits.swift
//  HabitTracker
//
//  Created by Jake King on 13/08/2021.
//

import Foundation

class Habits: ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded,
                                          forKey: "Habits")
            }
            print("Loaded the user's habits.")
        }
    }
    
    func updateHabits() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded,
                                      forKey: "Habits")
            print("Updated the user's habits.")
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self,
                                                 from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
