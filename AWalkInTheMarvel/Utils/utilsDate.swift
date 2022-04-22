//
//  utilsDate.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 22/4/22.
//

import UIKit

class UtilsDate {
    
    static func dateFromString(dateToConverter: String) -> Date? {
                 
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" + "z"
        
        let valRet: Date? = dateFormatter.date(from: dateToConverter)

        return valRet
    }
    
    static func dateToFormat(dateToConvert: Date, format: String) -> String {
        var strOut: String = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        strOut = formatter.string(from: dateToConvert)
        
        return strOut
    }
    
    static func dateFromStringToFormat(dateToConvert: String, formatDate: String) -> String {
        var retValue: String = ""
        
        if let date: Date = dateFromString(dateToConverter: dateToConvert) {
            retValue = dateToFormat(dateToConvert: date, format: formatDate)
        }
        
        return retValue
    }
    
}
