//
//  TaskStore.swift
//  MjeedTo-Do-LIst
//
//  Created by Abdullmajeed Alamri on 09/11/2020.
//

import UIKit

class TaskStore {
    var alltasks = [Task]()
    
    let taskArchiveURL : URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documantDirectory = documentsDirectories.first!
        return documantDirectory.appendingPathComponent("Task.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: taskArchiveURL)
            let unarchiver = PropertyListDecoder()
            let tasks = try unarchiver.decode([Task].self, from: data)
            alltasks = tasks
            print("Tasks loaded successfully")
        } catch {
            print("Error reading while saving data")
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    

    
    
    
    @objc func saveChanges() -> Bool {
        print("Saving tasks to: \(taskArchiveURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(alltasks)
            try data.write(to: taskArchiveURL, options: [.atomic])
            print("Saved all of the tasks")
            return true
        } catch let encodingError {
            print("Error encoding all tasks \(encodingError)")
            return false
        }
        
    }
    

    func removeTask(_ task: Task) {
        if let index = alltasks.firstIndex(of: task) {
            alltasks.remove(at: index)
            print("Task Deleted")
        }
    }
    
    
    func movetask(from fromIndex: Int , to toIndex: Int) {
        if fromIndex == toIndex {
            return
        } else {
            let movedCell = alltasks[fromIndex]
            alltasks.remove(at: fromIndex)
            alltasks.insert(movedCell, at: toIndex)
            print("Task Row Has Moved")
        }
    }
    
}
