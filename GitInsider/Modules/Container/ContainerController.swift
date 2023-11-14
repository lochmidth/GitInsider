//
//  ContainerController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import UIKit

enum ActionButtonConfiguration {
    case showMenu
    case dismissActionView
    
    init() {
        self = .showMenu
    }
}

class ContainerController: UIViewController {
    //MARK: - Properties
    
    var viewModel: ContainerViewModel
    
    private var homeController: HomeController!
    private var sideMenuController: SideMenuController!
    private var isExpanded = false
    private let blackView = UIView()
    
    private lazy var xOrigin = self.view.frame.width - 260
    
    private var actionButtonConfig = ActionButtonConfiguration()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: ContainerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    //MARK: - Actions
    
    @objc func dismissMenu() {
        isExpanded = false
        animateSideMenu(shouldExpand: isExpanded)
        configureActionButton(config: .showMenu)
    }
    
    @objc func actionButtonPressed() {
        switch actionButtonConfig {
        case .showMenu:
            isExpanded.toggle()
            configureActionButton(config: .dismissActionView)
            animateSideMenu(shouldExpand: isExpanded)
        case .dismissActionView:
            isExpanded.toggle()
            configureActionButton(config: .showMenu)
            animateSideMenu(shouldExpand: isExpanded)
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .githubBlack
        
        configureHomeController()
        configureSideMenuController()
        configureBlackView()
        
        view.addSubview(actionButton)
        actionButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            paddingTop: 16, paddingLeft: 20, width: 30, height: 30)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureHomeController() {
        homeController = HomeController()
        homeController.addShadow()
        addChild(homeController)
        homeController.didMove(toParent: self)
        view.addSubview(homeController.view)
    }
    
    private func configureSideMenuController() {
        sideMenuController = SideMenuController(viewModel: SideMenuViewModel())
        addChild(sideMenuController)
        sideMenuController.didMove(toParent: self)
        view.insertSubview(sideMenuController.view, at: 0)
    }
    
    private func configureBlackView() {
        blackView.frame = CGRect(x: xOrigin, y: 0, width: 260, height: self.view.frame.height)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.alpha = 0
        view.addSubview(blackView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        blackView.addGestureRecognizer(tap)
    }
    
    func configureActionButton(config: ActionButtonConfiguration) {
        switch config {
        case .showMenu:
            actionButton.isHidden = false
            actionButtonConfig = .showMenu
        case .dismissActionView:
            actionButton.isHidden = true
            actionButtonConfig = .dismissActionView
        }
    }
    
    func animateSideMenu(shouldExpand: Bool) {
        animateStatusBar()
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.blackView.alpha = 1
                self.homeController.view.frame.origin.x = self.xOrigin
                self.actionButton.transform = CGAffineTransform(translationX: 250, y: 0)
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.blackView.alpha = 0
                self.homeController.view.frame.origin.x = 0
                self.actionButton.transform = .identity
            }
        }
    }
    
    private func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
