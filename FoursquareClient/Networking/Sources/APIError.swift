//
//  APIError.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 11/28/22.
//

public struct APIError: Error {
  public let description: String
  
  public static var generic = APIError(description: "Generic Error")
  public static var network = APIError(description: "Network Error")
  public static var noData = APIError(description: "Data is nil")
  public static var decoding  = APIError(description: "Decoding failed")
  public static var noCastUrl = APIError(description: "URL Error")
}
