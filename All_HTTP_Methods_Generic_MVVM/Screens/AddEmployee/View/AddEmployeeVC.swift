//
//  AddEmployeeVC.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import UIKit

class AddEmployeeVC: UIViewController {
let addEmployeeViewModel = AddEmployeeViewModel()
    
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var empSurnameTextField: UITextField!
    @IBOutlet weak var empDesignationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func apiConfiguration(){
        addNewEmployee()
        observeEvent()
    }
    
    func addNewEmployee(){
        let newEmployee = Employee(empName: empNameTextField.text!, empSurname: empSurnameTextField.text!, empDesignation: empDesignationTextField.text!)
        addEmployeeViewModel.addEmployee(employee: newEmployee)
        
    }
    
    func observeEvent(){
        addEmployeeViewModel.eventHandler = { event in
            switch event{
            case .startLoading:
                print(event)
                break
            case .stopLoading:
                print(event)
                break
            case .reloadData:
                print(event)
                //print(self.addEmployeeViewModel.addedEmployee!)
                break
            case .error(let err):
                print(err)
                break
            }
        }
    }
    
    @IBAction func addEmployeeButtonTapped(_ sender: UIButton) {
        apiConfiguration()
        navigationController?.popViewController(animated: true)
    }
}
