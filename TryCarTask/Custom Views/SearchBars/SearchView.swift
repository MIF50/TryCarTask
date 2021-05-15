//
//  SearchView.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/15/21.
//

import UIKit

class SearchView: UIView {
    
    @IBOutlet var contentView: CardView!
    @IBOutlet var searchIcon: UIImageView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var clearSearchButton: UIImageView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    // MARK:- DELEGATE
    weak var delegate: SearchViewDelegate? = nil

    // MARK:- PUBLIC
    var searchText: String {
        get {
            return self.searchTextField.text ?? ""
        }
    }
    
    var isLoading: Bool {
        get {
            return loadingIndicator.isHidden
        }
        set{
            if newValue {
                showLoading()
            } else {
                hideLoading()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        searchIcon.tintColor = .lightGray
        clearSearchButton.tintColor = .lightGray
        
        // Setting the UITextFieldDelegate
        self.searchTextField.delegate = self
        // Action ClearImage
        self.clearSearchButton.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTappedClear))
        self.addGestureRecognizer(tapGestureRecognizer)
        ///
        clearSearchButton.isHidden  = true
        loadingIndicator.isHidden = true
    }
    
    @objc private func didTappedClear() {
        delegate?.onSearchCleared()
        searchTextField.endEditing(true)
    }
    
    private func showLoading() {
        searchIcon.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    private func hideLoading() {
        searchIcon.isHidden = false
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }


    // MARK:- PUBLIC
    func setup(placeholder: String?, delegate: SearchViewDelegate? = nil) {
        self.searchTextField.placeholder = placeholder
        self.delegate = delegate
    }
}

// MARK:- UITextFieldDelegate
extension SearchView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.didBeginEditing()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.delegate?.onSearchCleared()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        clearSearchButton.isHidden = searchText.isEmpty
        if !searchText.isEmpty {
            self.delegate?.onSearch(text: searchText)
            Debounce<String>.input(searchText,comparedAgainst: textField.text ?? "") {
                self.delegate?.onSearchWithDelay(text: $0)
            }
        } else {
            self.delegate?.onSearchCleared()
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.delegate?.didEndEditing()
        searchTextField.text = ""
        return true
    }
}

protocol SearchViewDelegate: AnyObject {
    func onSearch(text: String)
    func onSearchWithDelay(text: String)
    func onSearchCleared()
    func didBeginEditing()
    func didEndEditing()
}

extension SearchViewDelegate {
    func onSearch(text: String) { }
    func onSearchWithDelay(text: String) { }
    func onSearchCleared() { }
    func didBeginEditing() { }
    func didEndEditing() { }
}
