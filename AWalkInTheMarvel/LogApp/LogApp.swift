//
//  LogApp.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 12/7/22.
//

import Foundation


enum eLevelLog: Int {
    case Verbose        = 0,
         Error,
         Debug
}


class LogApp {
    
    
    static private var mDumpToFile: Bool = false
    static private var mLevelLog: eLevelLog = .Debug
    
    
    static func setDumpToFile(_ toFile: Bool) {
        mDumpToFile = toFile
    }
    
    static func setLevelLog(_ level: eLevelLog) {
        mLevelLog = level
    }
    
    static func truncateLogFile() {
        
    }
    
    static func write(_ level: eLevelLog, content: String) {
        
        print(content)
        
        if mDumpToFile {
            if level.rawValue >= mLevelLog.rawValue {
                // tofile -->> String.write()
            }
        }
        
    }
    
}
