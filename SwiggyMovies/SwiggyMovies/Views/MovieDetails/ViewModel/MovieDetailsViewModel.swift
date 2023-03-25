//
//  MovieDetailsViewModel.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
  
  private let movie: Movie
  
  let title: String
  let releasedYear: String
  let posterUrl: URL?
  
  init(movie: Movie) {
    
    self.movie = movie
    self.title = movie.title
    self.posterUrl = movie.posterUrl
    var yearText = ""
    if let year = movie.year {
      yearText = "Released Year - \(year)"
    }
    self.releasedYear = yearText
  }
  
}
