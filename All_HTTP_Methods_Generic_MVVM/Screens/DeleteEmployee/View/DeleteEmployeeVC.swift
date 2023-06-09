//
//  DeleteEmployeeVC.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import UIKit

class DeleteEmployeeVC: UIViewController {
let deleteEmployeeViewModel = DeleteEmployeeViewModel()
    @IBOutlet weak var empIdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func apiConfiguration(){
        deleteEmployee()
        observeEvent()
    }
    
    func deleteEmployee(){
        deleteEmployeeViewModel.deleteEmployee(employee: empIdTextField.text!)
    }
    
    func observeEvent(){
        deleteEmployeeViewModel.eventHandler = { event in
            switch event{
            case .startLoading:
                print(event)
                break
            case .stopLoading:
                print(event)
                break
            case .reloadData:
                print(event)
                print(self.deleteEmployeeViewModel.deletedEmployee!)
                break
            case .error(let err):
                print(err)
                break
            }
        }
    }
    
    
    @IBAction func deleteEmployeeButtonTapped(_ sender: UIButton) {
        apiConfiguration()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
