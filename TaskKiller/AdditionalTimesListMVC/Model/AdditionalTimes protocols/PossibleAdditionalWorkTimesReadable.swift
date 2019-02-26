//
//  PossibleAdditionalWorkTimesReadable.swift
//  TaskKiller
//
//  Created by mac on 24/02/2019.
//  Copyright © 2019 Oleg Tokmachov. All rights reserved.
//

import Foundation
protocol PossibleAdditionalWorkTimesReadable {
    var possibleAdditionalWorkTimesWithIds: [String : TimeInterval] { get }
}