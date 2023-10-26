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
    @State private var showDetails: Bool = false
    @State private var dateError: Bool = false
    @State private var date: Date = Date()
    @Binding var ddMonthDetents: PresentationDetent
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Text(month.title ?? "")
                    .font(.title2)
                
                Button(action: {
                    withAnimation(Animation.spring()) {
                        self.showDetails.toggle()
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .padding()
                        .font(.title2)
                        .foregroundColor(Color.blue)
                        .rotationEffect(Angle(degrees:showDetails ? 90 : 0))
                        .scaleEffect(showDetails ? 1.12 : 1.0)
                })
            }.padding(.leading)
            
//                VStack(alignment: .leading) {
//                    HStack(spacing: 35) {
//                        Text("Total salary:")
//                            .foregroundColor(.gray.opacity(0.7))
//                            .font(.caption)
//                        Text(String(format: "%.2f", vm.salaryCounter(month: month)))
//                            .font(.title3)
//                    }
//                    HStack(spacing: 35) {
//                        Text("Total hours:")
//                            .font(.caption)
//                            .foregroundColor(.gray.opacity(0.7))
//                        Text(String(format: "%.2f", vm.hoursCounter(month: month)))
//                            .font(.title3)
//                    }
//                }.padding(.leading)
//                HStack {
//                    TextField("Hours", text: $hours)
//                        .padding()
//                        .frame(width: 80,height: 50)
//                        .background(Color.gray.opacity(0.4))
//                        .cornerRadius(10)
//                        .keyboardType(.numberPad)
//                        .focused($isFocused)
//                    TextField("Minutes", text: $minutes)
//                        .padding()
//                        .frame(width: 80,height: 50)
//                        .background(Color.gray.opacity(0.4))
//                        .cornerRadius(10)
//                        .keyboardType(.numberPad)
//                        .focused($isFocused)
//                    DatePicker("", selection: $date, displayedComponents: .date)
//                }.padding(.horizontal)
//                Button(action: {
//                    withAnimation(Animation.spring()) {
//                        if !(date > Date()) {
//                            vm.addHours(hours: Int64(hours) ?? 0, minutes: Int64(minutes) ?? 0, date: date, month: month)
//                            hours = ""
//                            minutes = ""
//                            date = Date()
//                            isFocused = false
//                        } else {
//                            self.dateError = true
//                        }
//                    }
//                }, label: {
//                    Image(systemName: "plus.app")
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 50)
//                        .background(hours.isEmpty || date >= Date() ? Color.blue.opacity(0.5) : Color.blue)
//                        .cornerRadius(10)
//                })
//                .disabled(hours.isEmpty)
//                .padding()
                
            
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
                            }.task { self.showDetails = true }
                        }
                    }
                })
        }.padding()
            .padding(.top, -40)
            .alert("Date in the future!", isPresented: $dateError, actions: { Text("") })
            .sheet(isPresented: $showDetails, content: {
                AddHoursView(hours: $hours, minutes: $minutes, date: $date, dateError: $dateError, showDetail: $showDetails, vm: vm, month: month).presentationDetents([.fraction(0.6)], selection: $ddMonthDetents)
            })
    }
}

//struct HoursView_Previews: PreviewProvider {
//    static var previews: some View {
//        HoursView(month: MonthEntity.init(context: CoreDataManager.instance.context), vm: HoursViewModel(), ddMonthDetents: <#Binding<PresentationDetent>#>)
//    }
//}
