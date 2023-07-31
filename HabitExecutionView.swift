//
//  HabitExecutionView.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation

import SwiftUI

// Main view for habit execution i.e. ContentView


 struct HabitExecutionView: View {
    @ObservedObject var userHabitData : UserHabitData
     @State private var isShowingHabitListView = false
  
    
    
    
     var body: some View {
        ZStack{
                   VStack {
            Text("Execute your habits: ")
                .font(.largeTitle
                    .weight(.bold))
                .foregroundColor(.orange)
                .padding()
            
            Text("Current habit: \(userHabitData.model.habitModel.habitName )")
                .foregroundColor(.black)
                .font(.system(size: 23))
            
             
            if ($userHabitData.model.routineCompleted.wrappedValue) {
                RoutineCompletedView(userHabitData: userHabitData)
            }
                else{
                    VStack {
                        Text("User perscribed duration - " + String(userHabitData.model.habitModel.duration) + " minutes" ) // Displays name of current object
                            .padding()
                        
                        
                        Spacer()
                        
                        HabitOptionsView(userHabitData: userHabitData)
                        //Pass in Habit object to HabitOptionsView
                        
                         Spacer()
                        
                        Button("Refresh and restart") {
                            userHabitData.restart()
                        }
                            
                        Spacer()
                        
                    }
                }
            }
        
        
            }
         
         
        }
    }


struct HabitExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        HabitExecutionView(userHabitData: UserHabitData())
    }
}

    
