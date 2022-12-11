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
  func receivedErrorWhileFetchingVenues()
}

public final class VenueListViewModel: NSObject {
  weak var delegate: VenueListViewModelDelegate?
  
  public var venueList: [FCVenue]?
  
  // TODO (Ilke): Make these a single observable coord.
  private var userLatitude: Double?
  private var userLongitude: Double?
  
  override init() {
    super.init()
    let locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.requestLocation()
  }
  
  public func venueViewModel(index: Int) -> VenueCellViewModel? {
    guard index < venueList?.count ?? 0, let venue = venueList?[index] else { return nil }
    return VenueCellViewModel(name: venue.name)
  }
  
  public func fetchVenuesAround() {
    FCVenuesService.shared.getVenues(latitude: userLatitude ?? 40.686, longitude: userLongitude ?? 29.916) { [weak self] venueList, errorCode in
      guard let self = self else { return }
      guard let venueList = venueList, !venueList.isEmpty else {
        self.delegate?.receivedErrorWhileFetchingVenues()
        return
      }
      self.venueList = venueList
      self.delegate?.didFetchVenues()
    }
  }
}

extension VenueListViewModel: CLLocationManagerDelegate {
  
  public func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    if let location = locations.first {
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      userLatitude = latitude.binade
      userLongitude = longitude.binade
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
