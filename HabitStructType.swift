//
//  HabitStructType.swift
//  Bedtime Bliss
//
//  Created by Bryan Lim Luo Ting on 30/07/2023.
//

import Foundation
import SwiftUI



//Creates class for Habits to be stored

struct Habits {
    var habitModel : HabitModel
    var routineCompleted: Bool
}
struct HabitModel{
    var habitName: String
    var duration: TimeInterval
    var optionsList: [HabitOption]
}

struct HabitOption : Identifiable {
    //Try deleting int?
    var id: Int
    var option: String
    var isSelected : Bool = false
    var isMatched : Bool = false //Swift's way of putting default
    
}


//You can add inherited structs when habits become more nuanced

