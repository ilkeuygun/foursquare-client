//
//  NetworkInterceptor.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 11/28/22.
//

import Alamofire
import Foundation

public final class NetworkInterceptor: RequestInterceptor {
  public init () {}
  
  private let foursquare_api_key = "fsq3BnHqvz7KenGQ8mjrTmKBgLiTDDF0OKe+ne0FOQ+4f4c="
  
  public func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ){
    var urlRequest = urlRequest
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue(foursquare_api_key, forHTTPHeaderField: "Authorization")
    completion(.success(urlRequest))
  }
}
