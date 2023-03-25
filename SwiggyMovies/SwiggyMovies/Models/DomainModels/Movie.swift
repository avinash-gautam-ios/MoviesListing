//
//  Movie.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

struct Movie {
  
  let id: String
  let title: String
  let year: String?
  let type: String?
  let posterUrl: URL?
  
  init?(fromApiModel apiModel: MovieApiModel) {
    guard let id = apiModel.imdbId,
      let title = apiModel.title else {
        return nil
    }
    
    self.id = id
    self.title = title
    self.year = apiModel.year
    self.type = apiModel.type
    self.posterUrl = URL(string: apiModel.posterUrl ?? "")
  }
}
