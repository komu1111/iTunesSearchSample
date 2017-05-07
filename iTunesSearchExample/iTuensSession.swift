//
//  iTuensSession.swift
//  iTunesSearchExample
//
//  Created by Shohei Komura on 2017/05/05.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation
import APIKit
import Result
import RxSwift
import RxCocoa

struct iTunesSession {
    static func send<T: iTunesRequest>(_ request: T) -> Observable<T.Response> {
        let observable = Observable<T.Response>.create { observer in
            let task = Session.send(request, callbackQueue: .main, handler: { result in
                switch result {
                case .success(let value):
                    observer.on(.next(value))
                    observer.onCompleted()
                case .failure(let error):
                    if (error as NSError).code == URLError.cancelled.rawValue {
                        observer.onCompleted()
                        break
                    }
                    observer.onError(error)
                }
            })
            return Disposables.create(with: {
                task?.cancel()
            })
        }
        return observable.take(1) //Observableによって送信される最初のn個のアイテムのみ送信される
    }
    
    static func cancelRequest<T: Request>(with type: T.Type) {
        Session.cancelRequests(with: type)
    }
}

