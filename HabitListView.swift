import SwiftUI

struct HabitListView: View {
    @ObservedObject var userHabitData: UserHabitData
    @State private var isShowingEditView = false
    
    // Create a binding to userHabitData
    @Binding private var editedUserHabitData: UserHabitData
    
    init(userHabitData: UserHabitData) {
        self.userHabitData = userHabitData
        _editedUserHabitData = State(initialValue: userHabitData)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(editedUserHabitData.model.habitModel.optionsList) { habitOption in
                    HabitListItemView(habitOption: habitOption)
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
            HabitEditView(userHabitData: $editedUserHabitData, isShowingEditView: $isShowingEditView)
        }
    }
    
    private  func saveAndDismiss() {
        // Update the original userHabitData with the editedUserHabitData
        userHabitData = editedUserHabitData
        isShowingEditView = false
    }
}

struct HabitListItemView: View {
    var habitOption: HabitOption
    
    var body: some View {
        Text(habitOption.habitId)
            .font(.headline)
    }
}
