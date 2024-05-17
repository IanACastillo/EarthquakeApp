//
//  EarthquakeViewModelTests.swift
//  EarthquakesTests
//
//  Created by Ian Castillo on 5/16/24.
//

import XCTest
import Combine
@testable import Earthquakes

class EarthquakeViewModelTests: XCTestCase {
    var viewModel: EarthquakeViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = EarthquakeViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchEarthquakesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch earthquakes successfully")
        
        viewModel.$earthquakes
            .dropFirst()
            .sink { earthquakes in
                XCTAssertFalse(earthquakes.isEmpty, "The earthquakes array should not be empty.")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchEarthquakes(startTime: "2023-01-01", endTime: "2024-01-01", minMagnitude: 7.0)
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchEarthquakesLoadingState() {
        let expectation = XCTestExpectation(description: "Loading state should be true during fetch")
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading {
                    XCTAssertTrue(self.viewModel.isLoading, "Loading state should be true.")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchEarthquakes(startTime: "2023-01-01", endTime: "2024-01-01", minMagnitude: 7.0)
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchEarthquakesErrorState() {
        let expectation = XCTestExpectation(description: "Error state should be set on fetch failure")
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                if error != nil {
                    XCTAssertNotNil(error, "Error should be set.")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Simulate a network error by providing invalid dates
        viewModel.fetchEarthquakes(startTime: "invalid-date", endTime: "invalid-date", minMagnitude: 7.0)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
