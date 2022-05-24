//
//  Position.swift
//  function-swift
//
//  Created by Nelo on 2022/2/11.
//

import Foundation

typealias Distance = Double


struct Position {
    var x: Double
    var y: Double
}

extension Position {
    
    func inRange(range: Distance) -> Bool {
        sqrt(x * x + y * y) <= range
    }
    
    func minus(_ p: Position) -> Position {
        Position(x: x - p.x, y: y - p.y)
    }
    
    var length: Double {
        sqrt(x * x + y * y)
    }
}
