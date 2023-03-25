//
//  ViewController.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func searchMoviesAction(_ sender: Any) {
    let movieSearchVC = MoviesHomeViewController()
    let navController = UINavigationController(rootViewController: movieSearchVC)
    navController.setNavigationBarHidden(true, animated: false)
    self.present(navController, animated: true, completion: nil)
  }
  
}

