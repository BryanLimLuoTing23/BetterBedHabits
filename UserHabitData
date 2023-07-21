import SwiftUI

// Stores user habits object
// Similar to GameManagerVM

class UserHabitData : ObservableObject{
    
    static var currentIndex = 0
    
    static func createHabitModel ( i: Int ) -> Habits {
        return Habits(currentHabitIndex: i, habitModel: HabitData[i], routineCompleted: false)
    }
    
    @Published var model = UserHabitData.createHabitModel(i: UserHabitData.currentIndex)
    
    
    func verifyHabitCompleted(selectedOption: HabitOption) {
        
        for index in model.habitModel.optionsList.indices {
            model.habitModel.optionsList[index].isMatched = false
            model.habitModel.optionsList[index].isSelected = false
        }
        if let index = model.habitModel.optionsList.firstIndex(where: {$0.habitId == selectedOption.habitId}) {
            if selectedOption.habitId == model.habitModel.bestOption {
                model.habitModel.optionsList[index].isMatched = true
                model.habitModel.optionsList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (UserHabitData.currentIndex < 2) {
                        UserHabitData.currentIndex = UserHabitData.currentIndex+1
                        self.model = UserHabitData.createHabitModel(i: UserHabitData.currentIndex)
                    } else {
                        self.model.routineCompleted = true
                    }
                }
            }else {
                model.habitModel.optionsList[index].isMatched = false
                model.habitModel.optionsList[index].isSelected = true
            }
            
            
            
        }
    }
}

extension UserHabitData{
    
    static var HabitData: [HabitModel]{
        
       [HabitModel(habitName: "Wash face", 
                   bestOption: "Choice 1", duration: 10, 
                   
                   optionsList:[ HabitOption(id: 10, habitId: "Choice 1", option: "Mark as finished", colour: Color.teal ),
                                 HabitOption(id: 11, habitId: "Choice 2", option: "Give up", colour: Color.red)] 
                   ),
        HabitModel(habitName: "Drink warm water", 
       
                   bestOption: "Choice 1", duration: 10, 
                   optionsList: [HabitOption(id: 20, habitId: "Choice 1", option: "Mark as finished", colour: Color.teal),
                   HabitOption(id: 21, habitId: "Choice 2", option: "Unable to complete", colour: Color.red)])
                   
               ,
       HabitModel(habitName: "Meditate", 
                  bestOption: "Choice 1", duration: 20, 
                  optionsList: [HabitOption(id: 30, habitId: "Choice 1", option: "Mark as finished", colour: Color.teal),
                                HabitOption(id: 31, habitId: "Choice 2", option: "Unable to complete", colour: Color.red)])
       
       ]
    }
    
    
}

