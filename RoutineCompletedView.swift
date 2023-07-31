//
//  RoutineCompletedView.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation
import SwiftUI


struct RoutineCompletedView: View {
    @ObservedObject var userHabitData : UserHabitData
    
    var body: some View {
        Text("Routine finished")
        
        Spacer()
        
        Button("Restart") {
            userHabitData.restart()
        }
            
    }
    
}
