import SwiftUI

//Creates class for Habits to be stored

struct Habits {
    var currentHabitIndex: Int
    var habitModel : HabitModel
    var routineCompleted: Bool
}
struct HabitModel{
    var habitName: String
    var bestOption: String
    var duration: TimeInterval
    var optionsList: [HabitOption]
}

struct HabitOption : Identifiable {
    var id: Int
    var habitId: String // delete if unused
    var option: String
    var colour: Color
    var isSelected : Bool = false
    var isMatched : Bool = false //Swift's way of putting default
    
}


//You can add inherited structs when habits become more nuanced 

