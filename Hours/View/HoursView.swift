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
                    Image(systemName: "arrowtriangle.right.circle")
                        .padding()
                        .font(.title2)
                        .foregroundColor(Color.blue)
                        .rotationEffect(Angle(degrees:showDetails ? 90 : 0))
                        .scaleEffect(showDetails ? 1.12 : 1.0)
                })
            }.padding(.leading)
            if showDetails {
                VStack(alignment: .leading) {
                    HStack(spacing: 35) {
                        Text("Total salary:")
                            .foregroundColor(.gray.opacity(0.7))
                            .font(.caption)
                        Text(String(format: "%.2f", vm.salaryCounter(month: month)))
                            .font(.title3)
                    }
                    HStack(spacing: 35) {
                        Text("Total hours:")
                            .font(.caption)
                            .foregroundColor(.gray.opacity(0.7))
                        Text(String(format: "%.2f", vm.hoursCounter(month: month)))
                            .font(.title3)
                    }
                }.padding(.leading)
                HStack {
                    TextField("Hours", text: $hours)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                    TextField("Minutes", text: $minutes)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }.padding(.horizontal)
                Button(action: {
                    withAnimation(Animation.spring()) {
                        vm.addHours(hours: Int64(hours) ?? 0, minutes: Int64(minutes) ?? 0, month: month)
                        hours = ""
                        minutes = ""
                    }
                }, label: {
                    HStack {
                        Text("Save")
                            .foregroundColor(.white)
                        Image(systemName: "plus.app")
                            .foregroundColor(.white)
                    }.padding()
                        .frame(maxWidth: .infinity)
                        .background(hours.isEmpty ? Color.blue.opacity(0.5) : Color.blue)
                        .cornerRadius(10)
                }).padding()
                    .disabled(hours.isEmpty)
            }
            List {
                ForEach(vm.getHours(month: month)){ hours in
                    HStack{
                        Text(dateFormater.string(from: hours.date ?? Date()))
                        Spacer()
                        Text("\(hours.hours).\(hours.minutes)")
                    }
                }.onDelete { indexSet in
                    vm.deleteHours(indexSet: indexSet, month: month)
                }
            }.listStyle(.plain)
        }.padding()
            .padding(.top, -25)
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView(month: MonthEntity.init(context: CoreDataManager.instance.context), vm: HoursViewModel())
    }
}
