import Foundation
import CoreLocation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: Error
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var speed: CLLocationSpeed = 0.0
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var lastLocation: CLLocation?
    @Published var locationError: IdentifiableError?
    
    // Workout properties
    @Published var isWorkoutActive: Bool = false
    @Published var workoutStartTime: Date?
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var totalDistance: Double = 0.0
    
    private var previousLocation: CLLocation?
    private var workoutTimer: Timer?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = locationManager.authorizationStatus
    }
    
    // Method to request authorization
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Methods to start and stop updating location
    func startUpdating() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Workout Control Methods
    
    func startWorkout() {
        isWorkoutActive = true
        workoutStartTime = Date()
        elapsedTime = 0.0
        totalDistance = 0.0
        previousLocation = lastLocation
        startTimer()
    }
    
    func endWorkout() {
        isWorkoutActive = false
        stopTimer()
    }
    
    private func startTimer() {
        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let startTime = self.workoutStartTime {
                self.elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    private func stopTimer() {
        workoutTimer?.invalidate()
        workoutTimer = nil
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        DispatchQueue.main.async {
            self.authorizationStatus = status
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                self.startUpdating()
                self.previousLocation = self.lastLocation
            } else {
                self.stopUpdating()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let speedInMPH = location.speed >= 0 ? location.speed * 2.23694 : 0.0 // Ensure no negative speeds
            DispatchQueue.main.async {
                self.speed = speedInMPH
                self.lastLocation = location
                
                if self.isWorkoutActive {
                    if let prevLocation = self.previousLocation {
                        let distance = location.distance(from: prevLocation) // Distance in meters
                        self.totalDistance += distance
                    }
                    self.previousLocation = location
                }
            }
        } else {
            DispatchQueue.main.async {
                self.speed = 0.0
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed with error: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.locationError = IdentifiableError(error: error)
        }
    }
}
