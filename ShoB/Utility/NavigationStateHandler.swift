//
//  NavigationStateHandler.swift
//  ShoB
//
//  Created by Dara Beng on 7/30/19.
//  Copyright © 2019 Dara Beng. All rights reserved.
//

import Combine


struct NavigationStateHandler {
    
    /// A flag to bind with `NavigationLink.isActive`.
    var isPushed = false {
        willSet { state = newValue ? .pushed : .poped }
    }
    
    /// The state of the navigation.
    private var state: State? = .none {
        willSet {
            switch newValue {
            case .pushed: onPushed?()
            case .poped: onPoped?()
            case .none: break
            }
        }
    }
    
    /// An action to perform when pushed.
    var onPushed: (() -> Void)?
    
    /// An action to perform when poped.
    var onPoped: (() -> Void)?
    
    
    enum State {
        case pushed
        case poped
    }
}
