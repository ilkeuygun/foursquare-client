//
//  VenueListViewModel.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

protocol VenueListViewModelDelegate: AnyObject {
  func didFetchVenues()
  func receivedErrorWhileFetchingVenues()
}

public final class VenueListViewModel {
  weak var delegate: VenueListViewModelDelegate?
  
  public var venueList: [AnyObject]?
  
  public func fetchVenuesAround() {
  }
  
  public func venueViewModel(index: Int) -> VenueCellViewModel? {
    guard index < venueList?.count ?? 0, let venue = venueList?[index] else { return nil }
    return VenueCellViewModel(name: "foo")
  }
}
