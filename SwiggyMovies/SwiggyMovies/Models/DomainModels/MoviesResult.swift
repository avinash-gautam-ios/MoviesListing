//
//  MovieSearchResult.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

struct MovieSearchResult {
  
  let movies: [Movie]
  init?(fromApiModel apiModel: MovieSearchResultApiModel) {
    guard let movies = apiModel.movies else {
      return nil
    }
    
    self.movies = movies.compactMap({ Movie(fromApiModel: $0) })
  }
  
  init(movies: [Movie]) {
    self.movies = movies
  }
}
