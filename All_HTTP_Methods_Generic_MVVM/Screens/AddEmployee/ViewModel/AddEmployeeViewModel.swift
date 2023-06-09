//
//  AddEmployeeViewModel.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation

final class AddEmployeeViewModel{
    var addedEmployee : Employee?
    var eventHandler : ((_ event : Event)->())?
    
    func addEmployee(employee : Employee){
        DispatchQueue.main.async {
            self.eventHandler?(.startLoading)
        }
        
        ApiManager.shared.apiCall(model: Employee.self, type: .addEmployee(employee: employee)) { result in
            self.eventHandler?(.stopLoading)
            switch result{
            case .success(let employee):
                print(employee)
                self.addedEmployee = employee
                self.eventHandler?(.reloadData)
                break
            case .failure(let err):
                self.eventHandler?(.error(err))
            }
        }
    }
}
