//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Kaveesh Khattar on 03/07/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
