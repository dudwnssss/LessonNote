//
//  LessonBottomSheetViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/13.
//

import Foundation

final class LessonBottomSheetViewModel {
    var weekDays: Observable<[Weekday]> = Observable([])

}

extension LessonBottomSheetViewModel {
    func appendWeekday(tag: Int){
        guard let weekday = Weekday(rawValue: tag) else { return }
        if weekDays.value.contains(weekday) {
            weekDays.value.removeAll(where: {
                $0 == weekday
            })
        } else {
            weekDays.value.append(weekday)
        }
    }
}
