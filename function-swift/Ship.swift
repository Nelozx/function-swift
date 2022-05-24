//
//  Ship.swift
//  function-swift
//
//  Created by Nelo on 2022/2/11.
//

import Foundation

// Region 类型将指代把 Position 转化为 Bool 的函数
typealias Region = (Position) -> Bool

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    // p1
    func canEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange
    }
    
    // p2
    func canSafelyEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
    
    // p3
    func canSafelyEngageShip1(target: Ship, friendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        
        let fDx = friendly.position.x - position.x
        let fDy = friendly.position.y - position.y
        let friendlyDistance = sqrt(fDx * fDx + fDy * fDy)
        
        return targetDistance <= firingRange
        && targetDistance > unsafeRange
        && (friendlyDistance > unsafeRange)
    }
    
    // p4
    func canSafelyEngageShip2(target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(friendly.position).length
        let friendlyDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange
        && targetDistance > unsafeRange
        && (friendlyDistance > unsafeRange)
    }
    
    // p5
    func canSafelyEngageShip(target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = difference(circle(firingRange), minus: circle(unsafeRange))
        let firingRegion = shift(rangeRegion, offset: position)
        let friendlyRegion = shift(circle(unsafeRange), offset: friendly.position)
        let resultRegion = difference(firingRegion, minus: friendlyRegion)
        return resultRegion(target.position)
    }
}

// MARK: - Functional
extension Ship {
    
    func circle(_ radius: Distance) -> Region {
        return { point in point.length <= radius }
    }
    func circle2(_ radius: Distance, _ center: Position) -> Region {
        return { point in point.minus(center).length <= radius }
    }
    
    func shift(_ region: @escaping Region, offset: Position) -> Region {
        return { point in region(point.minus(offset)) }
    }
    
    func invert(_ region: @escaping Region) -> Region {
        return { point in !region(point) }
    }
    
    /// 交集
    func intersection(_ region1: @escaping Region, _ region2: @escaping Region) -> Region {
        return { point in region1(point) && region2(point) }
    }
    
    // 并集
    func union(region1: @escaping Region, _ region2: @escaping Region) -> Region {
        return { point in region1(point) || region2(point) }
    }
    
    // 差
    func difference(_ region: @escaping Region, minus: @escaping Region) -> Region {
        return intersection(region, invert(minus))
    }

}
