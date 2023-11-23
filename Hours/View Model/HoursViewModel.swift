//
//  HoursViewModel.swift
//  Hours
//
//  Created by Roman Samborskyi on 16.08.2023.
//

import Foundation
import CoreData


class HoursViewModel: ObservableObject {
    
    let coreData = CoreDataManager.instance
    
    @Published var months: [MonthEntity] = []
    
    init() {
        getMonths()
    }
    
    func getHours(month: MonthEntity) -> [HoursEntity] {
        
        let request = NSFetchRequest<HoursEntity>(entityName: coreData.hoursEntityName)
        request.sortDescriptors = [ NSSortDescriptor(keyPath: \HoursEntity.date, ascending: false)]
        request.predicate = NSPredicate(format: "month == %@", month)
        
        do {
            return try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching hours: \(error)")
            return []
        }
    }
    
    
    func salaryCounter(month: MonthEntity) -> Double {
        let hours = getHours(month: month)
        var countedHours: [Int64] = []
        var salary: Double = 0
        for items in hours {
            let minutes = (items.hours * 60) + items.minutes
            countedHours.append(minutes)
        }
        let houerSalary = UserDefaults.standard.integer(forKey: "salaryPerHour")
        salary = Double(countedHours.reduce(0,+)) * (Double(houerSalary) / 60)
        return salary
    }
    
    func hoursCounter(month: MonthEntity) -> Double {
        let hours = getHours(month: month)
        var totalHours: Double = 0
        var countedHours: [Int64] = []
        for item in hours {
            let minutes = (item.hours * 60) + item.minutes
            countedHours.append(minutes)
        }
        totalHours = Double(countedHours.reduce(0, +)) / 60
        return totalHours
    }
    
    func getMonths() {
        let request = NSFetchRequest<MonthEntity>(entityName: coreData.monthEntityName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MonthEntity.date, ascending: false)]
        
        do {
           months = try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching months: \(error)")
        }
    }
    
    func addMonth(title: String) {
        let newItem = MonthEntity(context: coreData.context)
        newItem.title = title
        newItem.date = Date()
        save()
    }
    
    func addHours(hours: Int64, minutes: Int64, date: Date, month: MonthEntity,startHours: Int64, startMinutes: Int64, endHours: Int64, endMinutes: Int64, pauseTime: Int64, note: String) {
        let newData = HoursEntity(context: coreData.context)
        newData.hours = hours
        newData.minutes = minutes
        newData.date = date
        newData.month = month
        newData.startHours = startHours
        newData.startMinutes = startMinutes
        newData.endHours = endHours
        newData.endMinutes = endMinutes
        newData.pauseTime = pauseTime
        newData.note = note
        save()
    }
    
    func deleteMonth(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let deletedItem = months[index]
        coreData.context.delete(deletedItem)
        save()
    }
    
    func deleteHours(month: MonthEntity, hour: HoursEntity) {
        guard let arrayOfHours = month.hours?.allObjects as? [HoursEntity] else { return }
        guard let index = arrayOfHours.firstIndex(of: hour) else { return }
        let deletedItem = arrayOfHours[index]
        coreData.context.delete(deletedItem)
        save()
    }
    
    func editHours(indexSet: IndexSet, month: MonthEntity, hours: Int64, minutes: Int64) {
        guard let index = indexSet.first else { return }
        guard let arrayOfHours = month.hours?.allObjects as? [HoursEntity] else { return }
        let editItem = arrayOfHours[index]
        editItem.hours = hours
        editItem.minutes = minutes
        save()
    }
    
    func returnUserName() -> String {
        return UserDefaults.standard.string(forKey: "userName") ?? "No name"
    }
    
    func countWorkHours(starHours: String, startMinutes: String, endHours: String, endMinutes: String, pause: String, hours: inout String, minutes: inout String) {
        let startWorkMinutes = ((Int64(starHours) ?? 0) * 60) + (Int64(startMinutes) ?? 0)
        let endWorkMinutes = ((Int64(endHours) ?? 0) * 60) + (Int64(endMinutes) ?? 0)
        let totalMinutesPerDay = endWorkMinutes - startWorkMinutes - (Int64(pause) ?? 0)
        let total = Double(totalMinutesPerDay) / 60
        let leftSide = Int(total)
        let rightSide = total - Double(leftSide)
        var finalMinutes: String = ""
        
        //MARK: Add another cases 
        switch rightSide {
        case 0.25:
            finalMinutes = "15"
        case 0.50:
            finalMinutes = "30"
        case 0.75:
            finalMinutes = "45"
        default:
            finalMinutes = "0"
        }
        
        hours = String(leftSide)
        minutes = finalMinutes
    }
    
    func save() {
        do {
            try coreData.context.save()
            getMonths()
        } catch let error {
            print("Error of saving from VM: \(error)")
        }
    }
}
 
