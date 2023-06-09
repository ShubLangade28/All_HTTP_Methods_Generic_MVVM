//
//  File.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation
struct Employee: Codable {
    let empName, empSurname, empDesignation: String
    var id: String?
    
    init(empName: String, empSurname: String, empDesignation: String, id: String? = nil) {
        self.empName = empName
        self.empSurname = empSurname
        self.empDesignation = empDesignation
        self.id = id
    }
  
    
}
