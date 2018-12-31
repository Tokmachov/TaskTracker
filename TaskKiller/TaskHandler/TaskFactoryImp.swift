//
//  TaskModelFactory.swift
//  TaskKiller
//
//  Created by Oleg Tokmachov on 12.11.2018.
//  Copyright © 2018 Oleg Tokmachov. All rights reserved.
//

import Foundation
import CoreData

struct TaskFactoryImp: TaskFactory {
    
    static func createTask(from taskModel: TaskModel) -> Task {
        return TaskModelAdapter(task: taskModel)
    }
    
    static func createTask(from taskStaticInfo: TaskStaticInfo) -> Task {
        let taskModel = createTaskModel(from: taskStaticInfo)
        let taskModelFacade = TaskModelAdapter(task: taskModel)
        return taskModelFacade
    }
}

extension TaskFactoryImp {
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

