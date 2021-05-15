//
//  CommentHandler.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

// MARK:- CommentHanlder
class CommentHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var indexData = [Comment]()
    
    func setup(tableView: UITableView) {
        /// register cell
        tableView.register(CommentTVCell.self)
        /// delegate
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CommentTVCell
        cell.selectionStyle = .none
        cell.comment = indexData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
