//
//  Model.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var resorts: [Resort] = Bundle.main.load("resorts.json")
}
