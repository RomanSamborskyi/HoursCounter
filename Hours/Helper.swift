//
//  Helper.swift
//  Hours
//
//  Created by Roman Samborskyi on 26.10.2023.
//

import Foundation

enum Hours: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twenty_one, twentee_two, twentee_three, twenty_four
    var description: String {
        switch self {
        case .zero:
            "0"
        case .one:
            "1"
        case .two:
            "2"
        case .three:
            "3"
        case .four:
            "4"
        case .five:
            "5"
        case .six:
            "6"
        case .seven:
            "7"
        case .eight:
            "8"
        case .nine:
            "9"
        case .ten:
            "10"
        case .eleven:
            "11"
        case .twelve:
            "12"
        case .thirteen:
            "13"
        case .fourteen:
            "14"
        case .fifteen:
            "15"
        case .sixteen:
            "16"
        case .seventeen:
            "17"
        case .eighteen:
             "18"
        case .nineteen:
            "19"
        case .twenty:
            "20"
        case .twenty_one:
            "21"
        case .twentee_two:
            "22"
        case .twentee_three:
            "23"
        case .twenty_four:
            "24"
        }
    }
}

enum Minutes: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case zero, five, ten, fifteen, twentee, twentee_five, thirtee, thirtee_five, fourtee, fourtee_five, fiftee, fiftee_five
    var description: String {
        switch self {
        case .zero:
            "0"
        case .five:
            "5"
        case .ten:
            "10"
        case .fifteen:
            "15"
        case .twentee:
            "20"
        case .twentee_five:
            "25"
        case .thirtee:
            "30"
        case .thirtee_five:
            "35"
        case .fourtee:
            "40"
        case .fourtee_five:
            "45"
        case .fiftee:
            "50"
        case .fiftee_five:
            "55"
        }
    }
}

enum Pause: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case zero, five, ten, fifteen, twentee, twentee_five, thirtee, thirtee_five, fourtee, fourtee_five, fiftee, fiftee_five, one_houre
    var description: String {
        switch self {
        case .zero:
            "0"
        case .five:
            "5"
        case .ten:
            "10"
        case .fifteen:
            "15"
        case .twentee:
            "20"
        case .twentee_five:
            "25"
        case .thirtee:
            "30"
        case .thirtee_five:
            "35"
        case .fourtee:
            "40"
        case .fourtee_five:
            "45"
        case .fiftee:
            "50"
        case .fiftee_five:
            "55"
        case .one_houre:
            "60"
        }
    }
}
