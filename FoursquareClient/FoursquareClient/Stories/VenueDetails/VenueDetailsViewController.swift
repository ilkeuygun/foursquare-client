//
//  VenueDetailsViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import UIKit

public final class VenueDetailsViewController: UIViewController {
  
  @IBOutlet weak var contentView: UIView!
  
  var viewModel: VenueDetailsViewModel?
  
  public init(viewModel: VenueDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)    
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = viewModel?.venueDetails.name
  }
}
