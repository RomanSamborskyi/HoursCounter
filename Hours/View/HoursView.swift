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
    @State private var showInfo: Bool = false
    @State private var dateError: Bool = false
    @State private var date: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
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
                            }.task { self.addHours = true }
                        }
                    }
                })
        }.alert("Date in the future!", isPresented: $dateError, actions: { Text("") })
            .sheet(isPresented: $addHours, content: { 
                AddHoursView(hours: $hours, minutes: $minutes, date: $date, dateError: $dateError, showDetail: $addHours, vm: vm, month: month)
            })
            .sheet(isPresented: $showInfo, content: {
               MonthInfoView(vm: vm, month: month)
            })
            .navigationTitle(month.title ?? "")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        withAnimation(Animation.spring()) {
                            self.showInfo.toggle()
                        }
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.blue)
                    })
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        withAnimation(Animation.spring()) {
                            self.addHours.toggle()
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.blue)
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
