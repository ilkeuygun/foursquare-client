//
//  GetVenuesResponse.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

public struct GetVenuesResponse: Decodable {
  
  public let results: [Venue]
}

public struct Venue: Codable {
  public let fsq_id: String
  public let name: String
  public let link: String
}
