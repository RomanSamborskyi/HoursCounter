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
        VStack(alignment: .trailing) {
            HStack(spacing: 90) {
                Text("Today, \(dateFormater.string(from: date))")
                Button(action: {
                    withAnimation(Animation.spring()) {
                        self.addMonth.toggle()
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                })
            }.padding(15)
            List {
                ForEach(vm.months) { month in
                  NavigationLink(destination: { HoursView(month: month, vm: vm) }, label: {
                      HStack(spacing:15) {
                          Text(month.title ?? "NO TITLE")
                          Spacer()
                          Text("total hours:")
                              .font(.caption2)
                              .foregroundColor(.gray.opacity(0.7))
                          Text(String(format: "%.2f", vm.hoursCounter(month: month)))
                      }
                  })
                }.onDelete(perform: vm.deleteMonth)
            }
        }.sheet(isPresented: $addMonth, content: { AddMonths(vm: vm).presentationDetents([.medium, .fraction(0.2)], selection: $addMonthDetents)})
    }
}

struct MonthsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthsView()
    }
}

struct AddMonths: View {
    
    @ObservedObject var vm: HoursViewModel
    @State private var textFieldText: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                TextField("Month", text: $textFieldText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                Button(action: {
                    vm.addMonth(title: textFieldText)
                    dismiss()
                }, label: {
                    HStack {
                        Text("Add")
                            .foregroundColor(.white)
                        Image(systemName: "plus.app")
                            .foregroundColor(.white)
                    }.padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }.padding()
        }
    }
}
