//
//  VenuesRouter.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation
import UIKit

public final class VenuesRouter: FCRouter {
  unowned var viewModel: VenueListViewModel
  
  init(viewModel: VenueListViewModel) {
    self.viewModel = viewModel
  }
  
  func routeToDetails(
    from context: UIViewController,
    parameters: VenueDetailsResponse)
  {
    let detailsViewModel = VenueDetailsViewModel(venueDetails: parameters)
    let detailsViewController = VenueDetailsViewController(viewModel: detailsViewModel)
    context.navigationController?.pushViewController(detailsViewController, animated: true)
  }
}
