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
    
    @ObservedObject var userHabitData = UserHabitData()
    var body: some Scene {
        WindowGroup {
            TabView {
                HabitListView(userHabitData: userHabitData)
                                    .tabItem {
                                    Label("Habit List", systemImage: "list.bullet")
                                }
                HabitExecutionView(userHabitData: userHabitData)
                    .tabItem {
                        Label("Execution", systemImage: "play.circle")
                    }
                    .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.purple]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: 500
                                    )
                                )
                
                
            }
        }
    }
}
