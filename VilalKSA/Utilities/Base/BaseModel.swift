//
//  BaseModel.swift
//  VilalKSA
//
//  Created by Elkilany on 04/01/2024.
//

import Foundation

protocol BaseModel: Decoderable, Codable, Hashable {
    func toJSON() -> [String: Any]?
}

extension BaseModel {
    func toJSON() -> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            } else {
                debugPrint("[toJSON-JSONSerialization] fails to convert data to json.")
                return nil
            }
        } catch {
            debugPrint("[toJSON-func]\(error)")
            return nil
        }
    }

    func jsonToString() {
        do {
            let data1 = try JSONSerialization.data(withJSONObject: toJSON() ?? [:], options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            var convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
    }

    func toStringJSON() -> String {
        do {
            let data1 = try JSONSerialization.data(withJSONObject: toJSON() ?? [:], options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            var convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            convertedString?.removeAll(where: { $0 == "\n" })
            print(convertedString ?? "defaultvalue")
            return convertedString ?? ""
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
        return ""
    }
}
protocol Decoderable {
    static func decodeJSON<T: Codable>(_ res: Any, To model: T.Type, format: JSONDecoder.KeyDecodingStrategy) -> Any?
}

extension Decoderable {
    static func decodeJSON<T: Codable>(_ res: Any, To _: T.Type, format: JSONDecoder.KeyDecodingStrategy) -> Any? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = format
        do {
            guard let jsonData = Data.convertToData(res) else {
                debugPrint("[decodeJSON-convertToData] decodeJSON func fails to convert json to data.")
                return nil
            }

            var result: Any?

            if let _ = res as? [String: Any] {
                let object = try decoder.decode(T.self, from: jsonData)
                result = object
            } else if let _ = res as? [[String: Any]] {
                let list = try decoder.decode([T].self, from: jsonData)
                result = list
            } else if let anyArr = res as? [Any] {
                let list = try anyArr.map { element -> Any? in
                    if let json = element as? [String: Any] {
                        guard let jsonData = Data.convertToData(json) else { return nil }
                        let object = try decoder.decode(T.self, from: jsonData)
                        return object
                    } else {
                        return nil
                    }
                }
                result = list
            } else {
                result = res
            }
            return result

        } catch {
            debugPrint("[decodeJSON-func]\(error)")
            return nil
        }
    }
}
extension Data {
    static func convertToData(_ obj: Any) -> Data? {
        var data: Data? = Data()
        if let jsonString = obj as? String {
            let result = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            data = result
        } else if let jsonArrayOfDic = obj as? [[String: AnyObject]] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonArrayOfDic, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        } else if let jsonDic = obj as? [String: AnyObject] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        } else if var myInt = obj as? Int {
        
            let result = Data(bytes: &myInt, count: MemoryLayout.size(ofValue: myInt))
            data = result
        } else if let myArr = obj as? [Any?] {
            do {
                let result = try JSONSerialization.data(withJSONObject: myArr, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        }
        return data
    }
}
