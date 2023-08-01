import SwiftUI

struct ContentView: View {
    @State var color: Color = .blue
    
    @State var timeElapsed: Int = 0
    var countTo: Int = 68
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeElapsed < self.countTo {
                self.timeElapsed += 1
            }
        }
    }
    
    var body: some View {
        VStack {
            CircularProgressBar(progress: CGFloat(timeElapsed) / CGFloat(countTo), color: (completed() ? Color.orange : Color.green))
                .frame(width: 200, height: 200)
            
            Clock(timeElapsed: timeElapsed, countTo: countTo)
        }
        .onAppear {
            _ = self.timer // Start the timer when the view appears
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(timeElapsed) / CGFloat(countTo))
    }
}

struct CircularProgressBar: View {
    var progress: CGFloat
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
    }
}

struct Clock: View {
    var timeElapsed: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(timeLeftToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }
    
    func timeLeftToMinutes() -> String {
        let currentTime = countTo - timeElapsed
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
