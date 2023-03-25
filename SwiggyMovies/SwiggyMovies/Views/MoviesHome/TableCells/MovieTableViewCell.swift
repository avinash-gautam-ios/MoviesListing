//
//  MovieTableViewCell.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseYearLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  class var identifier: String{
    return String(describing: self)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.posterImageView.image = nil
  }
  
  func populateData(fromDataModel dataModel: Movie) {
    self.titleLabel.text = dataModel.title
    if let year = dataModel.year {
      self.releaseYearLabel.text = "Released Year - \(year)"
    } else {
      self.releaseYearLabel.isHidden = true
    }
    
    guard let url = dataModel.posterUrl else {
      return
    }
    
    MovieImageCachingUtility.instance.loadImage(fromUrl: url, completion: { image in
      DispatchQueue.main.async {
        self.posterImageView.image = image
      }
    })
  }
  
}
