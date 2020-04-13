//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

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
