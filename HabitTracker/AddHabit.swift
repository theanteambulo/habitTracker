//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Jake King on 13/08/2021.
//

import SwiftUI

struct AddHabit: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    @State private var completionCount = 0
    @State private var habitValid = false
    @State private var nameError = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name",
                          text: $name)
                
                TextField("Description",
                          text: $description)
            }
            .navigationTitle("Add habit")
            .navigationBarItems(trailing:
                                    Button("Save") {
                                        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
                                        let description = self.description.trimmingCharacters(in: .whitespacesAndNewlines)
                                        
                                        if (name == "" || description == "") {
                                            self.habitValid.toggle()
                                        } else {
                                            let item = Habit(name: name,
                                                            description: description,
                                                            completionCount: self.completionCount)
                                            self.habits.items.append(item)
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                    .alert(isPresented: $habitValid) {
                                        Alert(title: Text("Missing Information"),
                                              message: Text("Please enter all the details of your new habit."),
                                              dismissButton: .default(Text("OK")))
                                    }
            )
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
