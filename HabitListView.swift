import SwiftUI

public struct HabitListView: View {
    @ObservedObject var userHabitData: UserHabitData
    @State private var isShowingEditView = false
    @State private var editedHabitNames: [String] = []
    
    public var body: some View {
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
        .onAppear {
            if editedHabitNames.isEmpty {
                for index in userHabitData.HabitData.indices {
                    editedHabitNames.append(userHabitData.HabitData[index].habitName)
                }
            }
        }
    }
    
    private func saveAndDismiss() {
        // Update the original userHabitData with the edited habits
        for index in editedHabitNames.indices {
            userHabitData.HabitData[index].habitName = editedHabitNames[index]
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
