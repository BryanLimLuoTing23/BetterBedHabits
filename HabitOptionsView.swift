//
//  HabitOptionsView.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation
import SwiftUI


struct HabitOptionsView: View {
    @ObservedObject var userHabitData: UserHabitData
    @Binding var resetTimer: Bool
    var columns: [GridItem] = Array(repeating: GridItem(.fixed(90), spacing: 20), count: 2)
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 30 ) {
            ForEach ( userHabitData.model.habitModel.optionsList) {  //For each option
                currentHabitOption in
                OptionBoxView(habitOption: currentHabitOption)   //Show the optionboxview
                    .onTapGesture { //Modifier to the OptionBoxView
                        userHabitData.verifyHabitCompleted(selectedOption: currentHabitOption)
                        //Check if option is the right option
                        
                        if currentHabitOption.option == "Mark as finished" {
                            resetTimer = true // Add this line
                                                }
                    }
            }
        }
    }
}

struct OptionBoxView : View {
    
    var habitOption: HabitOption
    var body: some View {
        VStack{
            if (habitOption.isMatched) && (habitOption.isSelected) {
                OptionSelectedImageDisplayer(imageName: "Filled checkbox" )
            }
            else if ( habitOption.isMatched == false) &&  (habitOption.isSelected == true ){
                OptionSelectedImageDisplayer(imageName: "Crossed" )
            }
            else {
                DefaultCheckBoxView(habitOption: habitOption)
            }
        }.frame(width: 100, height: 80)
            .border(Color.black, width: 2)
    }
}

struct DefaultCheckBoxView: View {
    var habitOption: HabitOption
    var body: some View {
        VStack{
            
            Text(habitOption.option)
                .frame(width: 90, height: 90)
                .font(.system(size: 19))
                .foregroundColor(.brown)
                .opacity(1)
            
        }
    }
    
}

struct OptionSelectedImageDisplayer: View {
    var imageName : String
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets( top: 30, leading: 30, bottom: 30, trailing: 30))
            .foregroundColor(.blue)
        
    }
    
}
