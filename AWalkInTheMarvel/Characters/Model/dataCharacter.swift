//
//  dataCharacter.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 13/4/22.
//

import Foundation

struct dataCharacter: Codable {
    
    var httpStatusCode: Int? = nil
    var httpStatusString: String? = nil
    var copyright: String? = nil
    var attributionText: String? = nil
    var attributionHTML: String? = nil
    var eTag: String? = nil
    var content: contentCharacters? = nil
    
    enum CodingKeys: String, CodingKey {
        case httpStatusCode = "code"
        case httpStatusString = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case eTag = "eTag"
        case content = "data"
    }
    
}

struct contentCharacters: Codable {
    var offset: Int? = nil
    var limit: Int? = nil
    var totalCharactersInWeb: Int? = nil
    var countCharactersInPage: Int? = nil
    var resultsCharacters: [characterProperties]? = nil
    
    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case totalCharactersInWeb = "total"
        case countCharactersInPage = "count"
        case resultsCharacters = "results"
    }
}

struct characterProperties: Codable {
    var id: Int? = nil
    var name: String? = nil
    var description: String? = nil
    var dateModified: String? = nil
    var thumbnail: dataThumbnail? = nil
    var resourceURI: String? = nil
    
    var comics: characterActivity? = nil
    var series: characterActivity? = nil
    var stories: characterActivity? = nil
    var events: characterActivity? = nil
    var urls: [characterUrl]? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case dateModified = "modified"
        case thumbnail = "thumbnail"
        case resourceURI = "resourceURI"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"
        case urls = "urls"
    }
    
}

struct characterActivity: Codable {
    var available: Int? = nil
    var collectionURI: String? = nil
    var comics: [dataActivity]? = nil
    var number: Int? = nil

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case comics = "items"
        case number = "returned"
    }
}

struct characterUrl: Codable {
    var type: String? = nil
    var url: String? = nil

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}


struct dataThumbnail: Codable {
    var path: String? = nil
    var fileExtension: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
}

struct dataActivity: Codable {
    var URI: String? = nil
    var name: String? = nil
    var type: String? = nil

    enum CodingKeys: String, CodingKey {
        case URI = "resourceURI"
        case name = "name"
        case type = "type"
    }
}
