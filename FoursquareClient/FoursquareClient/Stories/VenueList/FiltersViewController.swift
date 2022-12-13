//
//  FiltersViewController.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 12/13/22.
//

import UIKit

public final class FiltersViewController: UIViewController {
  
  lazy var applyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Done", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .blue
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didTapApplyButton), for: .touchUpInside)
    return button
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Filter Options"
    label.font = .boldSystemFont(ofSize: 17)
    label.textColor = .black
    label.backgroundColor = .white
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var radiusTextField: UITextField = {
    let textField = UITextField(frame: .zero)
    textField.placeholder = "Radius (in meters)"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .lightGray
    textField.textColor = .black
    textField.keyboardType = .numberPad
    textField.delegate = self
    return textField
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.backgroundColor = .clear
    stackView.axis = .vertical
    stackView.alignment = .top
    stackView.spacing = CGFloat(8)
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let completionHandler: ((String) -> Void)?
  
  public init(completionHandler: @escaping (String) -> Void) {
    self.completionHandler = completionHandler
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.completionHandler = nil
    super.init(coder: coder)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
  }
  
  private func setupSubviews() {
    self.view.backgroundColor = .white
    
    view.addSubview(applyButton)
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      applyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      applyButton.heightAnchor.constraint(equalToConstant: 32),
      applyButton.widthAnchor.constraint(equalToConstant: 64),
      applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
    ])
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 16),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
    ])
    
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(radiusTextField)
    
    NSLayoutConstraint.activate([
      titleLabel.heightAnchor.constraint(equalToConstant: 24),
      titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      radiusTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      radiusTextField.heightAnchor.constraint(equalToConstant: 48),
      radiusTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
    ])
  }
  
  @objc private func didTapApplyButton() {
    self.dismiss(animated: true) { [weak self] in
      guard let self = self else { return }
      guard let text = self.radiusTextField.text else { return }
      self.completionHandler?(text)
    }
  }
}

extension FiltersViewController: UITextFieldDelegate {
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
    let compSepByCharInSet = string.components(separatedBy: aSet)
    let numberFiltered = compSepByCharInSet.joined(separator: "")
    return string == numberFiltered
  }
}
