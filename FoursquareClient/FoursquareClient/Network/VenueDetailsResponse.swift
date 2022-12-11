//
//  VenueDetailsResponse.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public struct VenueDetailsResponse: Decodable {
  
  public let fsq_id: String
  public let name: String
  public let location: Location
  public let geocodes: Geocode
}

public struct Location: Decodable {
  public let address: String
  public let country: String
  public let formatted_address: String
  public let region: String
}

public struct Geocode: Decodable {
  public let main: Geolocation
}

public struct Geolocation: Decodable {
  public let latitude: Double
  public let longitude: Double
}
