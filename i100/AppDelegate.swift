//
//  AppDelegate.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public func applicationDidFinishLaunching(_ application: UIApplication) {
        GameService.shared = GameService(chessboard: ChessBoard())
    }
}

