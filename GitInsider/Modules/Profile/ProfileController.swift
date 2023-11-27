//
//  ProfileController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import UIKit
import SkeletonView

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
        
        configureUI()
        configureProfileHeader()
        configureTableView()
    }
    
    //MARK: - Helpers
    
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
        Task {
            self.profileHeader.viewModel = try await viewModel.configureProfileHeaderViewModel()
            self.profileHeader.delegate = self
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .githubGrey), transition: .crossDissolve(0.25))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "repoCell")
        Task {
            try await viewModel?.getUserRepos()
            tableView.hideSkeleton(transition: .crossDissolve(1.0))
            tableView.reloadData()
        }
    }
}

extension ProfileController: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "repoCell"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repos.count ?? 0
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        cell.textLabel?.text = viewModel?.repos[indexPath.item].name
        cell.textLabel?.textColor = .githubGrey
        cell.backgroundColor = .lightGray
        return cell
    }
    
//    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
//        let cell = skeletonView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
//        cell.textLabel?.isHidden = indexPath.row == 0
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(index: indexPath.item)
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func follow(username: String) {
        Task {
            try await viewModel?.follow(username: username)
            print("DEBUG: \(username) followed.")
            profileHeader.viewModel?.config = .following
            
            UIView.animate(withDuration: 0.5) {
                self.profileHeader.configureViewModel()
            }
        }
    }
    
    func unfollow(username: String) {
        Task {
            try await viewModel?.unfollow(username: username)
            print("DEBUG: \(username) unfollowed.")
            self.profileHeader.viewModel?.config = .notFollowing
            
            UIView.animate(withDuration: 0.5) {
                self.profileHeader.configureViewModel()
            }
        }
    }
    
    func editProfile() {
        print("DEBUG: Handle Edit Profile")
    }
}
