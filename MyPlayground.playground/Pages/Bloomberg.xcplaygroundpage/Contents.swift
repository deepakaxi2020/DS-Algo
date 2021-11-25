//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class WorkingHours: Equatable {
    var startTime: Int
    var endTime: Int
    init(start: Int, end: Int) {
        self.startTime = start
        self.endTime = end
    }

    static func == (lhs: WorkingHours, rhs: WorkingHours) -> Bool {
        return lhs.startTime == rhs.startTime &&
        lhs.endTime == rhs.endTime
    }
}


var input: [WorkingHours] = [
                            WorkingHours(start: 9, end: 14),
                            WorkingHours(start: 9, end: 20),
                            WorkingHours(start: 12, end: 16),
                            WorkingHours(start: 7, end: 8)
                            ]

@discardableResult func isValidTransaction(input: [WorkingHours] , transaction: WorkingHours) -> Bool {

    // BASE CONDITIONS
    if input.isEmpty { return false }

    // add first item in distinctWorkingHours array
    var distinctWorkingHours: [WorkingHours] = [input.first!]

    // if anything not yet added to distinct working hours then no need to check anything.

    for i in 1..<input.count {
        let workingHour = input[i]
        var workingHourAdjusted = false
        // if anything not yet added to distinct working hours then no need to check anything.
        for j in 0..<distinctWorkingHours.count {
            let dWorkingHours = distinctWorkingHours[j]

            // if new working hours is inside existing slot
            if workingHour.startTime >= dWorkingHours.startTime && workingHour.endTime <= dWorkingHours.endTime {
                workingHourAdjusted = true
            }
            // if new working hours starts before current time and ends after current time
            else if workingHour.startTime <= dWorkingHours.startTime && workingHour.endTime >= dWorkingHours.endTime {
                dWorkingHours.startTime = workingHour.startTime
                dWorkingHours.endTime = workingHour.endTime
                distinctWorkingHours[j] = dWorkingHours
                workingHourAdjusted = true
            }
            // if working hours starts before existing and ends b/w existing hours
            else if workingHour.startTime <= dWorkingHours.startTime
                        && workingHour.endTime >= dWorkingHours.startTime
                        && workingHour.endTime <= dWorkingHours.endTime {
                dWorkingHours.startTime = workingHour.startTime
                distinctWorkingHours[j] = dWorkingHours
                workingHourAdjusted = true
            }
            // if working hours starts b/w exiting working hours and ends after existing working hours
            else if workingHour.startTime >= dWorkingHours.startTime
                        && workingHour.endTime >= dWorkingHours.endTime {
                dWorkingHours.endTime = workingHour.endTime
                distinctWorkingHours[j] = dWorkingHours
                workingHourAdjusted = true
            }

            // if new working hours adjusted then break the loop and check for next working hours
            if workingHourAdjusted {
                break
            }
        }

        if !workingHourAdjusted {
            distinctWorkingHours.append(workingHour)
        }
    }

    for wk in distinctWorkingHours {
        print("🕰 Working Hours : \(wk.startTime) - \(wk.endTime)")
    }

    var isValidTransaction = false
    for wk in distinctWorkingHours {
        if transaction.startTime >= wk.startTime
            && transaction.endTime <= wk.endTime {
            print("✅ SUCCESS: Transaction \(transaction.startTime) - \(transaction.endTime) is valid inside working Hours \(wk.startTime) - \(wk.endTime)")
            isValidTransaction = true
            break
        }
    }
    if !isValidTransaction { print("❌ FAILURE: Transaction \(transaction.startTime) - \(transaction.endTime) is not valid inside working Hours.\n\n")}
    return isValidTransaction
}

isValidTransaction(input: input, transaction: WorkingHours(start: 10, end: 2))
isValidTransaction(input: input, transaction: WorkingHours(start: 1, end: 2))
isValidTransaction(input: input, transaction: WorkingHours(start: 9, end: 19))
isValidTransaction(input: input, transaction: WorkingHours(start: 3, end: 9))
isValidTransaction(input: input, transaction: WorkingHours(start: 10, end: 20))

