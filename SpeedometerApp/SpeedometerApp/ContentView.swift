import SwiftUI
import MapKit
import UIKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    @State private var showWorkoutSummary = false
    @State private var workoutSummaryData: WorkoutSummaryData?

    var formattedElapsedTime: String {
        let time = Int(locationManager.elapsedTime)
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    var formattedDistance: String {
        let distanceInMiles = locationManager.totalDistance * 0.000621371 // Convert meters to miles
        return String(format: "%.2f miles", distanceInMiles)
    }

    var averageSpeed: Double {
        let distanceInMiles = locationManager.totalDistance * 0.000621371 // Convert meters to miles
        let timeInHours = locationManager.elapsedTime / 3600
        if timeInHours > 0 {
            return distanceInMiles / timeInHours
        } else {
            return 0.0
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                switch locationManager.authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse:
                    VStack {
                        // Map View
                        Map(
                            coordinateRegion: $region,
                            showsUserLocation: true,
                            userTrackingMode: .constant(.follow)
                        )
                        .frame(height: 300)
                        .onAppear {
                            if let location = locationManager.lastLocation {
                                updateRegion(location)
                            }
                        }
                        .onChange(of: locationManager.lastLocation) { newLocation in
                            if let location = newLocation {
                                updateRegion(location)
                            }
                        }

                        // Speed Display
                        Text(String(format: "%.2f mph", locationManager.speed))
                            .font(.system(size: 72))
                            .fontWeight(.bold)
                            .padding()

                        // Workout Controls
                        if locationManager.isWorkoutActive {
                            // Display Workout Data
                            VStack {
                                Text("Elapsed Time: \(formattedElapsedTime)")
                                Text("Distance: \(formattedDistance)")
                                Text(String(format: "Average Speed: %.2f mph", averageSpeed))
                            }
                            .font(.title2)
                            .padding()

                            // End Workout Button
                            Button(action: {
                                // Prepare data for summary view
                                workoutSummaryData = WorkoutSummaryData(
                                    elapsedTime: formattedElapsedTime,
                                    distance: formattedDistance,
                                    averageSpeed: String(format: "%.2f mph", averageSpeed)
                                )
                                locationManager.endWorkout()
                                showWorkoutSummary = true // Trigger navigation
                            }) {
                                Text("End Workout")
                                    .font(.title2)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding([.leading, .trailing])
                        } else {
                            // Start Workout Button
                            Button(action: {
                                locationManager.startWorkout()
                            }) {
                                Text("Start Workout")
                                    .font(.title2)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding([.leading, .trailing])
                        }
                    }
                case .notDetermined:
                    Text("Requesting location access...")
                        .onAppear {
                            locationManager.requestWhenInUseAuthorization()
                        }
                case .restricted, .denied:
                    VStack {
                        Text("Location access denied.")
                            .foregroundColor(.red)
                        Button("Open Settings") {
                            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(appSettings)
                            }
                        }
                        .padding()
                    }
                default:
                    Text("Unexpected authorization status.")
                }
            }
            .navigationBarTitle("Workout", displayMode: .inline)
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            .alert(item: $locationManager.locationError) { identifiableError in
                Alert(
                    title: Text("Location Error"),
                    message: Text(identifiableError.error.localizedDescription),
                    dismissButton: .default(Text("OK")) {
                        // Clear the error after dismissing the alert
                        locationManager.locationError = nil
                    }
                )
            }
            // Navigation Link to the summary view
            .background(
                NavigationLink(
                    destination: WorkoutSummaryView(workoutData: workoutSummaryData),
                    isActive: $showWorkoutSummary,
                    label: { EmptyView() }
                )
                .hidden()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Optional: Improves navigation on iPad
    }

    private func updateRegion(_ location: CLLocation) {
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    }
}
