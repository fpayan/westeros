//
//  DateExtensions.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 27/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import Foundation

extension Date {
    
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
}


