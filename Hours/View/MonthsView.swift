//
//  MonthsView.swift
//  Hours
//
//  Created by Roman Samborskyi on 16.08.2023.
//

import SwiftUI

struct MonthsView: View {
    
    @StateObject var vm = HoursViewModel()
    @State private var addMonth: Bool = false
    @State private var addMonthDetents: PresentationDetent = .fraction(0.2)
    let date: Date = Date()
    var dateFormater: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        return formater
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Months") {
                    ForEach(vm.months) { month in
                        NavigationLink(destination: { HoursView(month: month, vm: vm) }, label: {
                            HStack(spacing:15) {
                                Text(month.title ?? "NO TITLE")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                                Spacer()
                                Text("total hours:")
                                    .font(.caption2)
                                    .foregroundColor(.gray.opacity(0.7))
                                Text(String(format: "%.2f", vm.hoursCounter(month: month)))
                                    .frame(width: 70)
                            }
                        })
                    }.onDelete(perform: vm.deleteMonth)
                }
            }.overlay(alignment: .center, content: {
                if vm.months.isEmpty {
                    VStack{
                        Image(systemName: "list.bullet")
                            .padding()
                            .font(.title)
                        Text("The list is empty")
                            .padding()
                            .font(.title)
                    }
                }
            })
            .sheet(isPresented: $addMonth, content: { AddMonths(vm: vm).presentationDetents([.fraction(0.5)], selection: $addMonthDetents)})
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(Animation.spring()) {
                            self.addMonth.toggle()
                            HapticFeadback.instance.makeClik(feadbak: .soft)
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    })
                }
            }
            .navigationTitle("\(dateFormater.string(from: date))")
        }
    }
}

struct MonthsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthsView()
    }
}

struct AddMonths: View {
    
    @ObservedObject var vm: HoursViewModel
    @State private var startonth: Monthes = .empty
    @Environment(\.dismiss) var dismiss
    var dateFormater: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.dateFormat = "YYYY"
        return formater
    }
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 65))
                .foregroundStyle(Color.accentColor)
            Text("Add month")
                .padding()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            HStack {
                Picker("Months", selection: $startonth, content: {
                    ForEach(Monthes.allCases) { month in
                        Text(month.description)
                    }
                }).pickerStyle(.wheel)
                Button(action: {
                    vm.addMonth(title: startonth.description + " " + dateFormater.string(from: Date()))
                    dismiss()
                    HapticFeadback.instance.success(feadback: .success)
                }, label: {
                    HStack {
                        Text("Add")
                            .foregroundColor(.white)
                        Image(systemName: "plus.app")
                            .foregroundColor(.white)
                    }.padding()
                        .frame(maxWidth: .infinity)
                        .background(startonth == .empty ? Color.accentColor.opacity(0.5) : Color.accentColor)
                        .cornerRadius(10)
                }).disabled(startonth == .empty)
            }.padding()
        }.padding(15)
    }
}
