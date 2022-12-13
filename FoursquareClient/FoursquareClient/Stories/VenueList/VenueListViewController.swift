//
//  VenueListViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import UIKit

public final class VenueListViewController: UIViewController {
  
  enum Route: String {
    case details
  }
  
  lazy var venuesCollectionView: UICollectionView = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 16)
    let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.isHidden = true
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  lazy var loadingIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.color = .black
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    return activityIndicator
  }()
  
  private let viewModel: VenueListViewModel
  private let router: VenuesRouter
  
  public init(viewModel: VenueListViewModel, router: VenuesRouter) {
    self.viewModel = viewModel
    self.router = router
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = VenueListViewModel()
    self.router = VenuesRouter(viewModel: viewModel)
    super.init(coder: coder)
  }
  
  public override func loadView() {
    let view = UIView()
    self.view = view
    self.view.backgroundColor = .white
    viewModel.delegate = self
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    viewModel.fetchVenuesAround()
  }
  
  private func setupSubviews() {
    self.navigationItem.title = "Venues Around"
    venuesCollectionView.register(VenueCollectionViewCell.self, forCellWithReuseIdentifier: "VenueCollectionViewCell")    
    view.addSubview(loadingIndicator)
    view.addSubview(venuesCollectionView)
    NSLayoutConstraint.activate([
      loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    NSLayoutConstraint.activate([
      venuesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
      venuesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      venuesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      venuesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

// MARK: - VenueListViewModelDelegate
extension VenueListViewController: VenueListViewModelDelegate {
  
  func didFetchVenues() {
    loadingIndicator.stopAnimating()
    loadingIndicator.isHidden = true
    venuesCollectionView.isHidden = false
    venuesCollectionView.reloadData()
  }
  
  func receivedError(with description: String) {
    // TODO (Ilke): Add localization support
    let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
  func didFetchVenueDetails(venueDetails: VenueDetailsResponse) {
    router.route(to: Route.details.rawValue,
                 from: self,
                 parameters: venueDetails)
  }
}

// MARK: - UICollectionViewDataSource
extension VenueListViewController: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView, numberOfItemsInSection section: Int
  )
    -> Int
  {
    return viewModel.venueList?.count ?? 0
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    guard indexPath.item < viewModel.venueList?.count ?? 0 else { return UICollectionViewCell() }
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "VenueCollectionViewCell", for: indexPath)

    if let venueCell = cell as? VenueCollectionViewCell {
      venueCell.viewModel = viewModel.venueViewModel(index: indexPath.item)
    }

    return cell
  }
}

extension VenueListViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let venueCell = collectionView.cellForItem(at: indexPath) as? VenueCollectionViewCell,
          let link = venueCell.viewModel?.link else { return }
    viewModel.fetchDetails(of: link)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VenueListViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = (collectionView.frame.size.width - 32)
    return CGSize(width: width, height: 48)
  }
}

