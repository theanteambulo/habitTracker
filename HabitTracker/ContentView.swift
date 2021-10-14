//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jake King on 13/08/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var displayAddHabit = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(habits.items) { item in
                        NavigationLink(destination: ViewHabitDetail(habits: self.habits,
                                                                    habit: item)) {
                            VStack(alignment: .leading) {
                                Text("\(item.name)")
                                    .font(.headline.bold())
                                Text("\(item.description)")
                                    .lineLimit(1)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationBarTitle("HabitApp")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                    self.displayAddHabit.toggle()
                                }) {
                                    Text("+")
                                        .font(.title)
                                })
            .sheet(isPresented: $displayAddHabit) {
                AddHabit(habits: self.habits)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
