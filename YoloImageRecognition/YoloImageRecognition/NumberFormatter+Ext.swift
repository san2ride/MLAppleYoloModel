//
//  NumberFormatter+Ext.swift
//  YoloImageRecognition
//
//  Created by Jason Sanchez on 6/3/24.
//

import Foundation

extension NumberFormatter {
    
    static var percentage: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
