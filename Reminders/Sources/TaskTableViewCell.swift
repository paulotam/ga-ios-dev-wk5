//  Copyright © 2016 HB. All rights reserved.

protocol addTask {
  func add(task: Task?)
}

protocol updateTask {
  func update(indexPath: NSIndexPath, task: Task?)
}

class TaskTableViewCell: UITableViewCell {
  //  class TaskTableViewCell: UITableViewCell, UITextFieldDelegate {

  var completed = false
//  var delegate = addTask?

  @IBOutlet weak var radioButton: UIButton!
  @IBOutlet weak var descriptionField: UITextField!

//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    descriptionField.delegate = self
//  }

  @IBAction func radioButtonPressed(sender: AnyObject) {
    if let button = sender as? UIButton {
      button.setImage(
        UIImage(named: completed ? "radio-off" : "radio-on"),
        forState: .Normal)
      completed = !completed
    }
  }

  func setButton(status: Bool) {
    radioButton.setImage(
      UIImage(named: completed ? "radio-on" : "radio-off"),
      forState: .Normal)
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

}

import UIKit
