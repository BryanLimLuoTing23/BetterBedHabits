import SwiftUI

struct CircularTimerView: View {
    
    @Binding var resetTimer: Bool
    
    init(timeLimit: TimeInterval, resetTimer: Binding<Bool>) {
        self.timeLimit = timeLimit
        self._resetTimer = resetTimer
    }
    
    @State var color: Color = .black
    @State var timeElapsed: TimeInterval = 0
    var timeLimit: TimeInterval
    @State var timer: Timer?
    
    var body: some View {
        VStack {
            CircularProgressBar(progress: CGFloat(timeElapsed) / CGFloat(timeLimit), color: (completed() ? Color.orange : Color.green))
                .frame(width: 200, height: 200)
            
            Clock(timeElapsed: timeElapsed, timeLimit: timeLimit)
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
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeElapsed < self.timeLimit {
                self.timeElapsed += 1
            } else {
                // Timer completed, reset timeElapsed to 0
                self.timeElapsed = 0
                // Restart the timer
                self.startTimer()
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
                    .trim(from: 0.0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                )
        }
    }
}

struct Clock: View {
    var timeElapsed: TimeInterval
    var timeLimit: TimeInterval
    
    var body: some View {
        VStack {
            Text(timeLeftToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }
    
    func timeLeftToMinutes() -> String {
        let currentTime = timeLimit - timeElapsed
        let seconds = Int(currentTime.modulo( 60))
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
