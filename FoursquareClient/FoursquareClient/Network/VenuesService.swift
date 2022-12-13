//
//  VenuesService.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public typealias GetVenuesCompletion = ([FCVenue]?, String?) -> ()
public typealias VenueDetailsCompletion = (VenueDetailsResponse?, String?) -> ()

public protocol VenuesService: AnyObject {
  
  func getVenues(latitude: Double, longitude: Double, radius: Int?, completion: @escaping GetVenuesCompletion)
  func getVenueDetails(of path: String, completion: @escaping VenueDetailsCompletion)
}

public final class FCVenuesService: APIClient {
  static let shared = FCVenuesService()
}

extension FCVenuesService: VenuesService {
  
  public func getVenues(latitude: Double, longitude: Double, radius: Int?, completion: @escaping GetVenuesCompletion) {
    let query = VenuesQuery(lat: latitude, lon: longitude, radius: radius)
    
    networkManager.fetch(query, type: GetVenuesResponse.self) { result in
      switch result {
      case .success(let response):
        let venueList = response.results.map {
          FCVenue(
            id: $0.fsq_id,
            name: $0.name,
            link: $0.link
          )
        }
        completion(venueList, nil)
      case .failure(let error):
        completion(nil, error.description)
      }
    }
  }
  
  public func getVenueDetails(of path: String, completion: @escaping VenueDetailsCompletion) {
    let query = VenueDetailsQuery(path: path)
    
    networkManager.fetch(query, type: VenueDetailsResponse.self) { result in
      switch result {
      case .success(let response):
        completion(response, nil)
      case .failure(let error):
        completion(nil, error.description)
      }
    }
  }
}
