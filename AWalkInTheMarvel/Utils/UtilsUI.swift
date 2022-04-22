//
//  UtilsUI.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 23/4/22.
//

import Foundation

class UtilsUI {
    
    static private let instanceWaitScreen: WaitScreen = WaitScreen.getInstance()
    
    // MARK: Show Wait Control
    static func showWaitControl(wait_title: String, max_seconds: Double = 60.0) {
        instanceWaitScreen.show(wait_messate: wait_title)
    }
      
    static func hideWaitControl() {
        instanceWaitScreen.hide()
    }
}
