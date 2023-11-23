//
//  DayDetaliView.swift
//  Hours
//
//  Created by Roman Samborskyi on 23.11.2023.
//

import SwiftUI

struct DayDetaliView: View {
    
    @ObservedObject var vm: HoursViewModel
    let hours: HoursEntity
    var dateFormater: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .full
        return formater
    }
    var body: some View {
        VStack {
            Image(systemName: "box.truck.badge.clock.fill")
                .font(.system(size: 65))
                .foregroundStyle(Color.accentColor)
            Text("Detaile of the day:")
                .padding()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            Text(dateFormater.string(from: hours.date ?? Date()))
                .padding(.bottom)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            HStack(alignment: .bottom) {
                Text("Start work at:")
                    Spacer()
                VStack {
                    Text("hour")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(.caption2)
                    Text("\(hours.startHours?.startHours ?? 0)")
                
                }
                VStack {
                    Text("minutes")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(.caption2)
                   Text("\(hours.startHours?.startMinutes ?? 0)")
                }
            }
            HStack {
             Text("End work at:")
                   Spacer()
                Text("\(hours.startHours?.endHours ?? 0)")
                Text("\(hours.startHours?.endMinutes ?? 0)")
            }
            HStack {
             Text("Pause start:")
                   Spacer()
                Text("\(hours.startHours?.startPauseHours ?? 0)")
                Text("\(hours.startHours?.startPauseMinutes ?? 0)")
            }
            HStack {
             Text("Pause end:")
                   Spacer()
                Text("\(hours.startHours?.endPauseHours ?? 0)")
                Text("\(hours.startHours?.endPauseMinutes ?? 0)")
            }
            HStack {
                Text("Hours today:")
                       Spacer()
                Text("\(hours.hours).\(hours.minutes)")
            }
          Spacer()
        }.padding(25)
    }
}
