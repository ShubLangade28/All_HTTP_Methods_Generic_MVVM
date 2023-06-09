//
//  UpdateEmployeeViewModel.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation
final class UpdateEmployeeViewModel{
    var updatedEmployee : Employee?
    var eventHandler : ((_ event : Event) -> ())?
    
    func updateEmployee(employee : Employee, and id : String){
        DispatchQueue.main.async { [self] in
            eventHandler?(.startLoading)
        }
        
        ApiManager.shared.apiCall(model: Employee.self, type: .updateEmployee(employee: employee, id: id)) { result in
            self.eventHandler?(.stopLoading)
            switch result{
                
            case .success(let updatedEmployee):
                self.updatedEmployee = updatedEmployee
                self.eventHandler?(.reloadData)
                break
            case .failure(let err):
                self.eventHandler?(.error(err))
                break
            }
        }
    }
}
