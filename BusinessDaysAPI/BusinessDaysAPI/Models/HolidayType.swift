//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

typealias Year = Int

// weekday date component type is defined based on the gregorian calendar
enum Weekday: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

// month date component type is defined based on the gregorian calendar
enum Month: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}

struct HolidayDate {
    let month: Month
    let day: Int

    func date(calendar: Calendar, year: Year) -> Date? {
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month.rawValue, day: day)
        return dateComponents.date
    }
}

struct HolidayDayInMonth {
    let month: Month
    let weekday: Weekday
    let weekdayOrdinal: Int

    func date(calendar: Calendar, year: Year) -> Date? {
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month.rawValue, weekday: weekday.rawValue, weekdayOrdinal: weekdayOrdinal)
        return dateComponents.date
    }
}

enum HolidayType {
    case sameDate(HolidayDate)
    case sameDateOrNextWeekday(HolidayDate)
    case dayInAMonth(HolidayDayInMonth)
}
