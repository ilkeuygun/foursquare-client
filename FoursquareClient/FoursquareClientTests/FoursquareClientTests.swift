//
//  FoursquareClientTests.swift
//  FoursquareClientTests
//
//  Created by Ilke Uygun on 12/11/22.
//

import XCTest
@testable import FoursquareClient

final class FoursquareClientTests: XCTestCase {
  
  var venueList = [FCVenue]()
  var venueDetailsResponse: VenueDetailsResponse?
  
  override func setUpWithError() throws {
    self.venueDetailsResponse = VenueDetailsResponse(
      fsq_id: "",
      name: "",
      location: Location(address: "", country: "", formatted_address: "", region: ""),
      geocodes: Geocode(main: Geolocation(latitude: 0, longitude: 0)),
      categories: [Category(name:"")]
    )
  }
  
  override func tearDownWithError() throws {
  }
  
  func testFetchVenues_HasItems() throws {
    // GIVEN
    let foursquareService = MockFCVenuesService()
    
    // WHEN
    foursquareService.getVenues(latitude: 40.0, longitude: 29.0) { venueList, errorCode in
      guard let venueList = venueList else { return }
      self.venueList = venueList
    }
    // THEN
    XCTAssertTrue(self.venueList.count > 0)
  }
  
  func testFetchVenueDetails_Success() throws {
    // GIVEN
    let foursquareMockService = MockFCVenuesService()
    
    // WHEN
    foursquareMockService.getVenueDetails(of: "blink182") { detailsResponse, errorCode in
      guard let detailsResponse = detailsResponse else { return }
      self.venueDetailsResponse = detailsResponse
    }
    // THEN
    XCTAssertTrue(!(self.venueDetailsResponse?.name.isEmpty ?? true))
    XCTAssertTrue(!(self.venueDetailsResponse?.categories.first?.name.isEmpty ?? true))
    XCTAssertTrue(!(self.venueDetailsResponse?.location.address.isEmpty ?? true))
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
