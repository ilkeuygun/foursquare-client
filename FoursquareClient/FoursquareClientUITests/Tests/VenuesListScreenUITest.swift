//
//  VenuesListScreenUITest.swift
//  FoursquareClientUITests
//
//  Created by Ilke Uygun on 12/13/22.
//

import XCTest

final class VenuesListScreenUITest: XCTestCase {
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  override func tearDownWithError() throws {
  }
  
  private func dismissLocationPermissionAlert() {
    let app = XCUIApplication()
    let button = app.alerts.firstMatch.buttons["Allow While Using App"]
    button.waitForExistence(timeout: 10)
    button.tap()
  }
  
  func testListScreenLoad() throws {
    let app = XCUIApplication()
    app.launch()
    let navigationTitle = app.staticTexts["Venues Around"].firstMatch
    XCTAssert(navigationTitle.waitForExistence(timeout: TimeInterval(10)))
  }
  
  func testListScreenLoadingIndicatorVisible() throws {
    let app = XCUIApplication()
    app.launch()
    let loadingIndicator = app.activityIndicators.firstMatch
    XCTAssertTrue(loadingIndicator.isEnabled)
  }
  
  func testListScreenVenuesCollectionVisible() throws {
    let app = XCUIApplication()
    app.launch()
    let venuesCollection = app.collectionViews.firstMatch
    XCTAssert(venuesCollection.waitForExistence(timeout: 10))
  }
}
