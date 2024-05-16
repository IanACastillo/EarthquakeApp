//
//  EarthquakeViewModelTests.swift
//  EarthquakesTests
//
//  Created by Ian Castillo on 5/16/24.
//

import XCTest
@testable import Earthquakes

class EarthquakeViewModelTests: XCTestCase {
    var viewModel: EarthquakeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = EarthquakeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchEarthquakes() {
        let expectation = XCTestExpectation(description: "Fetch earthquakes")
        
        viewModel.$earthquakes
            .dropFirst()
            .sink { earthquakes in
                XCTAssertFalse(earthquakes.isEmpty)
                expectation.fulfill()
            }
            .store(in: &viewModel.cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
