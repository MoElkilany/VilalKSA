//
//  Formats.swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//

import Foundation

enum Formats: String {
    case CalendarDateFormat = "yyyy-MM-dd HH:mm:ss"
    case NotificationDateFormat = "yyyy-MM-dd HH:mm:ss.ss"
    case NotificationDateValueFormat = "dd/MM/yyyy h:mm a"
    case veryLongFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case CalenderAddRequestDateFormat = "MM/dd/yyyy HH:mm:ss"
    case DateWithSlashes = "dd/MM/yyyy"
    
    case CalendarBackEndDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case AnnouncementsBackEndDateWihoutSecondsFormat = "yyyy-MM-dd'T'HH:mm"

    case JustDateFormat = "yyyy/MM/dd"
    case JustDateFormatWithDashes = "yyyy-MM-dd"
    case JustDateWithTimeFormat = "yyyy/MM/dd hh:mm a"
    case tetsFormat = "yyyy-MM-ddThh:mm:ss"
    case meetingsDateFormat = "d MMMM, h:mm a"
    case hoursAndMinute24 = "HH:mm"
    case hourAndMinutesAndSecondFormat = "hh:mm:ss"
    case minuteAndHourDateFormat = "hh:mm"
    case minuteAndHourAndMileDateFormat = "HH:mm:ss"
    case hourAndMinutesFormat = "hh:mm a"
    case hourAndMinutesFormatAA = "hh:mm aa"
    case hourDateFormat = "hh"
    case minuteDateFormat = "mm"
    case secondDateFormat = "ss"
    case monthDateFormat = "MM"
    case dayWithDateFormat = "yyyy/MM/dd EEEE"
    case yearDateFormat = "YYYY"
    case yearAndMonthDateFormat = "YYYY//MM"
    case DateWithSlashesWithtime = "MM/dd/yyyy HH:mm:ss aa"
    case yyyy_MM_dd_hh_mm_a = "yyyy-MM-dd hh:mm a"
    
    case NewsDateWithSlashes = "MM/dd/yyyy"
}
