//
//  ViewHabitDetail.swift
//  HabitTracker
//
//  Created by Jake King on 13/08/2021.
//

import SwiftUI

struct ViewHabitDetail: View {
    @ObservedObject var habits: Habits
    var habit: Habit
    @State private var completionCount = 0
    
    var body: some View {
        ScrollView(.vertical) {
            Text("\(self.habit.name)")
                .font(.title)
            
            Text("\(self.habit.description)")
            
            Text("\(self.completionCount)")
            
            Button("Complete") {
                self.completionCount += 1
            }
            
            Button("Update habits") {
                self.updateHabit()
            }
        }
        .onAppear() {
            self.completionCount = self.habit.completionCount
        }
    }
    
    func updateHabit() {
        if let itemIndex = self.habits.items.firstIndex(where: { $0.id == habit.id }) {
            let tempHabit = Habit(name: self.habit.name,
                                  description: self.habit.description,
                                  completionCount: self.completionCount)
            
            self.habits.items.remove(at: itemIndex)
            self.habits.items.insert(tempHabit,
                                     at: itemIndex)
            self.habits.updateHabits()
        }
    }
}

struct ViewHabitDetail_Previews: PreviewProvider {
    static let habit = Habit(id: UUID(),
                             name: "",
                             description: "",
                             completionCount: 0)
    
    static var previews: some View {
        ViewHabitDetail(habits: Habits(),
                        habit: habit)
    }
}
