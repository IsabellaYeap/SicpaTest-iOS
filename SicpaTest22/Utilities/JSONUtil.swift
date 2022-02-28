//
//  JSONUtil.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import UIKit

class JSONUtil: NSObject {
    
    /// Decode JSON with generic different types
    /// - Returns: object type
    public static func decode<T: Codable>(data: Data?, ele: T.Type) -> T? {
        guard let data = data else { return nil }
        
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch let error {
            debugPrint("Unable to decode", error)
        }
        
        return nil
    }
    
    /// Decode an array of generic with different types
    /// - Returns: an array of object type
    public static func decodeArray<T: Codable>(data: Data?, ele: [T].Type) -> [T]? {
        guard let data = data else { return nil }
        
        do {
            let object = try JSONDecoder().decode([T].self, from: data)
            return object
        } catch let error {
            debugPrint("Unable to decode", error)
        }
        
        return nil
    }

    public static func encode<T: Encodable>(object: T) -> Data? {
        do {
            let data = try JSONEncoder().encode(object)
            return data
        } catch let error {
            debugPrint("Unable to encode", error)
        }
        
        return nil
    }
    
    public static func encodeArray<T: Encodable>(object: [T]) -> Data? {
        do {
            let data = try JSONEncoder().encode(object)
            return data
        } catch let error {
            debugPrint("Unable to encode array", error)
        }
        
        return nil
    }
}
