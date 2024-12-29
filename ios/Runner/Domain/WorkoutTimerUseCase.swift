import Combine

class WorkoutTimerUseCase {
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0
    private let elapsedTimeSubject = PassthroughSubject<TimeInterval, Never>()

    var elapsedTimePublisher: AnyPublisher<TimeInterval, Never> {
        elapsedTimeSubject.eraseToAnyPublisher()
    }

    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.elapsedTime += 1
            self.elapsedTimeSubject.send(self.elapsedTime)
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        stop()
        elapsedTime = 0
        elapsedTimeSubject.send(elapsedTime)
    }
}
