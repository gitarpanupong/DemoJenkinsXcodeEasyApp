//
//  Section.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import Foundation


struct Section {
    var table: String!
    var order: [String]!
    var expanded: Bool!
    
    init(table: String, order: [String], expanded: Bool) {
        self.table = table
        self.order = order
        self.expanded = expanded
    }
    
}
