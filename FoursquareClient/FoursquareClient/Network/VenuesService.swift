//
//  VenuesService.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public typealias GetVenuesCompletion = ([FCVenue]?, String?) -> ()

public protocol VenuesService: AnyObject {
  
  func getVenues(latitude: Double, longitude: Double, completion: @escaping GetVenuesCompletion)
}

public final class FCVenuesService: APIClient {
  static let shared = FCVenuesService()
}

extension FCVenuesService: VenuesService {
  
  public func getVenues(latitude: Double, longitude: Double, completion: @escaping GetVenuesCompletion) {
    let query = VenuesQuery(lat: latitude, lon: longitude)
    
    networkManager.fetch(query, type: GetVenuesResponse.self) { result in
      switch result {
      case .success(let response):
        let venueList = response.results.map {
          FCVenue(
            name: $0.name
          )
        }
        completion(venueList, nil)
      case .failure(let error):
        completion(nil, error.description)
      }
    }
  }
}
