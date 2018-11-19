//
//  TaskListVC.swift
//  TaskKiller
//
//  Created by Oleg Tokmachov on 09.11.2018.
//  Copyright © 2018 Oleg Tokmachov. All rights reserved.
//

import UIKit
import CoreData

class TaskListVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var fetchRequestController: NSFetchedResultsController<Task>!
    private var taskStaticInfoUpdater: TaskStaticInfoUpdating!
    private var taskProgressTimesUpdater: TaskProgressTimesUpdating!
    private var taskInfoGetableHandler: IProgressTrackingTaskHandler!
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        taskStaticInfoUpdater = TaskStaticInfoUpdater()
        taskProgressTimesUpdater = TaskProgressTimesUpdater()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequestController = createFetchResultsController()
    }
    //MARK: TableViewDelegate, datasource methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchRequestController.sections!.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchRequestController.sections else { fatalError() }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else { fatalError() }
        let taskObject = fetchRequestController.object(at: indexPath)
        let taskModelFacade = TaskModelFacade(task: taskObject)
        let taskInfoGetableHandler = ProgressTrackingTaskHandler(taskModelFacade: taskModelFacade)
        taskStaticInfoUpdater.update(taskCell, from: taskInfoGetableHandler)
        taskProgressTimesUpdater.update(taskCell, from: taskInfoGetableHandler)
        return taskCell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let task = fetchRequestController.object(at: indexPath)
            PersistanceService.context.delete(task)
            PersistanceService.saveContext()
        default: break
        }
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: UITableView.RowAnimation.fade)
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    @IBAction func backFromTaskVC(segue: UIStoryboardSegue) {}
}
extension TaskListVC {
    private func createFetchResultsController() -> NSFetchedResultsController<Task> {
        let fetchResuest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: true)
        fetchResuest.sortDescriptors = [sortDescriptor]
        let fetchRequestController = NSFetchedResultsController(fetchRequest: fetchResuest, managedObjectContext: PersistanceService.context, sectionNameKeyPath: nil, cacheName: "TaskCache")
        guard let _ = try? fetchRequestController.performFetch() else { fatalError() }
        fetchRequestController.delegate = self
        return fetchRequestController
    }
}
