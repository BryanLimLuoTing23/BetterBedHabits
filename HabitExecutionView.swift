
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
     @State var color: Color = .blue
     @State private var resetTimer = false
         
     //Computed property : updates everytime it is accessed
    
    
    
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
                        
                        HabitOptionsView(userHabitData: userHabitData, resetTimer: $resetTimer)

                        //Pass in Habit object to HabitOptionsView
                        
                        Spacer()
                        
                        CircularTimerView(timeLimit: ( userHabitData.model.habitModel.duration)*60,  resetTimer: $resetTimer )
                        
                        Spacer()
                        
                        Button("Refresh and restart") {
                            userHabitData.restart()
                            resetTimer.toggle()
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

    
