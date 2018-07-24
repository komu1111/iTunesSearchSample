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
    var selecedImageView: UIImageView!
    var myTransition = MyTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSelf))
        //        self.view.addGestureRecognizer(tapGesture)
        
        configureTableView()
        configureObserver()
    }
    
    func copyImageView() -> UIImageView {
        let image = UIImageView(image: selecedImageView.image)
        image.frame = selecedImageView.convert(selecedImageView.bounds, to: self.view)
        image.contentMode = selecedImageView.contentMode
        return image
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
    
    //    func tapSelf() {
    //        self.view.endEditing(true)
    //    }
    
    func presentSecondView() {
        let vc = DetailViewController.instantiate()
        vc.transitioningDelegate = myTransition
        present(vc, animated: true, completion: nil)
    }
}

extension SearchArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchArtistViewCell {
            selecedImageView = cell.coverImageView
            presentSecondView()
        }
    }
}
