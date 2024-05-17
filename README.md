# Earthquake Monitoring App

This Earthquake Monitoring app provides a list of recent significant earthquakes and displays their locations on a map. The app is built using SwiftUI and follows the MVVM architecture.

## Requirements
- Xcode 15.4 or later
- iOS 14.0 or later

## Features

- Fetches and displays a list of recent earthquakes with their magnitudes, locations, and times.
- Earthquakes with a magnitude of 7.5 or higher are highlighted in red.
- Tapping on an earthquake entry shows its location on a map.
- The app is built using modern iOS development patterns and includes unit tests.

## Technologies Used

- Swift
- SwiftUI
- Combine
- MapKit
- MVVM Architecture

## Installation

To run the project, you need to have Xcode installed on your Mac. Follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/EarthquakeMonitoringApp.git
    ```

2. Open the project in Xcode:
    ```sh
    cd EarthquakeMonitoringApp
    open EarthquakeMonitoringApp.xcodeproj
    ```

3. Build and run the project in the simulator or on a physical device.

## Usage

Once the app is running, it will automatically fetch and display a list of recent significant earthquakes. You can scroll through the list to see the details of each earthquake. Tapping on an earthquake entry will show its location on a map.

## Code Structure

- **Model:** Contains the `Earthquake` and `EarthquakeResponse` structs for parsing JSON data.
- **ViewModel:** Contains the `EarthquakeViewModel` class, which handles data fetching and business logic.
- **Views:** Contains the SwiftUI views (`ContentView` and `EarthquakeDetailView`) for displaying the UI.
- **Unit Tests:** Contains unit tests for the `EarthquakeViewModel`.

## App Icon

The app icon is a sleek, modern design featuring a stylized, abstract representation of seismic waves over a red background. The icon is designed to be simple, clean, and easily recognizable.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- The earthquake data is provided by the [USGS Earthquake API](https://earthquake.usgs.gov/fdsnws/event/1/).
- The app icon was generated with the help of DALL-E.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any improvements or bug fixes.

## Contact

For any questions or feedback, please contact ian.abraham.castillo@gmail.com
