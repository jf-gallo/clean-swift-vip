//
//  Extensions.swift
//  Base
//
//  Created by Juan Felipe Gallo on 4/17/20.
//  Copyright © 2020 Juan Felipe Gallo. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    var getQueryString: String
    {
        var data = [String]()
        for(key, value) in self
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    var asJson: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
}

public extension Decodable {
     static func parse(from dictionary: [String: Any]) -> [Self]? {
        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return try decoder.decode([Self].self, from: data)
        } catch {
            return nil
        }
    }
    
     static func parseEntity(from dictionary: [String: Any]) -> Self? {
        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return try decoder.decode(Self.self, from: data)
        } catch {
            return nil
        }
    }
    
    static func parse(from arrayOfDictionaries: [[String: Any]]) -> [Self]? {
        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: arrayOfDictionaries, options: [])
            return try decoder.decode([Self].self, from: data)
        } catch {
            return nil
        }
    }
}

