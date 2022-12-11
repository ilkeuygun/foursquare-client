//
//  APIResponse.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 11/28/22.
//

public struct ArrayResponse<T>: Decodable where T: Decodable {
  
  public typealias Data = [T]
  
  public let data: Data
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    data = try container.decode([T].self)
  }
}
