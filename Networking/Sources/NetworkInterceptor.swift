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
  
  public func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ){
    var urlRequest = urlRequest
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    completion(.success(urlRequest))
  }
}
