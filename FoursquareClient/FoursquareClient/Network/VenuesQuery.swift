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
  
  public init(lat: Double, lon: Double, radius: Int?) {
    urlQueryItems = [
      URLQueryItem(name: "ll", value: "\(lat),\(lon)")
    ]
    if let radius = radius, radius > 0 && radius < 100000 {
      urlQueryItems?.append(URLQueryItem(name: "radius", value: "\(radius)"))
    }
  }
}
