//
//  ProfileController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import UIKit

class ProfileController: UIViewController {
    //MARK: - Properties
    
    var viewModel: ProfileViewModel?
    
    private lazy var profileHeader: ProfileHeader = {
        let header = ProfileHeader()
        header.setDimensions(height: 350, width: self.view.frame.width)
        header.layer.cornerRadius = 20
        header.addShadow()
        return header
    }()
    
    private let tableViewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        let label = UILabel()
        label.text = "REPOSITORIES"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(label)
        label.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft: 16)
        
        return view
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .lightGray
        tv.layer.cornerRadius = 20
        return tv
    }()
    
    private lazy var viewForShadow: UIView = { //Because of layer.maskToBounds = false, had to seperate shadow and collectionView.
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        view.addShadow()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfileHeader()
        configureTableView()
        configureUI()
    }
    
    //MARK: - Helpers
    
    //    private func configureViewModel() {
    //        guard let viewModel = viewModel else { return }
    //
    //    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileHeader)
        profileHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 4, paddingLeft: 18, paddingRight: 18)
        
        view.addSubview(viewForShadow)
        viewForShadow.anchor(top: profileHeader.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                         paddingTop: 4, paddingLeft: 18, paddingRight: 18)
    }
    
    private func configureProfileHeader() {
        guard let viewModel = viewModel else { return }
        viewModel.checkIfUserFollowing(username: viewModel.user.login) { [weak self] followingStatus in
            if viewModel.authLogin == viewModel.user.login {
                self?.profileHeader.viewModel = ProfileHeaderViewModel(user: viewModel.user, followingStatus: followingStatus, config: .editProfile)
                self?.profileHeader.delegate = self
            } else {
                self?.profileHeader.viewModel = ProfileHeaderViewModel(user: viewModel.user, followingStatus: followingStatus)
                self?.profileHeader.delegate = self
            }
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "repoCell")
        viewModel?.getUserRepos(username: viewModel?.user.login ?? "", completion: {
            self.tableView.reloadData()
        })
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        cell.textLabel?.text = viewModel?.repos[indexPath.item].name
        cell.textLabel?.textColor = .githubGrey
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel?.repos[indexPath.item].htmlUrl ?? "") else { return }
        UIApplication.shared.open(url)
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func follow(username: String) {
        viewModel?.follow(username: username, completion: {
            print("DEBUG: \(username) followed.")
            self.profileHeader.viewModel?.config = .following
            
            UIView.animate(withDuration: 0.5) {
                self.profileHeader.configureViewModel()
            }
        })
    }
    
    func unfollow(username: String) {
        print("DEBUG: unfollow pressed")
        viewModel?.unfollow(username: username, completion: {
            print("DEBUG: \(username) unfollowed.")
            self.profileHeader.viewModel?.config = .notFollowing
            
            UIView.animate(withDuration: 0.5) {
                self.profileHeader.configureViewModel()
            }
        })
    }
    
    func editProfile() {
        print("DEBUG: Handle Edit Profile")
    }
}
