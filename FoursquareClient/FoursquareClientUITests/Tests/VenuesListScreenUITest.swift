//
//  VenuesListScreenUITest.swift
//  FoursquareClientUITests
//
//  Created by Ilke Uygun on 12/13/22.
//

import XCTest

final class VenuesListScreenUITest: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  override func tearDownWithError() throws {
  }
  
  private func startApp() {
    app.launch()
    dismissLocationPermissionAlertIfVisible()
  }
  
  private func dismissLocationPermissionAlertIfVisible() {
    let button = app.alerts.firstMatch.buttons["Allow While Using App"]
    _ = button.waitForExistence(timeout: TimeInterval(3))
    if button.exists && button.isHittable {
      button.tap()
    }
  }
  
  func testListScreenLoad() throws {
    startApp()
    let navigationTitle = app.staticTexts["Venues Around"].firstMatch
    XCTAssert(navigationTitle.waitForExistence(timeout: TimeInterval(10)))
  }
  
  func testListScreenLoadingIndicatorVisible() throws {
    startApp()
    let loadingIndicator = app.activityIndicators.firstMatch
    XCTAssertTrue(loadingIndicator.isEnabled)
  }
  
  func testListScreenVenuesCollectionVisible() throws {
    startApp()
    let venuesCollection = app.collectionViews.firstMatch
    XCTAssert(venuesCollection.waitForExistence(timeout: 10))
  }
}
