//  Copyright © 2016 HB. All rights reserved.

class ReminderViewController: UIViewController,
  UITableViewDelegate,
  UITableViewDataSource,
  UITextFieldDelegate {

  @IBOutlet weak var tasksTableView: UITableView!
  @IBOutlet weak var titleTextField: UITextField!

  let taskTableViewCellIdentifier = "TaskTableViewCell"
  let addTaskTableViewCellIdentifier = "AddTaskTableViewCell"

  var numberOfRows = 0
  var reminder: Reminder?

  // MARK: ViewController Lifecycle

  override func viewDidAppear(animated: Bool) {
    tasksTableView.delegate = self
    tasksTableView.dataSource = self
    titleTextField.delegate = self

    if reminder == nil {
      reminder = Reminder(title: "New Reminder", tasks: [])
    }
    
    titleTextField!.text = reminder!.title

    print("There are \(reminder!.tasks.count) Tasks in Reminders: \(reminder!.title)")

    tasksTableView.reloadData()
  }

  func setReminder() {
    print("setReminder")
    reminder!.title = titleTextField.text
//    tasksTableView

  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    print("textField \(textField.text)")

    setReminder()
    textField.resignFirstResponder()
    return true
  }

  // Mark: TableView Delegate and DataSource

  func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
//      return numberOfRows + 1
      return reminder!.tasks.count + 1
  }

  func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell?

    //    print("indexPath.row = \(indexPath.row) and taskList.count \(taskList.count) ")
    if reminder!.tasks.count == indexPath.row {
      cell = tableView.dequeueReusableCellWithIdentifier(addTaskTableViewCellIdentifier)
    } else {
      cell = tableView.dequeueReusableCellWithIdentifier(taskTableViewCellIdentifier)
      if let cell = cell as? TaskTableViewCell {

        cell.setButton( reminder!.tasks[indexPath.row].completed )
        cell.descriptionField.text = reminder!.tasks[indexPath.row].description

      }
    }

    //      switch indexPath.row {
    //      case 0 where indexPath.row == 0, indexPath.row:
    //        cell = tableView.dequeueReusableCellWithIdentifier(addTaskTableViewCellIdentifier)
    //      default:
    //        cell = tableView.dequeueReusableCellWithIdentifier(taskTableViewCellIdentifier)
    //        if let cell = cell as? TaskTableViewCell {
    //          print("indexPath.row = \(indexPath.row)")
    //          cell.setButton( taskList[indexPath.row].completed )
    //          cell.descriptionField.text = taskList[indexPath.row].description
    //        }
    //      }

    return cell!
  }

  func tableView(
    tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {

    if reminder!.tasks.count == indexPath.row {
      reminder!.tasks.append(Task(completed: false, description: ""))
      tableView.reloadData()
    } else {

    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  func setReminder(reminder: Reminder?) {
    guard reminder != nil else { return }

    self.reminder = reminder
    tasksTableView.reloadData()
  }

//  func update(indexPath: NSIndexPath, reminder: Reminder?) {
//    guard task != nil else { return }
//
//    reminder!.tasks[indexPath.row] = task!
//    tasksTableView.reloadData()
//  }

}

import UIKit
