import Foundation
import RealmSwift

final class ScheduleViewModel{
    
    private let repository = StudentRepository()
    private var studentResults: Results<Student>! // realm기반, 변경 시 list에 값 전달
    private var notificationToken: NotificationToken?
    
    var daysOfWeek = DateManager.shared.getDatesForWeek(numberOfWeeksFromThisWeek: 0)
    
    var weekSchedules: Observable<[[ElliottEvent]]> = Observable([])
    
    private var yearlyLessonSchedules: [Student: [[Bool]]] = [:]
    
    init(){
        studentResults = repository.fetch()
        setSchedule(weeks: 8)
        notificationToken = studentResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self?.weekSchedules.value.removeAll()
                self?.setSchedule(weeks: 8)
                break
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    func createYearlyLessonSchedule(student: Student) -> [Date]{
        let weekdays = student.lessonSchedules.map { $0.weekday }
        let weekCount = student.weekCount
        let startWeekday = student.startWeekday
        let startDate = student.lessonStartDate
        let weekdaysArray = Array(weekdays)
        let dates = DateManager.shared.generateYearlyLessonSchedule(weekday: weekdaysArray, weekCount: weekCount, startWeekday: startWeekday, startDate: startDate!)
        return dates
    }
    
    func setCourseItems(weeks: Int) -> [Student: [[Bool]]] {
        var resultsDict: [Student: [[Bool]]] = [:]
        studentResults.forEach { student in
            var yearlyLessonSchedule = createYearlyLessonSchedule(student: student)
            yearlyLessonSchedule.sort()
            let yearlyLessonExists = DateManager.shared.generateWeeksArray(from: yearlyLessonSchedule, numberOfWeeks: weeks)
            resultsDict[student] = yearlyLessonExists
        }
        return resultsDict
    }
    
    func setSchedule(weeks: Int){
        let LessonExists: [Student: [[Bool]]] = setCourseItems(weeks: weeks)
        for i in 0 ..< weeks {
            var weekSchedule: [ElliottEvent] = []
            LessonExists.forEach { key, value in
                weekSchedule.append(contentsOf: key.toElliotEvent(visibiliyList: value[i]))
            }
            weekSchedules.value.append(weekSchedule)
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
}
