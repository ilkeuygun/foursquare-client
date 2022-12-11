//
//  APIClient.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation
import Networking

@objc public class APIClient: NSObject {
  
  public let networkManager: NetworkManager
  
  public init(networkManager: NetworkManager = NetworkManager()) {
    self.networkManager = networkManager
  }
}
