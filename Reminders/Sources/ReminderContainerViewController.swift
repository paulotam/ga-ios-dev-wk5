//
//  ReminderContainerViewController.swift
//  Reminders
//
//  Created by Paulo Tam on 8/05/2016.
//  Copyright © 2016 HB. All rights reserved.
//

class ReminderContainerViewController: UIViewController {

  var reminder: Reminder?
  var viewController: ReminderViewController?

  convenience init() {
    self.init()
    print("There are \(reminder!.tasks.count) Tasks in Reminders: \(reminder!.title)")
  }

  @IBAction func deleteButton(sender: AnyObject) {
    print("delete")
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    print("ReminderContainerViewController viewController is \(segue.destinationViewController)")
    if let viewController = segue.destinationViewController as? ReminderViewController {
//      self.viewController = viewController
      print("Passing: \(reminder!.title)")
      viewController.reminder = reminder
    }
    super.prepareForSegue(segue, sender: sender)
  }
}

import UIKit
