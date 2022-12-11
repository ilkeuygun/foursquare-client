//
//  Endpoint.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 11/28/22.
//

import Alamofire
import Foundation

public typealias HTTPMethod = Alamofire.HTTPMethod

public protocol Endpoint {
  var baseURL: String { get }
  var body: Parameters? { get }
  var method: HTTPMethod { get }
  var encoding: ParameterEncoding { get }
  var path: String { get }
  var header: [String: String]? { get }
  var urlQueryItems: [URLQueryItem]? { get }
}

public extension Endpoint {
  var body: Parameters? { nil }
  
  var encoding: ParameterEncoding {
    switch method {
    case .put, .post:
      return JSONEncoding.default
    default:
      return URLEncoding.default
    }
  }
  
  var urlQueryItems: [URLQueryItem]? { nil }
  var header: [String: String]? { nil }
  var method: HTTPMethod { .get }
  
  func asURL() throws -> URL {
    var urlComponents = URLComponents()
    urlComponents.host = baseURL
    urlComponents.scheme = "https"
    urlComponents.path = path
    urlComponents.queryItems = urlQueryItems
    return try urlComponents.asURL()
  }
}
