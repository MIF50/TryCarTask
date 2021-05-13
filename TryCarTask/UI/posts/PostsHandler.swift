//
//  PostsHandler.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

// MARK:- PostHandler
class PostsHandler: NSObject,UITableViewDataSource, UITableViewDelegate {
    
    var indexData = [Post]()
    var didTapPost:((IndexPath)->Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapPost?(indexPath)
    }
}
