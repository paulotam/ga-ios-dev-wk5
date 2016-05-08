//  Copyright © 2016 HB. All rights reserved.

struct Reminder {
  var title: String?
  var tasks: [Task] = []

  func returnTotal () -> Int {
    return tasks.count
  }

  func returnComplete () -> Int {
    var count = 0
    for task in tasks {
      print("Value is: \(task.completed) ")
      if task.completed == true {
        count = count + 1
      }
    }
    return count
  }

}

import Foundation
