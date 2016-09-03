//
//  GameService.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation

public final class GameService {    
    public static var shared: GameService!
}

extension GameService {
    public func userScore() -> Int {
        return UserDefaults.standard.integer(forKey: "com.alessioroberto.i100.userScore")
    }
    
    public func update(score: Int) {
        UserDefaults.standard.set(score, forKey: "com.alessioroberto.i100.userScore")
    }
    
    public func resetData() {
        UserDefaults.standard.set(0, forKey: "com.alessioroberto.i100.userScore")
    }
}
