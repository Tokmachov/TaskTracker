//
//  TaskInfoGetableModelHandler.swift
//  TaskKiller
//
//  Created by Oleg Tokmachov on 19.11.2018.
//  Copyright © 2018 Oleg Tokmachov. All rights reserved.
//

import Foundation

struct InfoGetableTaskHandlerImp: InfoGetableTaskHandler {

    private let task: Task
    private var deadline: TimeInterval {
        return task.getPostponableDeadline()
    }
    private var timeSpentInprogress: TimeInterval {
        return task.getTimeSpentInProgress()
    }
    private var timeLeftToDeadLine: TimeLeftToDeadLine {
        switch (deadline, timeSpentInprogress) {
        case let (deadLine, spentInProgress) where deadLine > spentInProgress: return .timeLeft(deadLine - spentInProgress)
        case let (deadLine, spentInProgress) where deadLine <= spentInProgress: return .noTimeLeft
        default: return .noTimeLeft
        }
    }
    
    private var timeSpentInProgress: TimeInterval {
        return task.getTimeSpentInProgress()
    }
    
    //MARK: TaskHandling
    init(task: Task) {
        self.task = task
    }
    
    //MARK: TaskProgressTimesCreating
    func createProgressTimes() -> TaskProgressTimes {
        let progressTimes = TaskProgressTimes.init(timeSpentInprogress: timeSpentInProgress, timeLeftToDeadLine: timeLeftToDeadLine)
        return progressTimes
    }
    
    //MARK: TaskStaticInfoCreating
    func createStaticInfo() -> TaskStaticInfo {
        let taskDescription = task.getTaskDescription()
        let initialDeadline = task.getInitialDeadline()
        let tags = task.getTags()
        return TaskStaticInfo.init(taskDescription: taskDescription, initialDeadLine: initialDeadline, tags: tags)
    }
}
