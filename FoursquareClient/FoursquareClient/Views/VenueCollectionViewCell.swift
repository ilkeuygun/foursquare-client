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
  
  @IBOutlet weak var nameLabel: UILabel!
  
  public var viewModel: VenueCellViewModel? {
    didSet {
      guard let viewModel = viewModel else {
        return
      }
      backgroundColor = .clear
      contentView.backgroundColor = viewModel.showsDarkBackground ? .lightGray : .white
      contentView.layer.cornerRadius = CGFloat(8)
      
      nameLabel.textColor = .black
      nameLabel.backgroundColor = .clear
      nameLabel.font = .systemFont(ofSize: CGFloat(16), weight: .semibold)
      nameLabel.text = viewModel.name
    }
  }
  
  public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    setNeedsLayout()
    layoutIfNeeded()
    let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
    var frame = layoutAttributes.frame
    frame.size.height = ceil(size.height)
    layoutAttributes.frame = frame
    return layoutAttributes
  }
}
