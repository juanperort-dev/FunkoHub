//
//  FunkoListViewController.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

protocol FunkoListPresenterDelegate: AnyObject {
    func backButtonAction()
    func didSelectRowAt(index: Int)
    func getNumberOfRows() -> Int
    func updateView()
    func getDefaultValue()
    func getCellData(index: Int) -> Funko
}

class FunkoListViewController: UIViewController, FunkoListViewControllerDelegate {
  
    @IBOutlet weak var labelEmptyList: UILabel!
    @IBOutlet public weak var tableView: UITableView!
    
    private let presenter: FunkoListPresenter = FunkoListPresenter()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.updateView()
        
        let backBarButtonItem = UIBarButtonItem(title: "back".localized, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }

    @IBAction func backButtonAction(_ sender: Any) {
        presenter.backButtonAction()
    }
    
    func setupDefaultValue() {
        presenter.getDefaultValue()
    }
    
    func showTableView() {
        tableView.isHidden = false
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func navigateToFilter(defaultData: KeyDataFunkos, filteredData: KeyDataFunkos) {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.funkoFilter, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(identifier: Constants.Storyboard.funkoFilter) as? FunkoFilterViewController else { return }
        viewController.delegate = presenter
        viewController.presenter.setDefaultData(data: defaultData)
        viewController.presenter.setChangedData(data: filteredData)
        navigationController?.show(viewController, sender: nil)
    }
    
    func showDetailFunkoPopup(funko: Funko) {
        guard let type = TypeCodeFunko(rawValue: funko.type.rawValue)?.getImageName(),
              let name = funko.name 
        else { return }
        
        showPopup(title: type, message: name, viewcontroller: self)
    }
    
}

extension FunkoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FunkoListCell.id, for: indexPath) as? FunkoListCell else {
            return UITableViewCell()
        }
        
        let data = presenter.getCellData(index: indexPath.row)
        cell.setupDataCell(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
     }
}
