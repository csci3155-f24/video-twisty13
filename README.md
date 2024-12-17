Speedometer App - Tristan Barnes & Ali Haroon

Video Link: https://youtu.be/sI2_r-wJWU0

Overview

The Speedometer App is a Swift-based iOS application that leverages CoreLocation and SwiftUI to provide real-time GPS tracking for workouts. Users can monitor their speed, distance, and workout duration while navigating through a simple, intuitive interface. This project demonstrates the seamless integration of CoreLocation with SwiftUI and highlights key programming concepts such as callbacks, state management, and abstract data types.

Repository Contents

README.md: This file, providing a detailed explanation of the project.

LocationManager.swift: Handles location updates, workout tracking, and CoreLocation integration.

ContentView.swift: Defines the main UI, including real-time speed display and workout controls.

WorkoutSummaryView.swift: Displays a summary of the user's workout.

SpeedometerAppApp.swift: Entry point of the application.

Info.plist: Configuration file for app permissions and properties.

SpeedometerAppTests.swift: Unit tests for the app's functionality.

SpeedometerAppUITests.swift: UI tests for ensuring a seamless user experience.

Features

Real-Time Speed Tracking: Displays the user's current speed in miles per hour.

Workout Monitoring: Tracks elapsed time, total distance, and average speed during a workout.

Workout Summary: Provides a detailed summary at the end of each workout.

Map Integration: Shows the user’s real-time location on a map.

State Management: Uses SwiftUI's @State and @StateObject for dynamic UI updates.

Smooth User Experience: Combines the Swift frameworks to deliver a responsive interface that handles background location updates efficiently.

Setup Instructions

Clone the repository:

git clone <repository-url>

Open the project in Xcode:

open SpeedometerApp.xcodeproj

Ensure that you have a physical device connected or a simulator running iOS 14.0 or later.

Request location permissions by navigating to Info.plist and ensuring the NSLocationWhenInUseUsageDescription key is properly set.

Run the app:

Cmd + R

How the App Works

On launch, the app requests location permissions.

Users can start a workout by tapping the "Start Workout" button.

During a workout, the app tracks speed, distance, and elapsed time in real-time.

The user can end the workout to view a summary of their performance.

Key Concepts

CoreLocation

Callbacks: The didUpdateLocations delegate method processes location updates asynchronously. It ensures that the app handles GPS tracking without blocking the main thread.

Authorization: The app uses requestWhenInUseAuthorization to request location access dynamically. The authorization status is managed to determine if location services are allowed.

Location Data: CoreLocation provides CLLocation objects, which encapsulate location coordinates, speed, and other information.

SwiftUI

SwiftUI is used to build a modular and dynamic UI:

State Management: The app uses @State and @StateObject to manage the state of the app and reflect changes dynamically in the UI. The LocationManager class is observed using @StateObject.

Composable Views: The UI is split into composable views such as ContentView (real-time tracking UI) and WorkoutSummaryView (summary screen).

Dynamic Updates: Real-time speed and distance values are automatically updated in the UI as the state changes, ensuring smooth user interaction.

Programming Concepts

Functions as Values: The Timer.scheduledTimer function in LocationManager demonstrates passing functions as arguments to run repetitive tasks, such as updating elapsed workout time.

Callbacks: CoreLocation's delegate methods (e.g., didUpdateLocations) act as callbacks, which are invoked whenever new location data is available.

Abstract Data Types (ADT): CoreLocation objects like CLLocation and CLLocationCoordinate2D abstract location details, allowing easy access to distance and coordinate calculations.

Object-Oriented Programming (OOP): The app utilizes Swift classes like LocationManager to encapsulate location functionality, ensuring clean and modular code design.

Swift Framework Usage

The Speedometer App relies heavily on two Swift frameworks:

CoreLocation

CoreLocation is a powerful framework for accessing location data and processing GPS updates. It works through the CLLocationManager, which interacts with the system to receive user location updates.

Delegation Pattern: The CLLocationManagerDelegate allows the app to receive asynchronous location updates through methods like didUpdateLocations.

Accuracy and Filtering: The app specifies kCLLocationAccuracyBest for precise updates and filters updates based on changes in distance.

SwiftUI

SwiftUI simplifies UI creation by using a declarative approach. Features include:

Declarative Syntax: UI components like Text, Button, and Map are created using a declarative syntax that dynamically reflects changes in app state.

Bindings: SwiftUI bindings such as $region in the Map View synchronize data between the model and view.

Navigation: The app uses NavigationLink for transitioning between views, providing a clean user experience.

---

Script for Video Tutorial

Introduction (1.5 minutes)

Greeting:

"Hi everyone! Welcome to our tutorial on building a real-time Speedometer App using Swift, CoreLocation, and SwiftUI. We're excited to guide you through this project step by step."

Overview:

"In this video, we'll explore the key features of our Speedometer App, discuss its implementation, and connect it to essential programming concepts such as callbacks, state management, and abstract data types. We'll also share some insights from our learning journey with Swift."

Objective:

"By the end of this tutorial, you'll have a clear understanding of how to create a similar app and grasp the underlying concepts that make it work."
Our Journey Learning Swift (2 minutes)

Introduction to Swift:

"When we decided to build this app, we knew that mastering Swift was essential. Swift is Apple's powerful and intuitive programming language for iOS development, known for its safety, performance, and modern syntax."

Learning Process:

"We started by diving into Swift's fundamentals—learning about variables, data types, control flow, and object-oriented programming. Utilizing resources like Apple's official Swift documentation, online courses, and community forums helped us build a strong foundation."

