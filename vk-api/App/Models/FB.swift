//
//  FB.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.09.2021.
//

import Foundation
import Firebase

class Firebase {
    
    let id: Int

    let ref: DatabaseReference?

    init(id: Int) {
        self.ref = nil
        self.id = id
    }

    init?(snapshot: DataSnapshot) {

        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int

        else {
            return nil
        }

        self.ref = snapshot.ref
        self.id = id
    }

    func toAnyObject() -> [AnyHashable: Any] {
        return
            [
              "id": id ] as [AnyHashable: Any]
    }
}
