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
    
    var subscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observeViewModel()
    }
    
    func setupView() {}
    
    func observeViewModel() {}
    
    override func viewDidDisappear(_ animated: Bool) {
        subscriber?.cancel()
    }
}
