//
//  Dynamic.swift
//  Fixtures
//
//  Created by Ben Smith on 30/01/2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
//view model to view live binding , that binds the values in our model to the text field values
class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener :Listener?
    
    func bind(listener :Listener?) {
        self.listener = listener
        listener?(value!)
    }
    
    var value :T? {
        didSet {
            listener?(value!)
        }
    }
    
    init(_ v:T) {
        value = v
    }
    
}
