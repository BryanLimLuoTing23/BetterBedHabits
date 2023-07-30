import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HabitExecutionView(userHabitData: UserHabitData())
                    .tabItem {
                        Label("Execution", systemImage: "play.circle")
                    }
                    .background(Color.green)
                NavigationView {
                    HabitListView(userHabitData: UserHabitData())
                }
                .tabItem {
                    Label("Habit List", systemImage: "list.bullet")
                }
            }
        }
    }
}
