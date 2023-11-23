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
            Image(systemName: "doc.fill.badge.ellipsis")
                .font(.system(size: 65))
                .foregroundStyle(Color.accentColor)
            Text("Detaile of the day:")
                .padding()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            Text(dateFormater.string(from: hours.date ?? Date()).capitalized)
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
                    Text("\(hours.startHours)")
                    
                }.frame(width: 45)
                VStack {
                    Text("minutes")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(.caption2)
                    Text("\(hours.startMinutes)")
                }.frame(width: 45)
            }
            HStack {
                Text("End work at:")
                Spacer()
                VStack {
                    Text("\(hours.endHours)")
                }.frame(width: 45)
                VStack {
                    Text("\(hours.endMinutes)")
                }.frame(width: 45)
            }
            HStack {
                Text("Pause time:")
                Spacer()
                Text("\(hours.pauseTime)")
                    .frame(width: 45)
            }
            HStack {
                Text("Hours today:")
                Spacer()
                Text("\(hours.hours).\(hours.minutes)")
                    .frame(width: 45)
            }
            if hours.hours >= 9 {
                HStack {
                    Text("Nice work, keep it up")
                    Image(systemName: "checkmark.seal.fill")
                } .padding()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                HStack {
                    Text("You can do better")
                    Spacer()
                    Image(systemName: "figure.strengthtraining.traditional")
                }.padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            Spacer()
        }.padding(25)
    }
}
