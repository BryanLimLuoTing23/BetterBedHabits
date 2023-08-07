//
//  HabitListView.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//


//TODO Remove Edit Button, and then just have the save data button.
// The save button will be grayed out when no changes are made, but will be made blue when changes are made and you need to save.

//Or just auto save and auto edit?
import Foundation
import SwiftUI

public struct HabitListView: View {
    @ObservedObject var userHabitData: UserHabitData
    @State private var isShowingEditView = true
    @State private var editedHabitNames: [String] = []
    @State private var editedDurationArray: [TimeInterval]
    = []
    @State private var dataHasChanges = false

    func moveHabitItem(from source: IndexSet, to destination: Int) {
        editedHabitNames.move(fromOffsets: source, toOffset: destination)
        editedDurationArray.move(fromOffsets: source, toOffset: destination)
    }
    
    
    
    func deleteHabitItem(at offsets: IndexSet) {
        editedHabitNames.remove(atOffsets: offsets)
        editedDurationArray.remove(atOffsets: offsets)
    }
    
    //Change background color when editing

    public var body: some View {
        VStack {
            List {
                Section(header: Text("Habit names")){
                    ForEach(editedHabitNames.indices, id: \.self) { index in
                        if isShowingEditView {
                            TextField("Enter new habit", text: $editedHabitNames[index])
                                .onChange(of: editedHabitNames[index]) { newValue in
                                    editedHabitNames[index] = newValue
                                    dataHasChanges = true
                                }
                        } else {
                            Text(editedHabitNames[index])
                        }
                    }
                    .onMove(perform: moveHabitItem)
                    .onDelete(perform: deleteHabitItem)
                    
                }
                Section(header: Text("Estimated time needed (minutes)")){
                    ForEach(editedDurationArray.indices, id: \.self) {
                        index in
                        Text(editedHabitNames[index] + " duration: " + String(format: "%.1f", editedDurationArray[index]) + " minutes")
                            .foregroundColor(.blue)
                        
                        Slider(value: $editedDurationArray[index],
                               in: 0.2...30,
                               step: 0.2)
                        .onChange(of: editedDurationArray[index]) { newValue in
                            editedDurationArray[index] = newValue
                            dataHasChanges = true
                        }
                        
                        
                    }
                    .onMove(perform: moveHabitItem)
                    .onDelete(perform: deleteHabitItem)
                    
                    
                    
                }
                
            }
            .listStyle(SidebarListStyle())

            Spacer()
            HStack{
                
                
                Spacer()
                
                Button("Save data") {
                    updateHabitData()
                }
                .foregroundColor(dataHasChanges ? .blue : .gray)
                .disabled(!dataHasChanges)
                
                Spacer()
                
                
                Button("+") {
                    editedHabitNames.append("New Habit")
                    editedDurationArray.append(10)
                    dataHasChanges = true
                }
                
                
                
            }
            .padding()
            .onAppear {
                editedHabitNames = userHabitData.HabitData.map { $0.habitName }
                editedDurationArray = userHabitData.HabitData.map { $0.duration }
            } //Retrieve current habit names into the edit buffer array
            
            
        }

            
        }
        
    private func updateHabitData() {
        var newHabitData: [HabitModel] = []
        // Update the original userHabitData with the edited habits
        for index in editedHabitNames.indices {
            newHabitData.append( HabitModel(habitName: editedHabitNames[index],
                                            
                                            duration: editedDurationArray[index],
                
                                            optionsList: [HabitOption(id: Int( String("\(index+1)0")   )!, option: "Mark as finished"),
                                                          HabitOption(id: Int(String("\(index+1)1"))!, option: "There's no giving up")
                                                                                                           ])
            )
            
            userHabitData.HabitData = newHabitData
            
         
        }

        dataHasChanges = false
    }
}


struct HabitListItemView: View{
    var habitName: String
    
    var body: some View {
        Text(habitName)
            .font(.headline)
    }
    
}
