//
//  GetEmployeeVC.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import UIKit

class GetEmployeeVC: UIViewController {
    @IBOutlet weak var employeeImage: UIImageView!
    let getEmployee = GetEmployeeViewModel()
    @IBOutlet weak var employeeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTable.delegate = self
        employeeTable.dataSource = self
        employeeImage.clipsToBounds = true
        employeeImage.layer.cornerRadius = employeeImage.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiConfiguration()
        employeeTable.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let addEmployeeVC = storyboard?.instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let deleteEmployeeVC = storyboard?.instantiateViewController(withIdentifier: "DeleteEmployeeVC") as! DeleteEmployeeVC
        navigationController?.pushViewController(deleteEmployeeVC, animated: true)
    }
    
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        let updateEmployeeVC = storyboard?.instantiateViewController(withIdentifier: "UpdateEmployeeVC") as! UpdateEmployeeVC
        navigationController?.pushViewController(updateEmployeeVC, animated: true)
    }
    
    
}

extension GetEmployeeVC{
    func apiConfiguration(){
        fetchEmployee()
        observEvent()
    }
    
    func fetchEmployee(){
        getEmployee.fetchEmployee()
    }
    
    func observEvent(){
        getEmployee.eventHandler = {[weak self] event in
            guard let self = self else{return}
            switch event{
            case .startLoading:
                print(event)
                break
            case .stopLoading:
                print(event)
                break
            case .reloadData:
                print(event)
                DispatchQueue.main.async {
                    self.employeeTable.reloadData()
                }
                break
            case .error(let err):
                print(err)
                break
            }
        }
    }
    
}

extension GetEmployeeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(getEmployee.employee.count)
        return getEmployee.employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTable.dequeueReusableCell(withIdentifier: "CellS", for: indexPath)
        cell.textLabel?.text = getEmployee.employee[indexPath.row].empName
        cell.detailTextLabel?.text = getEmployee.employee[indexPath.row].empDesignation
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}
