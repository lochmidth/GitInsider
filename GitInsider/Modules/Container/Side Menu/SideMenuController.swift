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
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 180, height: 180)
        let view = SideMenuHeader(frame: frame)
        return view
    }()
    
    private let tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .githubGrey
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        tv.rowHeight = 60
        tv.register(UITableViewCell.self, forCellReuseIdentifier: menuCellIdentifier)
        return tv
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: SideMenuViewModel = SideMenuViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = sideMenuHeader
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
//        cell.selectionColor = .githubLightGray
        cell.selectionStyle = .none
        cell.textLabel?.text = "Deneme"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: \(indexPath.row). row selected.")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sideMenuHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
}
