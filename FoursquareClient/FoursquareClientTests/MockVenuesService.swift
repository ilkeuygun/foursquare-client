//
//  MockVenuesService.swift
//  FoursquareClientTests
//
//  Created by Ilke Uygun on 12/13/22.
//

import Foundation
import FoursquareClient

public final class MockFCVenuesService: APIClient {
  static let shared = MockFCVenuesService()
}

extension MockFCVenuesService: VenuesService {
  public func getVenues(latitude: Double, longitude: Double, completion: @escaping FoursquareClient.GetVenuesCompletion) {
    let filePath = "GetPlacesResponse"
    MockFCVenuesService.loadJsonDataFromFile(filePath, completion: { data in
      if let json = data {
        do {
          let response = try JSONDecoder().decode(GetVenuesResponse.self, from: json)
          let venueList = response.results.map {
            FCVenue(
              id: $0.fsq_id,
              name: $0.name,
              link: $0.link
            )
          }
          completion(venueList, nil)
        }
        catch let error as NSError {
          completion(nil, error.description)
        }
      }
    })
  }
  
  private static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
    if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
      do {
        let data = try Data(contentsOf: fileUrl, options: [])
        completion(data as Data)
      } catch (let error) {
        print(error.localizedDescription)
        completion(nil)
      }
    }
  }
  
  public func getVenueDetails(of path: String, completion: @escaping FoursquareClient.VenueDetailsCompletion) {
    let filePath = "GetPlaceDetailResponse"
    MockFCVenuesService.loadJsonDataFromFile(filePath, completion: { data in
      if let json = data {
        do {
          let response = try JSONDecoder().decode(VenueDetailsResponse.self, from: json)
          completion(response, nil)
        }
        catch let error as NSError {
          completion(nil, error.description)
        }
      }
    })
  }
}
