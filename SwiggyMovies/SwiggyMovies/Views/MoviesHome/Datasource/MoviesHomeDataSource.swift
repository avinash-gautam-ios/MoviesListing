//
//  MoviesHomeDataSourceData.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

struct MoviesHomeDataSource {
  let movies: [Movie]
  init(result: MovieSearchResult?) {
    guard let movies = result?.movies else {
      self.movies = []
      return
    }
    self.movies = movies
  }
  
}
