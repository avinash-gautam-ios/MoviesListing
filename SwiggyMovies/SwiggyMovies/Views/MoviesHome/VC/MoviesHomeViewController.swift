//
//  MoviesHomeViewController.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import UIKit

class MoviesHomeViewController: UIViewController {
  
  @IBOutlet private weak var headerTitleLabel: UILabel!
  @IBOutlet weak var headerDescriptionLabel: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  private let viewModel = MoviesHomeViewModel()
  
  init() {
    super.init(nibName: String.stringFromClass(MoviesHomeViewController.self), bundle: Bundle(for: MoviesHomeViewController.self))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configure()
    self.viewModel.viewLoaded(delegate: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func configure() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    self.searchBar.delegate = self
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    
    let cellsToRegister = [MovieTableViewCell.self]
    self.tableView.registerCells(cellsToRegister, bundle: Bundle(for: MoviesHomeViewController.self))
    
    self.searchBar.becomeFirstResponder()
  }
  
  func navigate(withModel model: Movie) {
    let movieDetail = MovieDetailsViewController(dataModel: model)
    self.navigationController?.pushViewController(movieDetail, animated: true)
  }
  
}

extension MoviesHomeViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else {
      return
    }
    self.viewModel.search(text: searchText)
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
  }
}

extension MoviesHomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.numberOfRows(inSection: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
      return UITableViewCell()
    }
    cell.populateData(fromDataModel: self.viewModel.dataModel(forRowAtIndex: indexPath.row))
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row + 1 == self.viewModel.numberOfRows(inSection: indexPath.section),
      let searchText = self.searchBar.text {
      //its end
     self.viewModel.paginate(withSearchText: searchText)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.navigate(withModel: self.viewModel.dataModel(forRowAtIndex: indexPath.row))
  }
  
}

extension MoviesHomeViewController: MoviesHomeViewModelDelegate {
  func reloadTableView() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func dismissKeyBoard() {
    DispatchQueue.main.async {
      self.searchBar.resignFirstResponder()
    }
  }
  
  func loaderDidChange(withStatus status: Bool) {
    DispatchQueue.main.async {
      if status {
        self.spinner.startAnimating()
        self.spinner.isHidden = false
      } else {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
      }
    }
  }
}
