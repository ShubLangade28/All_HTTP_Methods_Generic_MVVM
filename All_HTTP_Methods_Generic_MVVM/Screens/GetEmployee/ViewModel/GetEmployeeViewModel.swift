//
//  GetEmployeeViewModel.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation

final class GetEmployeeViewModel{
    var employee = [Employee]()
    var eventHandler : ((_ event : Event) -> ())?
    
    func fetchEmployee(){
        DispatchQueue.main.async {
            self.eventHandler?(.startLoading)
        }
        ApiManager.shared.apiCall(model: [Employee].self, type: .getEmployee) { result in
            self.eventHandler?(.stopLoading)
            switch result{
            case .success(let employee) :
                self.employee = employee
                self.eventHandler?(.reloadData)
                break
                
            case .failure(let error):
                self.eventHandler?(.error(error))
                break
            }
        }
    }
}
