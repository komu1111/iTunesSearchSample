//
//  SearchSongViewModel.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/06.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchSongViewModel {
    
    let songs: Variable<[iTunesSong]> = Variable([iTunesSong]())
    let isLoading: Variable<Bool> = Variable(false)
    let error: Variable<Error?> = Variable(nil)
    
    private var currentQuery: String? = nil
    private var disposeBag: DisposeBag = DisposeBag()
    
    func fetchSongs(with query: String) {
        songs.value.removeAll()
        currentQuery = query
        isLoading.value = true
        fetchMoreSongs()
    }
    
    func fetchMoreSongs() {
        guard let currentQuery = currentQuery, !currentQuery.isEmpty else {
            isLoading.value = false
            return
        }
        disposeBag = DisposeBag()
        
        let request = iTunesSearchRequest(term: currentQuery)
        iTunesSession.send(request)
            .do(onCompleted: { [unowned self] in
                self.isLoading.value = false
            })
            .do(onError: { [unowned self] error in
                self.error.value = error
                self.isLoading.value = false
            })
            .subscribe(onNext: { [unowned self] response in
                self.songs.value += response.value
            })
            .addDisposableTo(disposeBag)
    }
}

