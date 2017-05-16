//
//  HistoryTableViewController.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 12.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    @IBOutlet var historyView: UITableView!
    var movies = [PosterModel]()
    let service = DataService()
    var textString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        if service.getMoviesFromDB() != nil {
            movies = service.getMoviesFromDB()!
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.movieTitle.text = movie.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            service.removeMovieFromList(movie: movies[indexPath.row])
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func presentMainView() {
        let vc = self.storyboard?.instantiateInitialViewController()
        vc?.modalTransitionStyle = .crossDissolve
        present(vc!, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textString = movies[indexPath.row].title
        presentInfoView()
    }
    
    func presentInfoView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        vc?.textString = textString
        show(vc!, sender: nil)
    }
    
    func setupProperties() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Movie-poster-design-trends"))
    }
}
