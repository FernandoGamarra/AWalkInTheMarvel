//
//  defsDevelopMarvelApi.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 15/4/22.
//

import Foundation

enum eApiFunction:  Int {
    case    GET_CHARACTERS          = 1
    case    DOWNLOAD_IMAGE          = 101
}

struct defsApi {
    static let baseAddress = "https://gateway.marvel.com:443"
    static let charactersAddress = "/v1/public/characters"
}



