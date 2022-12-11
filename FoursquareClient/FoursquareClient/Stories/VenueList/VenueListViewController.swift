//
//  VenueListViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import UIKit

public final class VenueListViewController: UIViewController {
  
  @IBOutlet weak var venuesCollectionView: UICollectionView!
  
  private let viewModel: VenueListViewModel
  
  public init(viewModel: VenueListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = VenueListViewModel()
    super.init(coder: coder)
    viewModel.delegate = self
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    venuesCollectionView.dataSource = self
    venuesCollectionView.delegate = self
    venuesCollectionView.register(UINib(nibName: "VenueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VenueCollectionViewCell")
    viewModel.fetchVenuesAround()
  }
}

// MARK: - VenueListViewModelDelegate
extension VenueListViewController: VenueListViewModelDelegate {
  
  func didFetchVenues() {
    venuesCollectionView.reloadData()
  }
  
  func receivedErrorWhileFetchingVenues() {
    // TODO (Ilke): Add localization support
    let alert = UIAlertController(title: "Error", message: "Venues cannot be fetched right now. Try again later", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true)
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

extension VenueListViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = (collectionView.frame.size.width - 32)
    return CGSize(width: width, height: 120)
  }
}

