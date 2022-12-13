//
//  VenueDetailsViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import MapKit
import UIKit

public final class VenueDetailsViewController: UIViewController {
  
  lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.isUserInteractionEnabled = false
    mapView.translatesAutoresizingMaskIntoConstraints = false
    return mapView
  }()
  
  lazy var categoryTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Category:"
    label.font = .boldSystemFont(ofSize: 17)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var categoryValueLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var addressTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Address:"
    label.font = .boldSystemFont(ofSize: 17)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var addressValueLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var viewModel: VenueDetailsViewModel?
  
  public init(viewModel: VenueDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)    
  }
  
  public override func loadView() {
    let view = UIView()
    self.view = view
    self.view.backgroundColor = .white
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = viewModel?.venueDetails.name
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    setupSubviews()
  }
  
  private func setupSubviews() {
    view.addSubview(contentView)
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    contentView.addSubview(mapView)
    contentView.addSubview(categoryTitleLabel)
    contentView.addSubview(categoryValueLabel)
    contentView.addSubview(addressTitleLabel)
    contentView.addSubview(addressValueLabel)
    
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      mapView.heightAnchor.constraint(equalToConstant: 150)
    ])
    NSLayoutConstraint.activate([
      categoryTitleLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
      categoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      categoryTitleLabel.widthAnchor.constraint(equalToConstant: 100),
      categoryTitleLabel.heightAnchor.constraint(equalToConstant: 24)
    ])
    NSLayoutConstraint.activate([
      categoryValueLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor, constant: 8),
      categoryValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      categoryValueLabel.centerYAnchor.constraint(equalTo: categoryTitleLabel.centerYAnchor),
      categoryValueLabel.heightAnchor.constraint(greaterThanOrEqualTo: categoryTitleLabel.heightAnchor)
    ])
    NSLayoutConstraint.activate([
      addressTitleLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 16),
      addressTitleLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor),
      addressTitleLabel.widthAnchor.constraint(equalToConstant: 100),
      addressTitleLabel.heightAnchor.constraint(equalToConstant: 24)
    ])
    NSLayoutConstraint.activate([
      addressValueLabel.leadingAnchor.constraint(equalTo: addressTitleLabel.trailingAnchor, constant: 8),
      addressValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      addressValueLabel.centerYAnchor.constraint(equalTo: addressTitleLabel.centerYAnchor),
      addressValueLabel.heightAnchor.constraint(greaterThanOrEqualTo: addressTitleLabel.heightAnchor)
    ])
    
    guard let venueLat = viewModel?.venueDetails.geocodes.main.latitude,
          let venueLon = viewModel?.venueDetails.geocodes.main.longitude else { return }
    let venueCoordinate = CLLocationCoordinate2D(latitude: venueLat, longitude: venueLon)
    let viewRegion = MKCoordinateRegion(center: venueCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
    let adjustedRegion = self.mapView.regionThatFits(viewRegion)
    self.mapView.setRegion(adjustedRegion, animated: true)
    let venueAnnotation = FCVenueAnnotation(coordinate: venueCoordinate)
    self.mapView.addAnnotation(venueAnnotation)
    categoryValueLabel.text = viewModel?.venueDetails.categories.first?.name
    addressValueLabel.text = viewModel?.venueDetails.location.formatted_address
  }
}
