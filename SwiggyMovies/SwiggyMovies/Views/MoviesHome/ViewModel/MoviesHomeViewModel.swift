//
//  MoviesHomeViewModel.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

protocol MoviesHomeViewModelDelegate: class {
  func reloadTableView()
  func dismissKeyBoard()
  func loaderDidChange(withStatus status: Bool)
}

class MoviesHomeViewModel {
  
  private var datasource = MoviesHomeDataSource(result: nil) {
    didSet {
      self.delegate.map { $0.reloadTableView() }
    }
  }
  private var isFetching: Bool = false {
    didSet {
      self.delegate.map { $0.loaderDidChange(withStatus: self.isFetching) }
    }
  }
  private var currentPageNumber: Int = 1
  weak var delegate: MoviesHomeViewModelDelegate?
  
  init() {
    
  }
  
  deinit {
    
  }
  
  public func viewLoaded(delegate: MoviesHomeViewModelDelegate?) {
    self.delegate = delegate
  }
  
  public func paginate(withSearchText text: String) {
    self.search(text: text, pageNumber: (self.currentPageNumber + 1))
  }
  
  public func search(text: String) {
    self.clearSearch()
    self.search(text: text, pageNumber: 1)
  }
  
  public func clearSearch() {
    self.currentPageNumber = 1
    self.datasource = MoviesHomeDataSource(result: nil)
  }
  
  //MARK: Private
  private func search(text: String, pageNumber: Int) {
    self.currentPageNumber = pageNumber
    
    if self.isFetching {
      return
    }
    
    self.isFetching = true
    MovieSearchService.search(withText: text, pageNumber: self.currentPageNumber) { (result, error) in
      
      //make fetching false
      self.isFetching = false
      
      guard let unwrappedResult = result else {
        return
      }
      var movies = unwrappedResult.movies
      //append results for pagination
      if pageNumber > 1 {
        movies = self.datasource.movies + movies
      }
      self.datasource = MoviesHomeDataSource(result: MovieSearchResult(movies: movies))
      if self.datasource.movies.count > 0 {
        self.delegate.map { $0.dismissKeyBoard() }
      }
    }
  }
  
  //MARK: Table Support
  public func numberOfRows(inSection section: Int) -> Int {
    return datasource.movies.count
  }
  
  public func dataModel(forRowAtIndex index: Int) -> Movie {
    return datasource.movies[index]
  }
  
  public func numberOfSections() -> Int {
    return 1
  }
}
