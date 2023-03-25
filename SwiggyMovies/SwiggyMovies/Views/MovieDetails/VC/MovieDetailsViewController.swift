//
//  MovieDetailsViewController.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  
  @IBOutlet weak var releaseYearLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  let viewModel: MovieDetailsViewModel
  
  init(dataModel: Movie) {
    self.viewModel = MovieDetailsViewModel(movie: dataModel)
    super.init(nibName: String.stringFromClass(MovieDetailsViewController.self), bundle: Bundle(for: MovieDetailsViewController.self))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
  }
  
  deinit {
    print("deinit")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  func configure() {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.title = self.viewModel.title
    self.releaseYearLabel.text = self.viewModel.releasedYear
    self.titleLabel.text = self.viewModel.title
    if let url = self.viewModel.posterUrl {
      MovieImageCachingUtility.instance.loadImage(fromUrl: url, completion: { image in
        DispatchQueue.main.async {
          self.posterImageView.image = image
        }
      })
    }
  }
  
}
