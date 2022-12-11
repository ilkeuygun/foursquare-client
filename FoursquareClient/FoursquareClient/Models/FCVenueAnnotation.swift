//
//  FCVenueAnnotation.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation
import MapKit

public final class FCVenueAnnotation: NSObject, MKAnnotation {
  
  public let coordinate: CLLocationCoordinate2D
  
  public init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
    super.init()
  }
}
