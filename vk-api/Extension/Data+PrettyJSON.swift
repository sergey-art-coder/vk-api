//
//  Data+PrettyJSON.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.08.2021.
//

import Foundation

extension Data {
    var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {return nil}
        return prettyPrintedString
    }
}
