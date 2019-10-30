//
//  PullRequestController.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 30/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import UIKit
import SDWebImage

class PullRequestController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var repository: Repository?
    
    var ownerName: String? {
        get {
            return repository?.owner?.name
        }
    }
    
    var repositoryName: String? {
        get {
            return repository?.name
        }
    }
    
    var service: PullRequestService?
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        service = PullRequestService(controller: self)
        service?.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let ip = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: ip, animated: false)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestCell") as! PullRequestCell
        let pullRequest = pullRequests[indexPath.row]
        
        cell.ownerName.text = pullRequest.author?.name ?? ""
        if let url = pullRequest.author?.photoUrl {
            cell.ownerImage.sd_setImage(with: URL(string: url), completed: nil)
        }
        
        cell.pullRequestTitle.text = pullRequest.title ?? ""
        cell.pullRequestBody.text = pullRequest.body ?? ""
        
        if let date = pullRequest.creationDate {
            cell.pullRequestDate.text = formatter.string(from: date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pullRequest = pullRequests[indexPath.row]
        
        if let urlString = pullRequest.url, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
    var pullRequests = [PullRequest]()
    
    func updateContent(_ content: [PullRequest]) -> Void {
        DispatchQueue.main.async {
            self.pullRequests.append(contentsOf: content)
            self.tableView.reloadData()
        }
    }

}
