//
//  DeleteTagDelegate.swift
//  TaskKiller
//
//  Created by mac on 15/01/2019.
//  Copyright © 2019 Oleg Tokmachov. All rights reserved.
//

import Foundation

protocol DeleteTagDelegate {
    func needsToBeDeleted(_ tag: Tag)
}
