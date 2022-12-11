//
//  VenuesQuery.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public struct VenuesQuery: HTTPTask {
  
  public var baseURL: String = "api.foursquare.com"
  public var path: String = "/v3/places/search"
  public var urlQueryItems: [URLQueryItem]?
  
  public init(lat: Double, lon: Double) {
    urlQueryItems = [
      URLQueryItem(name: "ll", value: "\(lat),\(lon)")
    ]
  }
}
