//
//  VenueDetailsQuery.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public struct VenueDetailsQuery: HTTPTask {
  
  public var baseURL: String = "api.foursquare.com"
  public var path: String = ""
  
  public init(path: String) {
    self.path = path
  }
}
