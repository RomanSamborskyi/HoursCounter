//
//  MonthInfoView.swift
//  Hours
//
//  Created by Roman Samborskyi on 27.10.2023.
//

import SwiftUI

struct MonthInfoView: View {
    
    @ObservedObject var vm: HoursViewModel
    let month: MonthEntity
    
    var body: some View {
        VStack {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 65))
                .foregroundStyle(Color.blue)
            Text("Month details")
                .padding()
                .font(.system(size: 30, weight: .bold, design: .rounded))
            HStack(spacing: 75) {
                Text("Current month:")
                    .foregroundColor(.gray.opacity(0.7))
                    .font(.caption)
                Spacer()
                Text(month.title ?? "No title")
                    .font(.title3)
            }
            HStack(spacing: 75) {
                Text("Count of working days:")
                    .foregroundColor(.gray.opacity(0.7))
                    .font(.caption)
                Spacer()
                if let array = month.hours?.allObjects as? [HoursEntity] {
                    let count = array.count
                    Text("\(count)")
                        .font(.title3)
                }
            }
            HStack(spacing: 75) {
                Text("Total salary:")
                    .foregroundColor(.gray.opacity(0.7))
                    .font(.caption)
                    Spacer()
                Text(String(format: "%.2f", vm.salaryCounter(month: month)))
                    .font(.title3)
            }
            HStack(spacing: 75) {
                Text("Total hours:")
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.7))
                Spacer()
                Text(String(format: "%.2f", vm.hoursCounter(month: month)))
                    .font(.title3)
            }
        }.padding(25)
    }
}

#Preview {
    MonthInfoView(vm: HoursViewModel(), month: MonthEntity.init(context: CoreDataManager.instance.context))
}
