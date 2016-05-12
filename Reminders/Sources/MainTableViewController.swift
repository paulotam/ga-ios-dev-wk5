//
//  MainTableViewController.swift
//  Reminders
//
//  Created by Anton Wintergerst on 11/05/2016.
//  Copyright © 2016 Anton Wintergerst. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, ReminderDelegate {
    
    // MARK: Constants
    let menuTableViewCellId = "MenuTableViewCell"
    let addTableViewCellId = "AddReminderTableViewCell"
    
    // MARK: Variables
    var reminders = [Reminder]()
    var selectedIndexPath: NSIndexPath?
    
    // MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate sample reminder
        let reminder = Reminder()
        reminder.title = "Homework"
        reminder.tasks = [Task(completed: false, description: "Complete Assignment 5")]
        reminders.append(reminder)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update tableView data
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let viewController = segue.destinationViewController as? AddReminderViewController {
            
            // DONE TODO: Set delegate variable for viewController
            viewController.delegate = self
            
        } else if let viewController = segue.destinationViewController as? EditReminderViewController {
            if let selectedIndexPath = selectedIndexPath {
                if reminders.count > selectedIndexPath.row {
                    
                    // TODO: Pass reminder, selectedIndexPath and set delegate variable for viewController
                    viewController.reminder = reminders[selectedIndexPath.row]
                    viewController.reminderIndexPath = selectedIndexPath
                    viewController.delegate = self
                }
            }
        }
    }
    
    // MARK: - AddReminderDelegate
    func shouldAddReminder(reminder: Reminder) {
        // TODO: Add new reminder
        reminders.append(reminder)
    }
    
    // MARK: - EditReminderDelegate
    func shouldEditReminder(reminder: Reminder, indexPath: NSIndexPath?) {
        // TODO: Edit existing reminder
        reminders[indexPath!.row] = reminder
    }
  
    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // + 1 for add reminder cell
        return reminders.count + 1
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        
        switch indexPath.row {
        case reminders.count:
            cell = tableView.dequeueReusableCellWithIdentifier(addTableViewCellId)
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(menuTableViewCellId)
            if let cell = cell {
              cell.textLabel?.text = reminders[indexPath.row].title
              let tasks = reminders[indexPath.row].tasks
              let noCommplete =  reminders[indexPath.row].returnComplete()
              let noTotal = reminders[indexPath.row].returnTotal()
              if tasks.count > 1 {
                cell.detailTextLabel?.text =
                  "\(noCommplete)/\(noTotal) Tasks Completed"
              } else {
                cell.detailTextLabel?.text =
                  "\(noCommplete)/\(noTotal) Task Completed"
              }
            }
        }
        
        if let cell = cell {
            return cell
        } else {
            print("Warning: TableView contains default cell type")
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedIndexPath = indexPath
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // TODO: Remove reminder using indexPath.row
            reminders.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
