# Reminders Assigment

## Updated by Paulo Tam.

I am able capture user inputs in th screens and initialize their values.
I am able to pass this back to the main screen.
I am able to pass it back to the reminder screen.
And I can delete reminders and Tasks in a reminder.

Things that I note:

When update of a task in an existing screen, I pass the reminder back immediately.
When i am in the add, i only pass it when its complete, I think this causes an issue.
There was a bug where you add two tasks to a new reminder, and then type in first and
type in second it wouldn't save, so i added a force save on begin that if its different
to save it.

## Goals

1. Understand how to save user data between screens.
2. Improve understanding of Protocols in Swift.
3. Practice coding in an existing project.

## Objective

Complete the Reminders App by passing user data between screens.

## Deliverables

1. Use a data structures to represent underlying view models.
2. Use delegation design pattern to pass data between different views.

## Part 1
Capture user inputs in Reminder Detail Screen, create appropriate data models, and initialize their values properly.

## Part 2
Pass the created data models from Part 1 to Main Screen. Make sure it is captured by the table data source, present the newly captured data on the screen.

## Part 3
Pass the captured data from Main Screen to Reminder detail screen. This should allow the user to view what they have entered.

## Bonus
Allow the users to delete the reminders from the Reminder detail screen.