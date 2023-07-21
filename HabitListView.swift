import SwiftUI

struct ContentView: View {
    @State private var itemList: [String]
    @State private var editMode = EditMode.inactive
    
    init() {
        _itemList = State(initialValue: UserDefaults.standard.stringArray(forKey: "defaultHabitList") ?? ["Habit 1", "Habit 2", "Habit 3"])
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(itemList.indices, id: \.self) { index in
                    NavigationLink(destination: EditItemView(item: $itemList[index])) {
                        Text(itemList[index])
                    }
                }
                .onDelete { indexSet in
                    itemList.remove(atOffsets: indexSet)
                    updateUserHabitList()
                }
                .onMove { indices, newOffset in
                    itemList.move(fromOffsets: indices, toOffset: newOffset)
                    updateUserHabitList()
                }
            }
            .navigationBarTitle("Habit list")
            .navigationBarItems(leading: EditButton())
            .environment(\.editMode, $editMode)
        }
    }
    
    func updateUserHabitList() {
        UserDefaults.standard.set(itemList, forKey: "defaultHabitList")
    }
}

struct EditItemView: View {
    @Binding var item: String
    
    var body: some View {
        Form {
            TextField("Edit Habit", text: $item)
        }
        .navigationBarTitle("Rename Habit")
    }
}
