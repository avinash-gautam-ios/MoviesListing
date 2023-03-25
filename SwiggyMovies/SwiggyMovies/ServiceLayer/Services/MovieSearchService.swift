//
//  HomeService.swift
//  ToggleUsers
//
//  Created by Avinash Gautam on 23/03/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

enum MovieSearchServiceError: Error {
  case urlParsingFailed
  case domainModelParsingFailed
}

struct MovieSearchService {
  
  static func search(withText searchText: String, pageNumber: Int, completion: @escaping (MovieSearchResult?, Error?) -> ()) {
    
    let urlString = URLType.search(key: searchText, pageNumber: pageNumber)
    guard let requestUrl = URL(string: urlString.url) else {
      return completion(nil, MovieSearchServiceError.urlParsingFailed)
    }
    
    HttpManager.httpRequest(type: HTTPRequestType.get, url: requestUrl) { (result: MovieSearchResultApiModel?, error: Error?) in
      guard let movieResult = result else {
        return completion(nil, error)
      }
      
      guard let movieResultDomainModel = MovieSearchResult(fromApiModel: movieResult) else {
        return completion(nil, MovieSearchServiceError.domainModelParsingFailed)
      }
      completion(movieResultDomainModel, nil)
    }
  }
  
}
