//
//  ReminderViewController.swift
//  Reminders
//
//  Created by Anton Wintergerst on 11/05/2016.
//  Copyright © 2016 Anton Wintergerst. All rights reserved.
//

import UIKit

// MARK: - ReminderDelegate Protocol Definition
protocol ReminderDelegate {
    func shouldAddReminder(reminder: Reminder)
    func shouldEditReminder(reminder: Reminder, indexPath: NSIndexPath)
}

// MARK: - Reminder detail screen ViewController
class ReminderViewController: UIViewController,
  UITableViewDelegate,
  UITableViewDataSource,
  TaskTableViewDelegate {

  // MARK: IB Connections
  @IBOutlet weak var tasksTableView: UITableView!
  @IBOutlet weak var titleTextField: UITextField!

  // MARK: Constants
  let taskTableViewCellIdentifier = "TaskTableViewCell"
  let addTaskTableViewCellIdentifier = "AddTaskTableViewCell"

  // MARK: Variables
  var delegate: ReminderDelegate?
  var reminder = Reminder()
  var reminderIndexPath: NSIndexPath?
  var editingTaskTextfield: UITextField?
  var editingTaskIndexPath: NSIndexPath?

  // MARK: UIViewController functions
  override func viewWillAppear(animated: Bool) {

    super.viewWillAppear(animated)

/*    if let reminderIndexPath = reminderIndexPath {
      print("ReminderViewController::reminderIndexPath = \(reminderIndexPath.row)")
    } else {
      print("ReminderViewController::reminderIndexPath = NO INDEX PATH")
    }*/

    titleTextField.text = reminder.title

    // Set delegate and dataSource variables for tasksTableView
    tasksTableView.delegate = self
    tasksTableView.dataSource = self

    // Update tasksTableView data
    tasksTableView.reloadData()
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)

    // Store last edited task
    saveLastEditedTask()

    // Store reminder title
    reminder.title = titleTextField.text

    // Use delegate function to edit reminder
    // if it already exists or add a new one if it doesn't exist
    if let reminderIndexPath = reminderIndexPath {
      delegate?.shouldEditReminder(reminder, indexPath: reminderIndexPath)
    } else {
      delegate?.shouldAddReminder(reminder)
    }
  }

  func saveLastEditedTask() {
    if let indexPath = editingTaskIndexPath {
       var task = reminder.tasks[indexPath.row]
      task.description = editingTaskTextfield?.text
      reminder.tasks[indexPath.row] = task
    }
  }

  // MARK: TaskTableViewDelegate
  func didBeginEditingTask(cell: UITableViewCell, textField: UITextField) {
//    print("didBeginEditingTask was called.")
    if let indexPath = tasksTableView.indexPathForCell(cell) {
      // Save reminder task textfield and indexPath for use later

      // This one removes the bug where you add two tasks then type in first
      // then type in second without a RETURN of first bug.
      if editingTaskTextfield != textField {
        saveLastEditedTask()
      }

      //Store the current text field and indexPath for call back to save it if no RETURN.
      editingTaskTextfield = textField
      editingTaskIndexPath = indexPath
//      print("ROW is: \(editingTaskIndexPath!.row) ")
    }
  }

  func didUpdateTask(cell: UITableViewCell, completed: Bool, description: String?) {
//    print("didUpdateTask was called and completed = \(completed) with \(description) ")
    if let indexPath = tasksTableView.indexPathForCell(cell) {
      if reminder.tasks.count > indexPath.row {
        // Update reminder task at indexPath
//        print("ReminderViewController::didUpdateTask Task:"
//          + "\(indexPath.row) with \(description) and \(completed)")
        reminder.tasks[indexPath.row].description = description!
        reminder.tasks[indexPath.row].completed = completed

        if reminderIndexPath != nil {
          delegate?.shouldEditReminder(reminder, indexPath: reminderIndexPath!)
        }
      }
    }
  }

  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // + 1 for add reminder task cell
    return reminder.tasks.count + 1
  }

  // MARK: UITableViewDelegate
  func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
    let cell: UITableViewCell?

    switch indexPath.row {
      case reminder.tasks.count:
        cell = tableView.dequeueReusableCellWithIdentifier(addTaskTableViewCellIdentifier)
      default:
        cell = tableView.dequeueReusableCellWithIdentifier(taskTableViewCellIdentifier)
        if let cell = cell as? TaskTableViewCell {
          // Set cell delegate variable
          cell.delegate = self

          if reminder.tasks.count > indexPath.row {
            // Set cell completed state and description
            let task = reminder.tasks[indexPath.row]
            cell.completed = task.completed
            cell.textField.text = task.description
            cell.updateRadioButton()
          }
        }
    }

    if let cell = cell {
      return cell
    } else {
//      print("Warning: TableView contains default cell type")
      return UITableViewCell()
    }
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch indexPath.row {
      case reminder.tasks.count:
        // Store last edited task
        saveLastEditedTask()

        // Add new task
        reminder.tasks.append(Task())

        // Update tasksTableView data
        tableView.reloadData()
      default:
        break
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  func tableView(
    tableView: UITableView,
    commitEditingStyle editingStyle: UITableViewCellEditingStyle,
    forRowAtIndexPath indexPath: NSIndexPath
    ) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      // Remove reminder task using indexPath.row
      reminder.tasks.removeAtIndex(indexPath.row)

      tableView.deleteRowsAtIndexPaths(
        [indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
  }

}
