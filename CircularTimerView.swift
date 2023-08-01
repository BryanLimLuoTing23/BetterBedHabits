import SwiftUI

struct CircularTimerView: View {
    
    @Binding var resetTimer: Bool
    
    init(timeLimit: TimeInterval, resetTimer: Binding<Bool>) {
        self.timeLimit = timeLimit
        self._resetTimer = resetTimer
    }
    
    @State var timeElapsed: TimeInterval = 0
    var timeLimit: TimeInterval
    @State var timer: Timer?
    @State var firstTimeCompleted = false
    
    var body: some View {
        VStack {
            CircularProgressBar(progress: CGFloat(timeElapsed) / CGFloat(timeLimit), color: (completed() ? Color.orange : Color.green))
                .frame(width: 200, height: 200)
            Spacer()
            if completed()  {
                Text("You should be finished")
                
            }
            Spacer()
            TimeLeft(timeElapsed: timeElapsed, timeLimit: timeLimit, firstTimeCompleted: $firstTimeCompleted)

        }
        .onAppear {
            self.startTimer() // Start the timer when the view appears
        }
        .onChange(of: resetTimer) { newValue in
            if newValue {
                self.resetTimer = false
                self.timeElapsed = 0
                self.startTimer() // Restart the timer after resetting the timeElapsed
            }
        }
    }
    
    func startTimer() {
        // Invalidate the existing timer, if any
        timer?.invalidate()
        
        // If resetTimer is true, reset the timeElapsed to 0
        if resetTimer {
            timeElapsed = 0
        }
        
        // Start a new timer
        if !firstTimeCompleted {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.timeElapsed < self.timeLimit {
                    self.timeElapsed += 1
                } else {
                    // Timer completed for the first time
                    self.firstTimeCompleted = true
                }
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        if timeElapsed >= timeLimit {
            return 1.0
        } else {
            return (CGFloat(timeElapsed) / CGFloat(timeLimit))
        }
    }
}

struct CircularProgressBar: View {
    var progress: CGFloat
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 130, height: 130)
                .overlay(
                    Circle()
                        .stroke(.gray, lineWidth:25)
                        .opacity(0.5)
                )
                .overlay(
                    Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                )
                
        }
    }
}

struct TimeLeft: View {
    var timeElapsed: TimeInterval
    var timeLimit: TimeInterval
    @Binding var firstTimeCompleted : Bool
    
    var body: some View {
        VStack {
            
            Text(firstTimeCompleted ? "0:00" :  timeLeftToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }
    
    func timeLeftToMinutes() -> String {
        let currentTime = timeLimit - timeElapsed
        let seconds = Int(currentTime.modulo( 60)) // Sooo there was no modulo function for doubles
        let minutes = Int(currentTime / 60)
        
        if seconds == 30 {
                    return "\(minutes):30"
                } else {
                    return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
                }    }
    
}

extension TimeInterval {
    func modulo(_ other: TimeInterval) -> TimeInterval {
        return self - other * floor(self / other)
    }
}
