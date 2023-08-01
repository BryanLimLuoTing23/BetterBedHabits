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
        Spacer()
        
        Image(systemName: "powersleep")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
        Text("Routine finished. Have a good night's recovery.")
            .shadow(radius: 10)
            .font(.subheadline)
        
        
        Spacer()
        
        
        RoundedRectangle(cornerRadius:30)
            .frame(width:220, height:40)
            .foregroundColor(.white)
            .padding(10)
            .overlay(
        Button("Restart") {
            userHabitData.restart()
            
        }
        .frame(width:200)
        .font(.headline)
        )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 220, height:40)
            )
        
        
        Spacer()
            
    }
    
}