Applying Knowledge:

"Building the Speedometer App was a practical way for us to apply what we learned. It allowed us to tackle real-world problems, such as handling asynchronous location updates and managing state in a dynamic user interface."
CoreLocation Integration (4 minutes)

Explain CoreLocation:

"CoreLocation is a robust framework that enables GPS-based tracking in iOS apps. It provides precise location data, including latitude, longitude, speed, and heading information, which are crucial for our Speedometer App."

Delegation and Callbacks:

"We use CLLocationManager along with its delegate method didUpdateLocations to receive location updates asynchronously. This delegation pattern ensures our app responds to location changes in real-time without blocking the main thread."

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
        let speedInMPH = location.speed >= 0 ? location.speed * 2.23694 : 0.0
        DispatchQueue.main.async {
            self.speed = speedInMPH
        }
    }
}

Location Permissions:

"To access location data, our app requests the user's permission dynamically using requestWhenInUseAuthorization(). It's important to update the Info.plist with NSLocationWhenInUseUsageDescription to explain why the app needs access to their location."

Distance Calculation:

"Beyond speed, our app calculates the total workout distance by tracking the distance between consecutive location updates using location.distance(from: previousLocation). This allows users to see how far they've traveled during their workout."
SwiftUI Integration (4 minutes)

Dynamic UI with SwiftUI:

"SwiftUI revolutionizes how we build user interfaces with its declarative syntax. It allows us to create dynamic and responsive UIs that update in real-time based on data changes using state management tools like @StateObject."

Example UI Element:

"Let's look at how we display the speed in our ContentView.swift:"

Text(String(format: "%.2f mph", locationManager.speed))
    .font(.system(size: 72))
    .fontWeight(.bold)

Composable Views:

"We've organized our app into separate, reusable views to keep the codebase clean and manageable. For instance, ContentView handles the real-time tracking, while WorkoutSummaryView displays the workout results."
Programming Concepts (3 minutes)

Callbacks:

"The didUpdateLocations method is a perfect example of a callback. It's invoked automatically when new location data is available, allowing our app to handle updates asynchronously."

Functions as Values:

"In Swift, functions can be treated as first-class citizens. For example, we use a timer with a closure to perform repeated tasks:"

Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
    // Perform repeated task
}

Abstract Data Types:

"CLLocation is an abstract data type that encapsulates location-related properties, simplifying tasks like calculating distance and speed without worrying about the underlying implementation."
Building the App Step-by-Step (6 minutes)

Project Setup:

"We started by setting up a new SwiftUI project in Xcode named 'SpeedometerApp'. Ensuring that Swift and SwiftUI were selected during setup was crucial for seamless integration."

Implementing LocationManager:

"Our LocationManager class handles all location-related functionalities. It initializes CLLocationManager, requests permissions, and starts updating the location:"

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var speed: Double = 0.0
    @Published var totalDistance: Double = 0.0
    private var previousLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        if let previous = previousLocation {
            let distance = location.distance(from: previous) / 1609.34 // Convert to miles
            totalDistance += distance
        }

        previousLocation = location

        let speedInMPH = location.speed >= 0 ? location.speed * 2.23694 : 0.0
        DispatchQueue.main.async {
            self.speed = speedInMPH
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}

Designing the ContentView:

"In ContentView, we display the current speed and provide navigation to the workout summary:"

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var showingSummary = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Current Speed")
                    .font(.headline)
                    .padding(.top, 50)

                Text(String(format: "%.2f mph", locationManager.speed))
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()

                Spacer()

                Button(action: {
                    showingSummary = true
                }) {
                    Text("View Summary")
                        .font(.title2)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
                .sheet(isPresented: $showingSummary) {
                    WorkoutSummaryView(totalDistance: locationManager.totalDistance, duration: 3600) // Example duration
                }
            }
            .navigationBarTitle("Speedometer", displayMode: .inline)
        }
    }
}

Creating WorkoutSummaryView:

"The WorkoutSummaryView displays the total distance and workout duration:"

struct WorkoutSummaryView: View {
    var totalDistance: Double
    var duration: TimeInterval

    var body: some View {
        VStack {
            Text("Workout Summary")
                .font(.largeTitle)
                .padding()

            HStack {
                Text("Distance:")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.2f miles", totalDistance))
                    .font(.body)
            }
            .padding()

            HStack {
                Text("Duration:")
                    .font(.headline)
                Spacer()
                Text(formatDuration(duration))
                    .font(.body)
            }
            .padding()

            Spacer()
        }
        .padding()
    }

    func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

Conclusion (1.5 minutes)

Recap:

"In this tutorial, we walked through building a real-time Speedometer App using Swift, CoreLocation, and SwiftUI. We integrated CoreLocation for GPS tracking, designed a dynamic UI with SwiftUI, and applied key programming concepts like callbacks, state management, and abstract data types."

Encouragement:

"We encourage you to try building this app yourself. Once you're comfortable with the basics, consider adding more features such as elevation tracking or offline maps to enhance the app's functionality."

Acknowledging Our Learning:

"Working on this project together reinforced our understanding of Swift and iOS development. Collaborating allowed us to tackle challenges more effectively and share valuable insights."

Outro:

"Thank you for watching! If you found this tutorial helpful, please give it a thumbs up and subscribe for more iOS development content. Feel free to leave any questions or suggestions in the comments below. Happy coding, and see you in the next video!"
