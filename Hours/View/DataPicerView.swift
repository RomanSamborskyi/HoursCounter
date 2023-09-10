//
//  DataPicerView.swift
//  Hours
//
//  Created by Roman Samborskyi on 02.09.2023.
//

import SwiftUI

struct DataPicerView: View {
    
    @State private var date: Date = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select date", selection: $date, displayedComponents: .date).datePickerStyle(.compact).padding()
            
            Text("\(date)")
        }
    }
}

struct DataPicerView_Previews: PreviewProvider {
    static var previews: some View {
        DataPicerView()
    }
}
