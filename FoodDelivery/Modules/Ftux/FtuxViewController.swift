//
//  FtuxViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 02/01/23.
//

import UIKit

class FtuxViewController: UIViewController {
  @IBOutlet var nextButton: UIButton!
  @IBOutlet var pageControl: UIPageControl!
  @IBOutlet var collectionView: UICollectionView!

  let viewModel = FtuxViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewModel.loadFtuxes()
    observerCurrentIndex()
    observeError()

    // observeError()
  }

  // MARK: - Helpers

  func setup() {
    nextButton.layer.cornerRadius = 28
    nextButton.layer.masksToBounds = true

    collectionView.dataSource = self
    collectionView.delegate = self
  }

  func updatePage(_ page: Int) {
    pageControl.currentPage = page
    nextButton.setTitle(viewModel.buttonTitleAtIndex(page), for: .normal)
  }

  func gotoPage(_ page: Int) {
    collectionView.scrollToItem(at: IndexPath(item: page, section: 0),
                                at: .centeredHorizontally, animated: true)
    updatePage(page)
  }

  func observeError() {
    viewModel.error.bind { [weak self] error in
      let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      self?.present(alert, animated: true, completion: nil)
    }
  }

  func observerCurrentIndex() {
    viewModel.currentIndex.bind { [weak self] index in
      guard let `self` = self else { return }

      switch index {
      case -1:
        break
      case self.viewModel.numberOfItems:
        self.showLoginLandingViewController()
      default:
        if index == 0 {
          self.collectionView.reloadData()
        }

        self.gotoPage(index)
      }
    }
  }

  // MARK: - Actions

  @IBAction func nextButtonTapped(_ sender: Any) {
    let toPage = min(viewModel.numberOfItems, pageControl.currentPage + 1)
//    if toPage != pageControl.currentPage {
//      gotoPage(toPage)
//    }
    viewModel.currentIndex.value = toPage
  }
}

// MARK: - UICollectionViewDataSource

extension FtuxViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewIdentifier", for: indexPath) as! CollectionViewCell

    cell.imageView.image = viewModel.imageAtIndex(indexPath.item)
    cell.titleLabel.text = viewModel.titleAtIndex(indexPath.item)
    cell.subtitleLabel.text = viewModel.subtitleAtIndex(indexPath.item)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItems
  }
}

// MARK: - UICollectionViewDelegate

extension FtuxViewController: UICollectionViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x / scrollView.frame.width
    pageControl.currentPage = Int(page)
    updatePage(Int(page))
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FtuxViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
