//
//  UpdateEmployeeVC.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import UIKit

class UpdateEmployeeVC: UIViewController {
let updateEmployeeViewModel = UpdateEmployeeViewModel()
    
    @IBOutlet weak var empNameTextField: UITextField!
    
    @IBOutlet weak var empSurnameTextField: UITextField!
    
    @IBOutlet weak var empDesignationTextField: UITextField!
    @IBOutlet weak var empIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func apiConfiguration(){
        updateEmployee()
        observeEvent()
    }
    
    func updateEmployee(){
        let updateExistingEmployee = Employee(empName: empNameTextField.text!, empSurname: empSurnameTextField.text!, empDesignation: empDesignationTextField.text!)
        updateEmployeeViewModel.updateEmployee(employee: updateExistingEmployee, and: empIdTextField.text!)
    }
    
    func observeEvent(){
        updateEmployeeViewModel.eventHandler = { event in
            switch event{
            case .startLoading:
                print(event)
                break
                
            case .stopLoading:
                print(event)
                break
                
            case .reloadData:
                print(event)
                print(self.updateEmployeeViewModel.updatedEmployee!)
                
            case .error(let err):
                print(err)
                break
            }
        }
    }

    @IBAction func updateEmployeeButtonTapped(_ sender: UIButton) {
        apiConfiguration()
        navigationController?.popToRootViewController(animated: true)
    }
}
