import SwiftUI

// Main view for habit execution i.e. ContentView


 struct HabitExecutionView: View {
    @ObservedObject var userHabitData : UserHabitData
     @State private var isShowingHabitListView = false
  
    
    
    
     var body: some View {
        ZStack{ 
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill) //modifiers are changeable 
                .ignoresSafeArea()
            //Linear gradient, and add other decorators
        VStack {
            Text("Execute your habits: ")
                .font(.largeTitle
                    .weight(.bold))
                .foregroundColor(.orange)
                .padding()
            
            Text("Current habit: \(userHabitData.model.habitModel.habitName )")
                .foregroundColor(.orange)
                .font(.system(size: 23))
            
            Button(action: {
                isShowingHabitListView = true
                
            }) {Text("View Habit List")}
            
            if (userHabitData.model.routineCompleted) {
                RoutineCompletedView()
            }
                else{ 
                    VStack {
                        Text(userHabitData.model.habitModel.habitName) // Displays name of current object
                            .padding()
                        
                        
                        Spacer()
                        
                        HabitOptionsView(userHabitData: userHabitData)
                        //Pass in Habit object to HabitOptionsView
                        
                        NavigationLink(destination: HabitListView(userHabitData: userHabitData)) {
                            Text("View Habit List")
                        }
                        
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

    
