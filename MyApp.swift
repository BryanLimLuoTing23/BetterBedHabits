//
//  MyApp.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation
import SwiftUI


@main

struct MyApp: App {
    
    //@ObservedObject var
    var body: some Scene {
        WindowGroup {
            TabView {
                HabitExecutionView(userHabitData: UserHabitData())
                    .tabItem {
                        Label("Execution", systemImage: "play.circle")
                    }
                    .background(Color.green)
                
                HabitListView(userHabitData: UserHabitData())
                    .tabItem {
                    Label("Habit List", systemImage: "list.bullet")
                }
            }
        }
    }
}
