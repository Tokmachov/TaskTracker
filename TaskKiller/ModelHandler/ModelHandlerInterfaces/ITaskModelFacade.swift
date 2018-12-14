//
//  TaskModelHandling.swift
//  TaskKiller
//
//  Created by Oleg Tokmachov on 12.11.2018.
//  Copyright © 2018 Oleg Tokmachov. All rights reserved.
//

import Foundation
import CoreData

protocol ITaskModelFacade {
    init(task: TaskModel)
    
    func getTaskDescription() -> String
   
    func getInitialDeadLine() -> TimeInterval
    
    func getPostponableDeadLine() -> TimeInterval
    
    func getTimeSpentInProgress() -> TimeInterval
    
    func getTagsStore() -> TagsStore
    
    func saveProgress(progressTimes: TaskProgressTimes, taskProgressPeriod: TaskProgressPeriod)
}