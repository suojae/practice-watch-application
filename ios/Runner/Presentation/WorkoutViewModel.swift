import Combine

class WorkoutViewModel: ObservableObject {
    @Published var state = WorkoutState()

    private var cancellables = Set<AnyCancellable>()
    private let workoutTimerUseCase: WorkoutTimerUseCase
    private let workoutSessionUseCase: WorkoutSessionUseCase

    init(workoutTimerUseCase: WorkoutTimerUseCase = WorkoutTimerUseCase(),
         workoutSessionUseCase: WorkoutSessionUseCase = WorkoutSessionUseCase()) {
        self.workoutTimerUseCase = workoutTimerUseCase
        self.workoutSessionUseCase = workoutSessionUseCase

        workoutTimerUseCase.elapsedTimePublisher
            .sink { [weak self] time in
                self?.state.elapsedTime = time
            }
            .store(in: &cancellables)
    }

    func handleEvent(_ event: WorkoutEvent) {
        switch event {
        case .startWorkout:
            startWorkout()
        case .stopWorkout:
            stopWorkout()
        case .resetTimer:
            resetTimer()
        }
    }

    private func startWorkout() {
        workoutSessionUseCase.startSession()
        workoutTimerUseCase.start()
        state.isWorkoutActive = true
    }

    private func stopWorkout() {
        workoutSessionUseCase.stopSession()
        workoutTimerUseCase.stop()
        state.isWorkoutActive = false
    }

    private func resetTimer() {
        workoutTimerUseCase.reset()
        state.elapsedTime = 0
    }
}
