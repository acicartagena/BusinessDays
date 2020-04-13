//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

typealias Year = Int

enum Weekday: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

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

enum NSWHoliday: CaseIterable {
    case newYear
    case australiaDay
    case anzacDay
    case queensBirthday
    case labourDay
    case christmasDay
    case boxingDay

    var holidayType: HolidayType {
        switch self {
        case .newYear: return .sameDateOrNextWeekday(HolidayDate(month: .january, day: 1))
        case .australiaDay: return .sameDateOrNextWeekday(HolidayDate(month: .january, day: 26))
        case .anzacDay: return .sameDate(HolidayDate(month: .april, day: 25))
        case .queensBirthday: return .dayInAMonth(HolidayDayInMonth(month: .june, weekday: .monday, weekdayOrdinal: 2))
        case .labourDay: return .dayInAMonth(HolidayDayInMonth(month: .october, weekday: .monday, weekdayOrdinal: 1))
        case .christmasDay: return .sameDateOrNextWeekday(HolidayDate(month: .december, day: 25))
        case .boxingDay: return .sameDateOrNextWeekday(HolidayDate(month: .december, day: 26))
        }
    }
}
