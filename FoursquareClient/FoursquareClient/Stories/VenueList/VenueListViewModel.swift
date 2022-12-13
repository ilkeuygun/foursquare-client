//
//  VenueListViewModel.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import CoreLocation
import Foundation

protocol VenueListViewModelDelegate: AnyObject {
  func didFetchVenues()
  func didFetchVenueDetails(venueDetails: VenueDetailsResponse)
  func receivedError(with description: String)
}

public final class VenueListViewModel: NSObject {
  weak var delegate: VenueListViewModelDelegate?
  
  public var venueList: [FCVenue]?
  
  private var userCoordinate: CLLocationCoordinate2D?

  public func trackUserLocation() {
    let locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  public func venueViewModel(index: Int) -> VenueCellViewModel? {
    guard index < venueList?.count ?? 0, let venue = venueList?[index] else { return nil }
    return VenueCellViewModel(fsqId: venue.id, name: venue.name, link: venue.link, showsDarkBackground: index % 2 == 0)
  }
  
  public func fetchVenuesAround() {
    FCVenuesService.shared.getVenues(latitude: Double(userCoordinate?.latitude ?? 40.686), longitude: Double(userCoordinate?.longitude ?? 29.916)) { [weak self] venueList, errorCode in
      guard let self = self else { return }
      guard let venueList = venueList, !venueList.isEmpty else {
        self.delegate?.receivedError(with: "Venues cannot be fetched right now. Please try again later.")
        return
      }
      self.venueList = venueList
      self.delegate?.didFetchVenues()
    }
  }
  
  public func fetchDetails(of link: String) {
    FCVenuesService.shared.getVenueDetails(of: link) { [weak self] response, errorCode in
      guard let self = self else { return }
      guard let response = response else {
        self.delegate?.receivedError(with: "Venue details cannot be fetched right now. Please try again later.")
        return
      }
      self.delegate?.didFetchVenueDetails(venueDetails: response)
    }
  }
}

extension VenueListViewModel: CLLocationManagerDelegate {
  
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
      manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      manager.requestLocation()
    }
  }
  
  public func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    if let location = locations.first {
      userCoordinate = location.coordinate
      fetchVenuesAround()
    }
  }
  
  public func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    // TODO (Ilke): Handle failure to get a user’s location
    print(error.localizedDescription)
  }
}
