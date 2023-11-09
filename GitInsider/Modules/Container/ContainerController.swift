//
//  ContainerController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 9.11.2023.
//

import UIKit

class ContainerController: UIViewController {
    //MARK: - Properties
    
    var viewModel: ContainerViewModel
    
    private var homeController: HomeController!
    private var sideMenuController: SideMenuController!
    private var isExpanded = false
    private let blackView = UIView()
    
    private lazy var xOrigin = self.view.frame.width - 80
    
    //MARK: - Lifecycle
    
    init(viewModel: ContainerViewModel = ContainerViewModel()) {
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
        homeController.configureActionButton(config: .showMenu)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .githubBlack
        
        configureHomeController()
        configureSideMenuController()
        configureBlackView()
    }
    
    private func configureHomeController() {
        homeController = HomeController()
        addChild(homeController)
        homeController.delegate = self
        homeController.didMove(toParent: self)
        view.addSubview(homeController.view)
    }
    
    private func configureSideMenuController() {
        sideMenuController = SideMenuController()
        sideMenuController.sideMenuHeader = SideMenuHeader()
        addChild(sideMenuController)
        sideMenuController.didMove(toParent: self)
        view.insertSubview(sideMenuController.view, at: 0)
    }
    
    private func configureBlackView() {
        blackView.frame = CGRect(x: xOrigin, y: 0, width: 80, height: self.view.frame.height)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.alpha = 0
        view.addSubview(blackView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        blackView.addGestureRecognizer(tap)
    }
    
    func animateSideMenu(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.homeController.view.frame.origin.x = self.xOrigin
                self.blackView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.blackView.alpha = 0
                self.homeController.view.frame.origin.x = 0
            }
        }
        animateStatusBar()
    }
    
    private func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

//MARK: - HomeControllerDelegate

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle() {
        isExpanded.toggle()
        animateSideMenu(shouldExpand: isExpanded)
    }
}
