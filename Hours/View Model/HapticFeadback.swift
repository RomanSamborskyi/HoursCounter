//
//  HapticFeadback.swift
//  Hours
//
//  Created by Roman Samborskyi on 11.11.2023.
//

import Foundation
import UIKit

class HapticFeadback {
    static let instance = HapticFeadback()
    
    func success(feadback: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(feadback)
    }
    func makeClik(feadbak: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generetor = UIImpactFeedbackGenerator(style: feadbak)
        generetor.impactOccurred()
    }
}
