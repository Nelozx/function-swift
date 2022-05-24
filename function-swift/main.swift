//
//  main.swift
//  function-swift
//
//  Created by Nelo on 2022/2/11.
//

import Foundation

print("Hello, World!")


let targetShip = Ship(position: Position(x: 5, y: 5), firingRange: 20, unsafeRange: 3)

let friendlyShip = Ship(position: Position(x: 2, y: 3), firingRange: 20, unsafeRange: 3)

let res1 = targetShip.canSafelyEngageShip1(target: targetShip, friendly: friendlyShip)
let res2 = targetShip.canSafelyEngageShip2(target: targetShip, friendly: friendlyShip)
let res3 = targetShip.canSafelyEngageShip(target: targetShip, friendly: friendlyShip)

print(res1, res2, res3)


