//
//  SearchArtistViewController.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchArtistViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let viewModel: SearchSongViewModel = SearchSongViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSelf))
        self.view.addGestureRecognizer(tapGesture)
        
        configureTableView()
        configureObserver()
        
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = SearchArtistViewCell.defaultHeight
        tableView.register(SearchArtistViewCell.self)
        tableView.delegate = self
    }
    
    private func configureObserver() {
        viewModel.songs.asDriver().drive(tableView.rx.items(cellIdentifier: SearchArtistViewCell.className, cellType: SearchArtistViewCell.self)) { _,  song, cell in
            cell.configure(with: song)
            }
            .addDisposableTo(disposeBag)
        
        searchBar.rx.text.orEmpty.asDriver()
            .skip(1)
            .debounce(0.3)
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] query in
                self.viewModel.fetchSongs(with: query)
            })
            .addDisposableTo(disposeBag)
        
        viewModel.isLoading.asDriver()
            .drive(onNext: { [unowned self] isLoading in
                self.alphaView.isHidden = !isLoading
                self.indicatorView.isHidden = !isLoading
                self.indicatorView.rx.isAnimating.on(.next(isLoading))
                
            })
        .addDisposableTo(disposeBag)
        
    }
    
    func tapSelf() {
        self.view.endEditing(true)
    }
    
}

extension SearchArtistViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

