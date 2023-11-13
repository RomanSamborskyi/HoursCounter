//
//  HoursView.swift
//  Hours
//
//  Created by Roman Samborskyi on 16.08.2023.
//

import SwiftUI

struct HoursView: View {
    
    var dateFormater: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        return formater
    }
    var month: MonthEntity
    @ObservedObject var vm: HoursViewModel
    @State private var hours: String = ""
    @State private var minutes: String = ""
    @State private var addHours: Bool = false
    @State private var dateError: Bool = false
    @State private var date: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                if let array = month.hours?.allObjects as? [HoursEntity] {
                    if !array.isEmpty {
                        Section {
                            MonthDetailView(vm: vm, month: month)
                        }
                    }
                }
                ForEach(vm.getHours(month: month)){ hours in
                    HStack{
                        Text(dateFormater.string(from: hours.date ?? Date()))
                        Spacer()
                        Text("\(hours.hours).\(hours.minutes)")
                    }.contextMenu {
                        Button(role: .destructive, action: { vm.deleteHours(month: month, hour: hours) }, label: {
                            Label("Delete", systemImage: "trash")
                        })
                    }
                }
            }.overlay(alignment: .center, content: {
                if let array = month.hours?.allObjects as? [HoursEntity] {
                    if array.isEmpty {
                        VStack {
                            Image(systemName: "list.bullet")
                                .padding()
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                            Text("The list is empty")
                                .padding()
                                .font(.system(size: 30, weight: .medium, design: .rounded))
                        }.task { self.addHours = false }
                    }
                }
            })
        }.sheet(isPresented: $addHours, content: {
            AddHoursView(dateError: $dateError, hours: $hours, minutes: $minutes, date: $date, showDetail: $addHours, vm: vm, month: month)
                .alert("Date in the future!", isPresented: $dateError, actions: {  })
        })
        .navigationTitle(month.title ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    withAnimation(Animation.spring()) {
                        HapticFeadback.instance.makeClik(feadbak: .soft)
                        self.addHours.toggle()
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.accentColor)
                })
            })
        }
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView(month: MonthEntity.init(context: CoreDataManager.instance.context), vm: HoursViewModel())
    }
}
