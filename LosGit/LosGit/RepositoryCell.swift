//
//  RepositoryCell.swift
//  LosGit
//
//  Created by Marco Tullio Braga Filho on 29/10/19.
//  Copyright © 2019 Marco Tullio Braga Filho. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var repositoryStars: UILabel!
    @IBOutlet weak var repositoryForks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
