//
//  SideMenuController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import UIKit

private let menuCellIdentifier = "MenuCell"

class SideMenuController: UIViewController {
    //MARK: - Properties
    
    var viewModel: SideMenuViewModel
    
    lazy var sideMenuHeader: SideMenuHeader = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        let header = SideMenuHeader(frame: frame)
        return header
    }()
    
    private let tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .githubGrey
        tv.isScrollEnabled = false
        tv.rowHeight = 60
        tv.register(UITableViewCell.self, forCellReuseIdentifier: menuCellIdentifier)
        return tv
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: SideMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .githubGrey
        configureTableView()
        configureSideMenuHeader()
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: -5, y: 0, width: view.bounds.width - 260, height: view.bounds.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = sideMenuHeader
    }
    
    private func configureSideMenuHeader() {
        viewModel.getCurrentUser { [weak self] user in
            self?.sideMenuHeader.viewModel = SideMenuHeaderViewModel(user: user)
        }
    }
}

//MARK: - UITableViewDelegate / DataSource

extension SideMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuCellIdentifier, for: indexPath)
        cell.backgroundColor = .githubGrey
        
        cell.textLabel?.text = "Your Repositories"
        cell.textLabel?.textColor = .githubLightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: \(indexPath.row). row selected.")
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        footer.
//        return
//    }
}
