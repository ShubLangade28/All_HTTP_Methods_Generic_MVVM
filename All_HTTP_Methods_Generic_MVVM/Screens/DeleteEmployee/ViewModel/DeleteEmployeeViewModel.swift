//
//  DeleteEmployeeViewModel.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation

final class DeleteEmployeeViewModel{
    var deletedEmployee : Employee?
    var eventHandler : ((_ event : Event)->())?
    
    func deleteEmployee(employee id : String){
        DispatchQueue.main.async { [self] in
            eventHandler?(.startLoading)
        }
        ApiManager.shared.apiCall(model: Employee.self, type: .deleteEmployee(id: id)) { [self] result in
            eventHandler?(.stopLoading)
            switch result{
            case .success(let deletedEmployee):
                self.deletedEmployee = deletedEmployee
                self.eventHandler?(.reloadData)
                break
            case .failure(let err):
                self.eventHandler?(.error(err))
                break
            }
        }
    }
}
