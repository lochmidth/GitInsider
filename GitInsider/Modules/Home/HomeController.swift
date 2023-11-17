//
//  HomeController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "UserCell"

class HomeController: UIViewController {
    //MARK: - Properties
    
    var searchTimer: Timer?
    
    var viewModel: HomeViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var profileImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .lightGray
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.setDimensions(height: 44, width: 44)
        button.layer.cornerRadius = 44 / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapProfileImage), for: .touchUpInside)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .githubGrey
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let greetingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for users"
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private let noCellImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "github_cat_search")?.withRenderingMode(.alwaysOriginal)
        iv.alpha = 0.4
        iv.setDimensions(height: 300, width: 300)
        return iv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .githubGrey
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    private lazy var viewForShadow: UIView = { //Because of layer.maskToBounds = false, had to seperate shadow and collectionView.
        let view = UIView()
        view.backgroundColor = .githubGrey
        view.layer.cornerRadius = 20
        view.addShadow()
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
        view.addSubview(noCellImage)
        noCellImage.center(inView: view)
        
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
        configureDismissKeyboard()
        configureSearchBar()
        configureCollectionView()
    }
    
    //MARK: - Actions
    
    @objc func didTapProfileImage() {
        guard let user = viewModel?.user else { return }
        viewModel?.goToProfile(withUser: user)
    }
    
    @objc func handleKeayboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func handleSignOut() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            self.viewModel?.handleSignOut()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
    //MARK: - Helpers
    
    private func configureViewModel() {
        guard let viewModel = viewModel else { return }
        profileImageButton.kf.setImage(with: viewModel.profileImageUrl, for: .normal)
        nameLabel.text = viewModel.nameText
        greetingsLabel.text = viewModel.greetingText
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, greetingsLabel, searchBar])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(viewForShadow)
        viewForShadow.anchor(top: stack.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                              paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
    }
    
    private func configureNavigationBar() {
        let appereance = UINavigationBarAppearance()
        appereance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appereance
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Home"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageButton)
        let signOutIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: signOutIcon, style: .done, target: self, action: #selector(handleSignOut))
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.setDimensions(height: 70, width: self.view.frame.width)
    }
    
    private func configureDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleKeayboardDismiss))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func configureCollectionView() {
        collectionView.frame.size.width = view.frame.width
        collectionView.autoresizingMask = .flexibleHeight
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension HomeController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            Task {
                try await self?.viewModel?.searchUser(forUsername: searchText)
                self?.collectionView.reloadData()
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (viewModel?.users?.items.isEmpty == false) {
            noCellImage.isHidden = true
        } else {
            noCellImage.isHidden = false
        }
        
        return viewModel?.users?.items.count ?? 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        cell.viewModel = UserCellViewModel(item: viewModel?.users?.items[indexPath.item] ?? Item(login: "", avatarUrl: ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelectItemAt(index: indexPath.item)
    }
    
    
}
