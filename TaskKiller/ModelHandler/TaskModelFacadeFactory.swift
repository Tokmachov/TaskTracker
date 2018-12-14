//
//  TaskModelFactory.swift
//  TaskKiller
//
//  Created by Oleg Tokmachov on 12.11.2018.
//  Copyright © 2018 Oleg Tokmachov. All rights reserved.
//

import Foundation
import CoreData

struct TaskModelFacadeFactory: ITaskModelFacadeFactory {
    
    static func createTaskModelFacade(from taskModel: TaskModel) -> ITaskModelFacade {
        return TaskModelFacade(task: taskModel)
    }
    
    static func createTaskModelFacade(from taskStaticInfo: TaskStaticInfo) -> ITaskModelFacade {
        let taskModel = createTaskModel(from: taskStaticInfo)
        let taskModelFacade = TaskModelFacade(task: taskModel)
        return taskModelFacade
    }
}

extension TaskModelFacadeFactory {
    static private func createTaskModel(from taskStaticInfo: TaskStaticInfo) -> TaskModel {
        let taskDescription = taskStaticInfo.taskDescription
        let initiaLdeadLine = Int16(taskStaticInfo.initialDeadLine)
        let postponableDeadline = Int16(taskStaticInfo.initialDeadLine)
        let currentDate = Date() as NSDate
        let taskModel = TaskModel(context: PersistanceService.context)
        let noTimeSpentInProgress = Int16(0)
        
        taskModel.taskDescription = taskDescription
        taskModel.deadLine = initiaLdeadLine
        taskModel.postponableDeadLine = postponableDeadline
        taskModel.dateCreated = currentDate
        taskModel.timeSpentInProgress = noTimeSpentInProgress
        
        PersistanceService.saveContext()
        
        return taskModel
    }
}

