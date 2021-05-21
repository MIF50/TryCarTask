//
//  BaseVC.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

protocol BaseVCType {
    func setupView()
    func observeViewModel()
}

class BaseVC: UIViewController, BaseVCType, Storyboarded {
    
    private var containerView: UIView!
    var subscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observeViewModel()
    }
    
    func setupView() {}
    
    func observeViewModel() {}
    
    deinit {
        subscriber?.cancel()
    }
    
    // MARK:- showLoading
    func showLoadingView() {
        configureContainerView()
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        configureActivityIndicator()
    }
    
    // MARK:- hideLoading
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    // MARK:- showEmptyState
    func showEmptyStateView(with message: String, in view: UIView) {
        navigationItem.searchController = nil
        let emptyStateView = TCEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    fileprivate func configureContainerView() {
        containerView = UIView(frame: view.bounds)
        view.addSubviews(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0 // Tranparent
    }
    
    fileprivate func configureActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style:  .large)
        containerView.addSubviews(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
}

