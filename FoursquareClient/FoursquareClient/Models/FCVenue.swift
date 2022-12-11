//
//  FCVenue.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation

public class FCVenue: NSObject {
  
  public let id: String
  public let name: String
  public let link: String
  
  public init(id: String, name: String, link: String) {
    self.id = id
    self.name = name
    self.link = link
  }
}
