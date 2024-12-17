import SwiftUI

struct WorkoutSummaryData {
    let elapsedTime: String
    let distance: String
    let averageSpeed: String
}

struct WorkoutSummaryView: View {
    var workoutData: WorkoutSummaryData?

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            if let data = workoutData {
                Text("Elapsed Time: \(data.elapsedTime)")
                    .font(.title2)
                Text("Distance: \(data.distance)")
                    .font(.title2)
                Text("Average Speed: \(data.averageSpeed)")
                    .font(.title2)
            } else {
                Text("No data available.")
                    .font(.title2)
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Summary", displayMode: .inline)
    }
}
