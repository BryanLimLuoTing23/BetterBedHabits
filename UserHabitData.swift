//
//  UserHabitData.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation
import SwiftUI



class UserHabitData : ObservableObject{
    
    static var currentIndex = 0
    
    @Published var HabitData: [HabitModel] =
        
        [HabitModel(habitName: "Fill habit here 1",
                    
                    duration: 10,
                    
                    optionsList:[ HabitOption(id: 10, option: "Mark as finished" ),
                                  HabitOption(id: 11, option: "Unable to complete")]
                   ),
         HabitModel(habitName: "Fill habit here 2",
                    
                    duration: 10,
                    optionsList: [HabitOption(id: 20, option: "Mark as finished"),
                                  HabitOption(id: 21, option: "Unable to complete")])
         
         ,
         HabitModel(habitName: "Fill habit here 3",
                    
                    duration: 20,
                    optionsList: [HabitOption(id: 30, option: "Mark as finished"),
                                  HabitOption(id: 31, option: "Unable to complete")])
         
        ]
    
    
     
  //model property represents curent habit
  //Gets updated by verifyHabitCompleted
    @Published var model: Habits = Habits(currentHabitIndex: 0, habitModel: HabitModel(habitName: "", duration: 0, optionsList: []), routineCompleted: false)
    //Declare model as an instance of Habits
    
    init() {
        model = createHabitModel(i: UserHabitData.currentIndex)
    }
    //Explanation: now since model is @Published, if model is updated, all views are triggered to be auto-updated.
    
    func createHabitModel ( i: Int ) -> Habits {
        return Habits(currentHabitIndex: i, habitModel: HabitData[i], routineCompleted: false)
    }
    //It returns a new Habits() object, for one habit
    //habitModel is a convention for the MVVM model.
    //Here, habitModel stores the data for ONE habit
     
    
    
    func verifyHabitCompleted(selectedOption: HabitOption) {
        
        for index in model.habitModel.optionsList.indices {
            model.habitModel.optionsList[index].isMatched = false
            model.habitModel.optionsList[index].isSelected = false
        }
        if let index = model.habitModel.optionsList.firstIndex(where: {$0.option == selectedOption.option})  { //Get index of current habit
            if selectedOption.option == "Mark as finished" {
                model.habitModel.optionsList[index].isMatched = true
                model.habitModel.optionsList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (UserHabitData.currentIndex < 2) {
                        UserHabitData.currentIndex = UserHabitData.currentIndex+1
                        self.model = self.createHabitModel(i: UserHabitData.currentIndex)
                    } else {
                        self.model.routineCompleted = true
                    }
                }
            }else {
                
                model.habitModel.optionsList[index].isSelected = true
            }
            
            
            
        }
    }
    func restart() {
        UserHabitData.currentIndex = 0
        model = createHabitModel(i: UserHabitData.currentIndex)
    }
}


