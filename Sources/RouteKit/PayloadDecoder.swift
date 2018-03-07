//
//  PayloadDecoder.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/08.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

class PayloadDecoder {
    func decode<T>(_ type: T.Type = T.self, from data: [String : String]) throws -> T where T : Decodable {
        return try T(from: InnerDecoder(data: data))
    }

    class InnerDecoder : Decoder {
        let data: [String : String]
        var codingPath = [CodingKey]()
        let userInfo = [CodingUserInfoKey : Any]()
        
        init(data: [String : String]) {
            self.data = data
        }
        
        func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
            return KeyedDecodingContainer(InnerKeyedDecodingContainer(referencing: self))
        }
        
        func unkeyedContainer() throws -> UnkeyedDecodingContainer {
            fatalError("It should not be called")
        }
        
        func singleValueContainer() throws -> SingleValueDecodingContainer {
            return InnerSingleValueDecodingContainer(referencing: self)
        }
    }

    class InnerKeyedDecodingContainer<Key> : KeyedDecodingContainerProtocol where Key : CodingKey {
        let decoder: InnerDecoder
        
        var codingPath: [CodingKey] {
            return self.decoder.codingPath
        }
        
        var allKeys: [Key] {
            return self.decoder.data.keys.flatMap(Key.init)
        }
        
        init(referencing decoder: InnerDecoder) {
            self.decoder = decoder
        }
        
        func contains(_ key: Key) -> Bool {
            return self.allKeys.contains { $0.stringValue == key.stringValue }
        }
        
        func decodeNil(forKey key: Key) throws -> Bool {
            return self.decoder.data[key.stringValue] == nil
        }
        
        func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable & LosslessStringConvertible {
            guard let rawValue = self.decoder.data[key.stringValue] else {
                throw DecodingError.valueNotFound(type, .init(codingPath: self.codingPath, debugDescription: "No value associated with key '\(key)'."))
            }
            
            guard let value = T(rawValue) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "String value \"\(rawValue)\" does not fit in \(type)."))
            }
            
            return value
        }
        
        func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
            self.decoder.codingPath.append(key)
            defer { self.decoder.codingPath.removeLast() }
            return try T(from: self.decoder)
        }
        
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            fatalError("It should not be called")
        }
        
        func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
            fatalError("It should not be called")
        }
        
        func superDecoder() throws -> Decoder {
            fatalError("It should not be called")
        }
        
        func superDecoder(forKey key: Key) throws -> Decoder {
            fatalError("It should not be called")
        }
    }

    class InnerSingleValueDecodingContainer : SingleValueDecodingContainer {
        let decoder: InnerDecoder
        
        var codingPath: [CodingKey] {
            return self.decoder.codingPath
        }
        
        init(referencing decoder: InnerDecoder) {
            self.decoder = decoder
        }
        
        func decodeNil() -> Bool {
            if let key = self.codingPath.last {
                return self.decoder.data[key.stringValue] == nil
            } else {
                return true
            }
        }
        
        func decode<T>(_ type: T.Type) throws -> T where T : Decodable & LosslessStringConvertible {
            guard let key = self.codingPath.last else {
                fatalError("It should not be called")
            }
            
            guard let rawValue = self.decoder.data[key.stringValue] else {
                throw DecodingError.valueNotFound(type, .init(codingPath: self.codingPath, debugDescription: "No value associated with key '\(key)'."))
            }
            
            guard let value = T(rawValue) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "String value \"\(rawValue)\" does not fit in \(type)."))
            }
            
            return value
        }
        
        func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            return try T(from: self.decoder)
        }
    }
}
