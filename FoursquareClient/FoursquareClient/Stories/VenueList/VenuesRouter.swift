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
  
  func route(
    to routeID: String,
    from context: UIViewController,
    parameters: Any?)
  {
    if routeID == Route.details.rawValue {
      guard let params = (parameters as? VenueDetailsResponse) else { return }
      let detailsViewModel = VenueDetailsViewModel(venueDetails: params)
      let detailsViewController = VenueDetailsViewController(viewModel: detailsViewModel)
      detailsViewController.viewModel = detailsViewModel
      context.navigationController?.pushViewController(detailsViewController, animated: true)
    } else if routeID == Route.filters.rawValue {
      guard let params = (parameters as? (String) -> Void) else { return }
      let filtersViewController = FiltersViewController(completionHandler: params)
      filtersViewController.modalPresentationStyle = .pageSheet
      context.navigationController?.present(filtersViewController, animated: true)
    }
  }
}
