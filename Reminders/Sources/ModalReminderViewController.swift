//  Copyright © 2016 HB. All rights reserved.

protocol AddReminderDelegate {
  func didReceiveReminder(reminder: Reminder?)
}

class ModalReminderViewController: UIViewController {

  var viewController: ReminderViewController?

  @IBOutlet weak var container: UIView!
  var delegate: AddReminderDelegate?

  @IBAction func addButtonPressed(sender: AnyObject) {

    print("reminders \(viewController?.reminder?.title)")
    print("reminders \(viewController?.reminder?.tasks.count)")

    delegate?.didReceiveReminder((viewController?.reminder)!)

    dismissViewControllerAnimated(true, completion: nil)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    if let viewController = segue.destinationViewController as? ReminderViewController {
      self.viewController = viewController
    }
    super.prepareForSegue(segue, sender: sender)
  }


}

import UIKit
