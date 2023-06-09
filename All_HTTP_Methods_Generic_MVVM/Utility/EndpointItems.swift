//
//  EndpointItems.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation
enum HTTPMethod : String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "Delete"
}

protocol EndpointType{
    var baseUrl : String {get}
    var path : String{get}
    var url : URL? {get}
    var httpMethod : HTTPMethod {get}
    var parameter : Data? {get}
    var header : [String : String]? {get}
}

enum EndpointItems{
    case getEmployee
    case addEmployee(employee : Employee)
    case updateEmployee(employee : Employee, id : String)
    case deleteEmployee(id : String)
}

extension EndpointItems : EndpointType{
    var baseUrl: String {
        return "https://633440bb90a73d0fedeab860.mockapi.io/"
    }
    
    var path: String {
        switch self{
        case .getEmployee:
            return "emp"
        case .addEmployee:
            return "emp"
        case .updateEmployee(employee: _, id: let id):
            return "emp/\(id)"
        case .deleteEmployee(id: let id):
            return "emp/\(id)"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getEmployee:
            return .get
        case .addEmployee:
            return .post
        case .updateEmployee:
            return .put
        case .deleteEmployee:
            return .delete
        }
    }
    
    var parameter: Data? {
        switch self{
        case .getEmployee:
            return Data()
        case .addEmployee(employee: let employee):
            return try? JSONEncoder().encode(employee)
        case .updateEmployee(employee: let employee, id: _):
            return try? JSONEncoder().encode(employee)
        case .deleteEmployee:
            return Data()
        }
    }
    
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
