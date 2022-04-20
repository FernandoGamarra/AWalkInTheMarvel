//
//  defsDevelopMarvelApi.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 15/4/22.
//

import Foundation
import SwiftUI

enum eApiFunction:  Int {
    case    GET_CHARACTERS          = 1,
            GET_CHARACTER_DETAILS
    case    DOWNLOAD_IMAGE          = 101
}

struct defsApi {
    static let baseAddress = "https://gateway.marvel.com:443"
    static let charactersAddress = "/v1/public/characters"
    static let characterDetailsAddress = "/v1/public/characters/"
}



