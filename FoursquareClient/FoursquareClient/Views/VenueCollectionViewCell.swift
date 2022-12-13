//
//  VenueCollectionViewCell.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/11/22.
//

import Foundation
import UIKit

public struct VenueCellViewModel {
  let fsqId: String
  let name: String
  let link: String
  let showsDarkBackground: Bool
  
  public init(fsqId: String, name: String, link: String, showsDarkBackground: Bool) {
    self.fsqId = fsqId
    self.name = name
    self.link = link
    self.showsDarkBackground = showsDarkBackground
  }
}

public final class VenueCollectionViewCell: UICollectionViewCell {
  
  lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.backgroundColor = .clear
    label.font = .systemFont(ofSize: CGFloat(16), weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public var viewModel: VenueCellViewModel? {
    didSet {
      guard let viewModel = viewModel else {
        return
      }
      backgroundColor = .clear
      contentView.backgroundColor = viewModel.showsDarkBackground ? .lightGray : .white
      contentView.layer.cornerRadius = CGFloat(8)
      nameLabel.text = viewModel.name
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupSubviews() {
    contentView.addSubview(nameLabel)
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      nameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    ])
  }
}
