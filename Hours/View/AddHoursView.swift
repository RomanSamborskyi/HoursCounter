//
//  AddHoursView.swift
//  Hours
//
//  Created by Roman Samborskyi on 26.10.2023.
//

import SwiftUI

struct AddHoursView: View {
    
    @State private var startHours: Hours = .zero
    @State private var startMinutes: Minutes = .zero
    @State private var endHours: Hours = .zero
    @State private var endMinutes: Minutes = .zero
    @State private var pauseTime: Pause = .zero
    @Binding var hours: String
    @Binding var minutes: String
    @Binding var date: Date
    @Binding var dateError: Bool
    @Binding var showDetail: Bool
    @ObservedObject var vm: HoursViewModel
    let month: MonthEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(spacing: 35) {
                    Text("Total salary:")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(.caption)
                        .frame(width: 140)
                    Text(String(format: "%.2f", vm.salaryCounter(month: month)))
                        .font(.title3)
                }
                HStack(spacing: 35) {
                    Text("Total hours:")
                        .font(.caption)
                        .foregroundColor(.gray.opacity(0.7))
                        .frame(width: 140)
                    Text(String(format: "%.2f", vm.hoursCounter(month: month)))
                        .font(.title3)
                }
            }.padding(.leading)
            HStack {
                Text("Start work at:")
                    .frame(width: 140)
                Picker("Hours", selection: $startHours, content: {
                    ForEach(Hours.allCases) { hour in
                        Text(hour.description)
                            .tag(hour.description)
                    }
                }).pickerStyle(.menu)
                Picker("Minutes", selection: $startMinutes, content: {
                    ForEach(Minutes.allCases) { minute in
                        Text(minute.description)
                            .tag(minute.description)
                    }
                }).pickerStyle(.menu)
            }
            HStack {
             Text("End work at:")
                    .frame(width: 140)
                Picker("Hours", selection: $endHours, content: {
                    ForEach(Hours.allCases) { hour in
                        Text(hour.description)
                            .tag(hour.description)
                    }
                }).pickerStyle(.menu)
                Picker("Minutes", selection: $endMinutes, content: {
                    ForEach(Minutes.allCases) { minute in
                        Text(minute.description)
                            .tag(minute.description)
                    }
                }).pickerStyle(.menu)
            }
            HStack {
             Text("Pause time:")
                    .frame(width: 140)
                Picker("Hours", selection: $pauseTime, content: {
                    ForEach(Pause.allCases) { minute in
                        Text(minute.description)
                            .tag(minute.description)
                    }
                }).pickerStyle(.menu)
            }
            HStack {
                Text("Date:")
                       .frame(width: 150)
                DatePicker("", selection: $date, displayedComponents: .date)
            }
            Button(action: {
                withAnimation(Animation.spring()) {
                    if !(date > Date()) {
                        vm.countWorkHours(starHours: startHours.description, startMinutes: startMinutes.description, endHours: endHours.description, endMinutes: endMinutes.description, pause: pauseTime.description, hours: &hours, minutes: &minutes)
                        vm.addHours(hours: Int64(hours) ?? 0, minutes: Int64(minutes) ?? 0, date: date, month: month)
                        hours = ""
                        minutes = ""
                        startHours = .zero
                        startMinutes = .zero
                        endHours = .zero
                        endMinutes = .zero
                        pauseTime = .zero
                        date = Date()
                        showDetail = false
                    } else {
                        self.dateError = true
                    }
                }
            }, label: {
                Image(systemName: "plus.app")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(startHours == .zero || date >= Date() ? Color.blue.opacity(0.5) : Color.blue)
                    .cornerRadius(10)
            })
            .disabled(startHours == .zero)
            .padding()
          Spacer()
        }.padding()
    }
}

