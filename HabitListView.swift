//
//  HabitListView.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation
import SwiftUI

public struct HabitListView: View {
    @ObservedObject var userHabitData: UserHabitData
    @State private var isShowingEditView = false
    @State private var editedHabitNames: [String] = []
    @State private var durationTestArray: [TimeInterval]
    = [1,2,3]

    func moveHabitItem(from source: IndexSet, to destination: Int) {
        editedHabitNames.move(fromOffsets: source, toOffset: destination)
        durationTestArray.move(fromOffsets: source, toOffset: destination)
    }
    
    
    
    func deleteHabitItem(at offsets: IndexSet) {
        editedHabitNames.remove(atOffsets: offsets)
        durationTestArray.remove(atOffsets: offsets)
    }
    
    //Change background color when editing

    public var body: some View {
        VStack {
            List {
                Section(header: Text("Habit names")){
                    ForEach(editedHabitNames.indices, id: \.self) { index in
                        if isShowingEditView {
                            TextField("Enter new habit", text: $editedHabitNames[index])
                        } else {
                            Text(editedHabitNames[index])
                        }
                    }
                    .onMove(perform: moveHabitItem)
                    .onDelete(perform: deleteHabitItem)
                    
                }
                Section(header: Text("Durations (seconds)")){
                    ForEach(durationTestArray.indices, id: \.self) {
                        index in
                        Text(String(durationTestArray[index]))
                    }
                    .onMove(perform: moveHabitItem)
                    .onDelete(perform: deleteHabitItem)
                    
                    
                    
                }
                
            }
            .listStyle(SidebarListStyle())

            Spacer()
            HStack{
                if !isShowingEditView {
                    Button("Edit") {
                        isShowingEditView = true
                    }
                } else {
                    Button("Done") {
                        isShowingEditView = false
                        updateHabitData()
                    }
                }
                
                Spacer()
                
                Button("Add") {
                    editedHabitNames.append("New Habit")
                    durationTestArray.append(10)
                    
                }
                
            }
            
        }
        .padding()
        .onAppear {
            editedHabitNames = userHabitData.HabitData.map { $0.habitName }
        } //Retrieve current habit names into the edit buffer arrap
    }

    private func updateHabitData() {
        var newHabitData: [HabitModel] = []
        // Update the original userHabitData with the edited habits
        for index in editedHabitNames.indices {
            newHabitData.append( HabitModel(habitName: editedHabitNames[index],
                                            
                                            duration: durationTestArray[index],
                
                                            optionsList: [HabitOption(id: Int( String("\(index+1)0")   )!, option: "Mark as finished"),
                                                          HabitOption(id: Int(String("\(index+1)1"))!, option: "Unable to complete")
                                                                                                           ])
            )
            
            userHabitData.HabitData = newHabitData
            
         
        }

        isShowingEditView = false
    }
}


struct HabitListItemView: View{
    var habitName: String
    
    var body: some View {
        Text(habitName)
            .font(.headline)
    }
    
}

