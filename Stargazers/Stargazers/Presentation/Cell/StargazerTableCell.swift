//
//  StargazerTableCell.swift
//  Stargazers
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import UIKit

class StargazerTableCell: UITableViewCell {
    static let reuseIdentifier = String(describing: StargazerTableCell.self)
    static let height = CGFloat(65)    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var stargazerLoginLabel: UILabel!
    
    var cellViewModel: StargazersListCellViewModel? {
        didSet {
            self.setup()
        }
    }
}


extension StargazerTableCell {
    fileprivate func setup(){
        let avatarImageUrl = (cellViewModel?.avatar_url ?? "")
        avatarImageView.loadImage(urlString: avatarImageUrl)
        stargazerLoginLabel.text = cellViewModel?.login
    }
}
