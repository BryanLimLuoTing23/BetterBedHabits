import SwiftUI

struct HabitOptionsView: View {
    var userHabitData: UserHabitData
    var columns: [GridItem] = Array(repeating: GridItem(.fixed(90), spacing: 20), count: 2)
    var body: some View { 
        LazyVGrid(columns: columns, alignment: .center, spacing: 30 ) {
            ForEach ( userHabitData.model.habitModel.optionsList) {
                HabitOptionLooper in 
                OptionBoxView(habitOption: HabitOptionLooper)
                    .onTapGesture {
                        userHabitData.verifyHabitCompleted(selectedOption: HabitOptionLooper)
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
                OptionSelectedImageDisplayer(imageName: "Filled Checkbox" )
            }
            else if ( habitOption.isMatched == false) &&  (habitOption.isSelected == true ){
                OptionSelectedImageDisplayer(imageName: "Crossed" )
            }
            else { 
                DefaultCheckBoxView(habitOption: habitOption)
            }
        }.frame(width: 100, height: 100)
            .background(Color.gray)
    }
}

struct DefaultCheckBoxView: View {
    var habitOption: HabitOption
    var body: some View {
        VStack{
            Text(habitOption.habitId)
                .font(.system(size: 19))
                .frame(width: 80, height: 50)
                .foregroundColor(.black)
                .cornerRadius(3.0, antialiased: true)
            
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

