//
//  ViewController.swift
//  WantedPreOnBoarding_iOS
//
//  Created by WooKoo on 2023/02/21.
//

import UIKit

final class ViewController: UIViewController {
  private let imageCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.backgroundColor = .brown

    collectionView.register(
      ShowCollectionViewCell.self,
      forCellWithReuseIdentifier: ShowCollectionViewCell.identifier
    )

    return collectionView
  }()

  private let loadAllImageButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .blue

    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    imageCollectionView.delegate = self
    imageCollectionView.dataSource = self

    loadAllImageButton.addTarget(self, action: #selector(allButtonTapped), for: .touchUpInside)

    setupView()
  }
}

extension ViewController {
  private func setupView() {
    view.addSubview(imageCollectionView)
    view.addSubview(loadAllImageButton)

    setupLayout()
  }

  private func setupLayout() {
    imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
    loadAllImageButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      imageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      imageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      imageCollectionView.bottomAnchor.constraint(equalTo: loadAllImageButton.topAnchor, constant: -32)
    ])

    NSLayoutConstraint.activate([
      loadAllImageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      loadAllImageButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      loadAllImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
      loadAllImageButton.heightAnchor.constraint(equalToConstant: 44)
    ])

  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ShowCollectionViewCell.identifier,
      for: indexPath
    ) as? ShowCollectionViewCell else { return UICollectionViewCell() }

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemWidth: CGFloat = UIScreen.main.bounds.width
    let itemHeight: CGFloat = 120
    return CGSize(width: itemWidth, height: itemHeight)
  }
}

extension ViewController {
  @objc
  private func allButtonTapped() {
    _ = imageCollectionView.visibleCells.map { ($0 as? ShowCollectionViewCell)?.loadButtonTapped() }
  }
}
