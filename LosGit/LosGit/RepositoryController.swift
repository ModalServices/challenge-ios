//
//  ViewController.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 29/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var repositories = [Repository]()
    
    var service: RepositoryService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = RepositoryService(controller: self)
        loadAnotherPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let ip = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: ip, animated: false)
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryCell
        let repository = repositories[indexPath.row]
        
        cell.repositoryName.text = repository.name ?? ""
        cell.repositoryDescription.text = repository.description ?? ""
        
        cell.authorName.text = repository.owner?.name ?? ""
        if let url = repository.owner?.photoUrl {
            cell.authorImage.sd_setImage(with: URL(string: url), completed: nil)
        }
        
        cell.repositoryForks.text = "Forks: \(repository.forksCount ?? 0)"
        cell.repositoryStars.text = "Stars: \(repository.starsCount ?? 0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(175)
    }
    
    var currentPage = 0
    
    @IBAction func loadAnotherPage() {
        currentPage += 1
        service?.loadPage()
    }
    
    func updateContent(_ content: [Repository]) -> Void {
        DispatchQueue.main.async {
            self.repositories.append(contentsOf: content)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! RepositoryCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let destination = segue.destination as! PullRequestController
        let repository = repositories[indexPath.row]
        
        destination.repository = repository
    }
    
}
