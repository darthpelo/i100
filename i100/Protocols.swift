//
//  Protocols.swift
//  i100
//
//  Created by Alessio Roberto on 23/10/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

protocol Sharable {
    func share(number: String) -> UIViewController
}

protocol Notification {
    func addObserver(name aName: NotificationName)
    
    func catchNotification(notification:NSNotification)
}

protocol ViewProtocol: class {
    func updateChess(at indexPath: IndexPath, with newValue: Int)
}

protocol BottomViewDelegate: class {
    func requestReset()
    func requestInfo()
    func requestShare(score: String?)
    func requestMaxScore() -> Int
}
