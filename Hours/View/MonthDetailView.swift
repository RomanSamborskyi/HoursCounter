//
//  MonthDetailView.swift
//  Hours
//
//  Created by Roman Samborskyi on 10.11.2023.
//

import SwiftUI



struct MonthDetailView: View {
    
    @ObservedObject var vm: HoursViewModel
    let month: MonthEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Month details")
                    .font(.title2)
                    .fontWeight(.bold)
                Image(systemName: "info.bubble.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.accentColor)
                    .font(.title2)
            }
            HStack(spacing: 75) {
                Text("Count of working days:")
                    .foregroundColor(.red.opacity(0.7))
                    .font(.caption)
                Spacer()
                if let array = month.hours?.allObjects as? [HoursEntity] {
                    let count = array.count
                    Text("\(count)")
                        .foregroundStyle(Color.red)
                }
            }
            HStack(spacing: 75) {
                Text("Total salary:")
                    .foregroundColor(.green.opacity(0.7))
                    .font(.caption)
                    Spacer()
                Text(String(format: "%.2f", vm.salaryCounter(month: month)))
                    .foregroundStyle(Color.green)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            HStack(spacing: 75) {
                Text("Total hours:")
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.7))
                Spacer()
                Text(String(format: "%.2f", vm.hoursCounter(month: month)))
                    .foregroundStyle(Color.purple)
            }
        }
    }
}

#Preview {
    MonthDetailView(vm: HoursViewModel(), month: MonthEntity.init(context: CoreDataManager.instance.context))
}
