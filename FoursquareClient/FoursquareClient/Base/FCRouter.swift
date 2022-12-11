//
//  FCRouter.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation
import UIKit

protocol FCRouter {
  func routeToDetails(
    from context: UIViewController,
    parameters: VenueDetailsResponse
  )
}
