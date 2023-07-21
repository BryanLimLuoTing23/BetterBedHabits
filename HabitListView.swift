import SwiftUI

struct HabitListView: View {
    @ObservedObject var userHabitData: UserHabitData
    @State private var isShowingEditView = false
    
    var body: some View {
        VStack {
            List {
                ForEach(userHabitData.model.habitModel.optionsList) { habitOption in
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
            HabitEditView(userHabitData: $userHabitData, isShowingEditView: $isShowingEditView)
        }
    }
    
    private func saveAndDismiss() {
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

