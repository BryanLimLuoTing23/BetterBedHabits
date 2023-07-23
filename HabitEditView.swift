import SwiftUI

struct HabitEditView: View {
    @Binding var editedHabitNames: [String]
    @Binding var isShowingEditView: Bool
    
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
        isShowingEditView = false
    }
}
