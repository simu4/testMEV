//
//  InfoViewController.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 12.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let service = DataService()

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieDate: UILabel!
    var textString = ""
    @IBOutlet var poster: UIImageView!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        getPoster()
    }

    func getPoster() {
        showActivityIndicator()
        service.getMovie(title: textString, completion:
            { movie in
                self.hideActivityIndicator()
                self.setText(movie: movie)
                self.setImage(movie: movie)
        }, failure: {
            error in
            self.hideActivityIndicator()
            if !error.isEmpty {
                self.showAlert(error: error)
            }
        })
    }
    
    func showAlert(error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.presentMainView()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func presentMainView() {
        let vc = self.storyboard?.instantiateInitialViewController()
        vc?.modalTransitionStyle = .crossDissolve
        present(vc!, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async() {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.gray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async() {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    func setText(movie: PosterModel) {
        movieTitle.text = movie.title
        movieDate.text = movie.released
    }
    
    func setImage(movie: PosterModel) {
        if movie.poster == "N/A" {
            poster.image = #imageLiteral(resourceName: "f35ad9427be01af5955e6a6ce803f5dc")
        } else {
            getImage(movie: movie)
        }
    }
    
    func getImage(movie: PosterModel) {
        service.getPoster(movie: movie, completion: { image in
            self.poster.image = image
        })
    }
    
    func setupProperties() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Movie-poster-design-trends"))
    }
}
