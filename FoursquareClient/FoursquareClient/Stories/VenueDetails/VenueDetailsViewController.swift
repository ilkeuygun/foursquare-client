//
//  VenueDetailsViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import MapKit
import UIKit

public final class VenueDetailsViewController: UIViewController {
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var mapView: MKMapView!
  
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
    prepareMap()
  }
  
  private func prepareMap() {
    mapView.isUserInteractionEnabled = false
    guard let venueLat = viewModel?.venueDetails.geocodes.main.latitude,
          let venueLon = viewModel?.venueDetails.geocodes.main.longitude else { return }
    let venueCoordinate = CLLocationCoordinate2D(latitude: venueLat, longitude: venueLon)
    let viewRegion = MKCoordinateRegion(center: venueCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
    let adjustedRegion = self.mapView.regionThatFits(viewRegion)
    self.mapView.setRegion(adjustedRegion, animated: true)
    let venueAnnotation = FCVenueAnnotation(coordinate: venueCoordinate)
    self.mapView.addAnnotation(venueAnnotation)
  }
}
