import SwiftUI

struct HabitEditView: View {
    @Binding var userHabitData: UserHabitData
    @Binding var isShowingEditView: Bool
    @State private var editedHabitNames: [String]
    
    init(userHabitData: Binding<UserHabitData>, isShowingEditView: Binding<Bool>) {
        _userHabitData = userHabitData
        _isShowingEditView = isShowingEditView
        _editedHabitNames = State(initialValue: userHabitData.wrappedValue.model.habitModel.optionsList.map { $0.habitId })
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(editedHabitNames.indices, id: \.self) { index in
                    TextField("Habit \(index + 1)", text: $editedHabitNames[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Button(action: {
                saveEditedHabits()
            }) {
                Text("Save")
            }
        }
        .padding()
        .navigationBarTitle("Edit Habits")
    }
    
    private func saveEditedHabits() {
        userHabitData.model.habitModel.optionsList.indices.forEach { index in
            userHabitData.model.habitModel.optionsList[index].habitId = editedHabitNames[index]
        }
        
        isShowingEditView = false
    }
}





