//
//  PostTVCell.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

class PostTVCell: UITableViewCell {
    
    // MARK:- data
    var post: Post! {
        didSet {
            ImageUser.image = UIImage(named: "avatar")!
            titleLabel.text = post.title
            timeLabel.text = "20 min ago."
            commentLabel.text = post.body
        }
    }
    
    // MARK:- Outlet
    @IBOutlet var ImageUser: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleImage()
        commentLabel.numberOfLines = 0
    }
    
    private func styleImage() {
        ImageUser.layer.cornerRadius = 25
        ImageUser.layer.borderWidth = 1
        ImageUser.layer.borderColor = UIColor.lightGray.cgColor
    }
}

// MARK:- CreatePostTVCell
extension PostTVCell {
    
    static func create() -> UINib {
        return UINib(nibName: "PostTVCell", bundle: nil)
    }
}
