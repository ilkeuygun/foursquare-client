//
//  VenueDetailsViewModel.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public final class VenueDetailsViewModel: NSObject {
  
  let venueDetails: VenueDetailsResponse
  
  init(venueDetails: VenueDetailsResponse) {
    self.venueDetails = venueDetails
  }
}
