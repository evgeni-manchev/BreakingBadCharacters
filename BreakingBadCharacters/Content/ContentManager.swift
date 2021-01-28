//
//  ContentManager.swift
//  BreakingBadCharacters
//
//  Created by Evgeni Manchev on 28.01.21.
//

import Foundation

class ContentManager {
    static func requestContent(completionHandler: @escaping (Characters) -> Void) {
        guard let url = URLs.charactersUrl else { return }
        
        let task = URLSession.shared.downloadCharacters(with: url) { charactersList, response, error in
            if let charactersList = charactersList {
                completionHandler(charactersList)
            }
        }
        task.resume()
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
