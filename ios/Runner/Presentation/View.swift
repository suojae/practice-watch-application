import SwiftUI
import Combine

struct WorkoutView: View {
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some View {
        VStack {
            Text("Workout Timer")
                .font(.headline)
            Text("\(viewModel.state.elapsedTime, specifier: "%.1f") seconds")
                .font(.largeTitle)
            if viewModel.state.isWorkoutActive {
                Button("Stop") {
                    viewModel.handleEvent(.stopWorkout)
                }
            } else {
                Button("Start") {
                    viewModel.handleEvent(.startWorkout)
                }
            }
        }
        .padding()
    }
}
