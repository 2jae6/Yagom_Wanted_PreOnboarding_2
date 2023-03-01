//
//  ShowCollectionViewCell.swift
//  WantedPreOnBoarding_iOS
//
//  Created by WooKoo on 2023/02/21.
//

import UIKit

final class ShowCollectionViewCell: UICollectionViewCell {

  static let identifier = "ShowCollectionViewCell"

  let imageView = UIImageView()
  let loadButton = UIButton()
  let downloader = Downloader()

  override init(frame: CGRect) {
    super.init(frame: frame)
    loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    downloader.delegate = self
    self.backgroundColor = .red
    self.setupView()
  }

  required init?(coder: NSCoder) { fatalError() }
}

extension ShowCollectionViewCell {
  private func setupView() {
    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.loadButton)
    self.imageView.backgroundColor = .gray
    self.loadButton.backgroundColor = .blue
    self.setupLayout()
  }

  private func setupLayout() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    loadButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
      imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.heightAnchor.constraint(equalToConstant: 100)
    ])

    NSLayoutConstraint.activate([
      loadButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
      loadButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      loadButton.widthAnchor.constraint(equalToConstant: 50),
      loadButton.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
}

extension ShowCollectionViewCell: dataTaskDelegate {
  func sendData(data: Data) {
    if let image = UIImage(data: data) {
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    }
  }

  @objc
  func loadButtonTapped() {
    downloader.loadImageData()
  }
}
