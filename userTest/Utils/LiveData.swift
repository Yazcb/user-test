//
//  LiveData.swift
//  userTest
//
//  Created by Yazmin Carmona on 12/09/22.
//

import Foundation
import UIKit

class LiveData<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(self.value)
    }
    
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ v: T) {
        self.value = v
    }
    
    func release() {
        self.listener = nil
    }
}
