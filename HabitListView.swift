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

    func move(from source: IndexSet, to destination: Int) {
        editedHabitNames.move(fromOffsets: source, toOffset: destination)
    }

    func deleteItem(at offsets: IndexSet) {
        editedHabitNames.remove(atOffsets: offsets)
    }

    public var body: some View {
        VStack {
            List {
                ForEach(editedHabitNames.indices, id: \.self) { index in
                    if isShowingEditView {
                        TextField("Enter new habit", text: $editedHabitNames[index])
                    } else {
                        Text(editedHabitNames[index])
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: deleteItem)
            }
            .listStyle(SidebarListStyle())

            Spacer()

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
                                            
                duration: 10,
                
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

