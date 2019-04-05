//
//  TagStore.swift
//  TaskKiller
//
//  Created by mac on 14/01/2019.
//  Copyright © 2019 Oleg Tokmachov. All rights reserved.
//

import Foundation

protocol TagsPreparingStore {
    var count: Int { get }
    mutating func remove(_ tag: Tag)
    mutating func add(_ tag: Tag)
    mutating func insert(tag: Tag, atIndex index: Int)
    func tag(at index: Int) -> Tag
    func index(Of tag: Tag) -> Int?
    func canAdd(_ tag: Tag) -> Bool
}
