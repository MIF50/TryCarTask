//
//  CommentTVCell.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

class CommentTVCell: UITableViewCell {
    
    var comment: Comment! {
        didSet {
            nameLabel.text = comment.name
            emailLabel.text = comment.email
            CommentLabel.text = comment.body
        }
    }
    
    // MARK:- Outlet
    @IBOutlet var containerView: UIView!
    @IBOutlet var imageUser: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var CommentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        CommentLabel.numberOfLines = 0 
        styleImage()
    }
    
    private func styleImage() {
        imageUser.layer.cornerRadius = imageUser.frame.width / 2
        imageUser.layer.borderWidth = 1
        imageUser.layer.borderColor = UIColor.black.cgColor
    }
    
}

// MARK:- CreateCommentTVCell
extension CommentTVCell: NibLoadableView,ReusableView {
}
