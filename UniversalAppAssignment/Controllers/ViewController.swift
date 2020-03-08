//
//  ViewController.swift
//  UniversalAppAssignment
//
//  Created by apple on 06/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let tableViewRows = UITableView()
    private var rowListVM: RowListViewModel!
    
    var refreshControl = UIRefreshControl()
    var refreshCount = 1
    var dataShow = 7
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTableViewConstraints()
        if NetworkManagerConnectivity.networkManagerConnectivity.isConnectedToInternet{
            getResponse()
        }else {
            showInterConnectionNotAvailablityError()
        }
    }
    
    //MARK:- UITableView Creation and AutoLayout Constraint Setting
    func setTableViewConstraints() {
        view.addSubview(tableViewRows)
        tableViewRows.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            tableViewRows.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableViewRows.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
            tableViewRows.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
            tableViewRows.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        tableViewRows.dataSource = self
        tableViewRows.register(RowsTableViewCell.self, forCellReuseIdentifier: ConstantData.rowsCell)
        refreshControl.attributedTitle = NSAttributedString(string: ConstantData.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableViewRows.addSubview(refreshControl)
    }
    
    //MARK:- Pull To Refresh Function
    @objc func refresh(sender:AnyObject) {
        if refreshCount == 1 {
            refreshCount += 1
            dataShow = dataShow * refreshCount
            self.tableViewRows.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    //MARK:- Fetch Response
    private func getResponse() {
        let url = URL(string: ConstantData.url)!
        let sv = UIViewController.displaySpinner(onView: self.view)
        Webservice().getRows(url: url) { rows in
             if let rows = rows {
                   self.rowListVM = RowListViewModel(rows: rows)
                   DispatchQueue.main.async {
                    self.navigationItem.title = ConstantData.navigationTitle
                       self.tableViewRows.reloadData()
                       UIViewController.removeSpinner(spinner: sv)
                    }
              }
         }
    }
}
    
//MARK:- UITableView datasource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.rowListVM == nil ? 0 : self.rowListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataShow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantData.rowsCell, for: indexPath) as? RowsTableViewCell else {
            fatalError(ConstantData.cellNotFound)
        }

        let rowVM = self.rowListVM.rowAtIndex(indexPath.row)
        
        if rowVM.title.count > 0 {
            cell.lblTitle.text = rowVM.title
        }else {
            cell.lblTitle.text = ConstantData.title
        }
        if rowVM.description.count > 0 {
            cell.lblDescription.text = rowVM.description
        }else{
            cell.lblDescription.text = ConstantData.description
        }
        if rowVM.imageHref.count > 0 {
            cell.ImgVwRows.image = UIImage(url: URL(string: rowVM.imageHref))
        }else {
            cell.ImgVwRows.image = UIImage(named: ConstantData.noImageAvialable)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
}
    
//MARK:- Convert Image URL into Data
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

//MARK:- Network Checking
extension UIViewController {
    func showInterConnectionNotAvailablityError() {
        let alert = UIAlertController(title: ConstantData.internetConnectionError, message: ConstantData.checkConnection, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: ConstantData.ok, style: UIAlertAction.Style.cancel) {
                       UIAlertAction in
                   }
       alert.addAction(okAction)
       self.present(alert, animated:true, completion: nil)
       return
    }
}

//MARK:- Display, Remove Spinner
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        var ai = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
             ai = UIActivityIndicatorView.init(style: .large)
        } else {
            ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

