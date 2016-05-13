//
//  Reminder.swift
//  Reminders
//
//  Created by Anton Wintergerst on 11/05/2016.
//  Copyright © 2016 Anton Wintergerst. All rights reserved.
//

import Foundation

// MARK: Reminder data structure definition
class Reminder {
  var title: String?
  var tasks: [Task] = []

  func returnTotal () -> Int {
    return tasks.count
  }

  func returnComplete () -> Int {
    var count = 0
    for task in tasks {
      if task.completed == true {
        count = count + 1
      }
    }
    return count
  }

}
