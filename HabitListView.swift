import SwiftUI

public struct HabitListView: View {
    @ObservedObject var userHabitData: UserHabitData
    @Binding private var isShowingEditView = false
    @Binding private var editedHabitNames: [String] = []
    
    //Initially you need a copy of the current data.
    
    var body: some View {
        for index in UserHabitData.HabitData.indices{
            editedHabitNames.append(userHabitData.HabitData[index].habitName)
        }
        
        VStack {
            List {
                ForEach(editedHabitNames.indices, id: \.self) { index in
                    HabitListItemView(habitName: editedHabitNames[index])
                }
            }
            .listStyle(InsetGroupedListStyle())
            Spacer()
            Button(action: {
                isShowingEditView = true
            }) {
                Text("Edit")
            }
            Button(action: {
                saveAndDismiss()
            }) {
                Text("Confirm")
            }
        }
        .padding()
        .navigationBarTitle("Habit List")
        .sheet(isPresented: $isShowingEditView) {
            HabitEditView(editedHabitNames: $editedHabitNames, isShowingEditView: $isShowingEditView)
        }
    }
    
    private func saveAndDismiss() {
        // Update the original userHabitData with the edited habits
        for index in editedHabitNames.indices{
            UserHabitData.HabitData[index].habitName = editedHabitNames[index]
        }
        
        isShowingEditView = false
    }
}

struct HabitListItemView: View {
    var habitName: String
    
    var body: some View {
        Text(habitName)
            .font(.headline)
    }
}


