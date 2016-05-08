//  Copyright © 2016 HB. All rights reserved.

class MainTableViewController: UITableViewController, AddReminderDelegate {

  let menuTableViewCellId = "MenuTableViewCell"
  let addTableViewCellId = "AddReminderTableViewCell"
  let reminderViewControllerId = "ReminderViewController"

//  var reminders: [String: [Task]] = ["Initial Task List":
//    [ Task(completed: false, description: "Description") ]]

  var reminders: [Reminder] = [ Reminder(title: "Initial Task List", tasks:
      [ Task(completed: false, description: "Task 1"),
        Task(completed: false, description: "Task 2") ] ) ]

  var reminderVC: ModalReminderViewController?
  var delegate: AddReminderDelegate?
  var currentIndex = 0
//  var reminderStorage: AddReminderStorage = AddReminderStorage()

  override func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return reminders.count + 1
  }

  override func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell: UITableViewCell?

      switch indexPath.row {
      case 0 where reminders.count == 0, reminders.count:
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

      return cell!

  }


  override func tableView(
    tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {
/*
      if indexPath.row == 1 {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(
     "ReminderViewController"
     )
        if let viewController = viewController as? ModalReminderViewController {
          viewController.delegate = self

          presentViewController(viewController, animated: true, completion: nil)
        }
      }
*/
      currentIndex = indexPath.row

      tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    print("prepareForSegue")
    if let viewController = segue.destinationViewController as? ModalReminderViewController {

      viewController.delegate = self

    } else if let viewController = segue.destinationViewController as?
      ReminderContainerViewController {
      viewController.reminder = reminders[currentIndex]
      
    } else {
      print("viewController is \(segue.destinationViewController)")
    }
  }

  func didReceiveReminder(reminder: Reminder?) {
    guard reminder != nil else { return }

    print("didReceiveReminder in Main")
    reminders.append(reminder!)
    tableView.reloadData()
  }

}

import UIKit
