//
//  VenueDetailsViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import UIKit

public final class VenueDetailsViewController: UIViewController {
  
  @IBOutlet weak var contentView: UIView!
  
  private let viewModel: VenueDetailsViewModel
  
  public init(viewModel: VenueDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = VenueDetailsViewModel(venueDetails: VenueDetailsResponse(fsq_id: "", name: "", location: Location(address: "", country: "", formatted_address: "", region: "")))
    super.init(coder: coder)    
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = viewModel.venueDetails.name
  }
}
