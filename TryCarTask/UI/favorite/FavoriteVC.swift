//
//  FavoriteVC.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

class FavoriteVC: BaseVC {
    
    @IBOutlet var tableView: UITableView!
    
    // MARK:- ViewModel
    fileprivate let viewModel = FavoriteViewModel()
    
    // MARK:- vars
    private var postId = 1
    
    override func setupView() {
        super.setupView()
    }
    
    override func observeViewModel() {
        super.observeViewModel()
       
    }
}

// MARK:- CreateFavoriteVC
extension FavoriteVC {
    
    static func create()-> UIViewController {
        let vc = FavoriteVC.instantiate(name: .Main)
        vc.navigationItem.title = "Favorite"
        vc.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.circle.fill"), tag: 1)
        return UINavigationController(rootViewController: vc)
    }
}
