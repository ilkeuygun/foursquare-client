//
//  VenueDetailScreenUITest.swift
//  FoursquareClientUITests
//
//  Created by Ilke Uygun on 12/13/22.
//

import XCTest

final class VenueDetailScreenUITest: XCTestCase {
  
  private let app = XCUIApplication()
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  override func tearDownWithError() throws {
  }
  
  private func navigateToDetailsScreen() {
    app.launch()
    let navigationTitle = app.staticTexts["Venues Around"].firstMatch
    _ = navigationTitle.waitForExistence(timeout: TimeInterval(10))
    let venuesCollection = app.collectionViews.firstMatch
    _ = venuesCollection.waitForExistence(timeout: 10)
    let firstCell = venuesCollection.cells.element(boundBy: 0)
    firstCell.tap()
  }
  
  func testDetailScreenLoad() throws {
    navigateToDetailsScreen()
    let mapView = app.maps.firstMatch
    XCTAssert(mapView.waitForExistence(timeout: TimeInterval(10)))
  }
  
  func testDetailScreenCategoryVisible() throws {
    navigateToDetailsScreen()
    let descriptionLabel = app.staticTexts["Category:"].firstMatch
    XCTAssert(descriptionLabel.waitForExistence(timeout: TimeInterval(10)))
  }
  
  func testDetailScreenAddressVisible() throws {
    navigateToDetailsScreen()
    let addressLabel = app.staticTexts["Address:"].firstMatch
    XCTAssert(addressLabel.waitForExistence(timeout: TimeInterval(10)))
  }
}
