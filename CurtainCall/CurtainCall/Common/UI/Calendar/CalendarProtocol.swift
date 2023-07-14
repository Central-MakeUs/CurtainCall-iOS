//
//  CalendarProtocol.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/14.
//

import Foundation

protocol CalendarDelegate: AnyObject {
    var delegate: CalendarViewDelegate? { get set }
}

protocol CalendarViewDelegate: AnyObject {
    func selectedCalendar(date: Date)
}
