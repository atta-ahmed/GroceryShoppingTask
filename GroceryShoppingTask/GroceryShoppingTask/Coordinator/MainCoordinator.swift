////
////  MainCoordinator.swift
////  GroceryShoppingTask
////
////  Created by Atta Amed on 7/14/20.
////  Copyright © 2020 Atta Amed. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//protocol Coordinator: AnyObject {
//    var childCoordinators: [Coordinator] { get set }
//    var navigationController: UINavigationController { get set }
//
//    func start(vc: Coordinator)
//}
//
//class MainCoordinator: NSObject, Coordinator {
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start(vc: Coordinator) {
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: false)
//    }
//    func goToFirstVC() {
//        let chiled = FirstCoordinator(navigationController: navigationController)
//        childCoordinators.append(chiled)
//        chiled.parantCoordinator = self
//        chiled.start()
//    }
//
//    func childDidFinish(_ child: Coordinator?) {
//        for (index, coordinator) in childCoordinators.enumerated() {
//            if coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
//    }
//
//}
//class CartCoordinator: Coordinator {
//
//    weak var parantCoordinator: MainCoordinator?
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start(vc: Coordinator) {
//        // we'll add code here
//        vc
//        navigationController.pushViewController(vc, animated: false)
//    }
//}
//
//protocol Routarable: MainCoordinator {
//    static var viewController: UIViewController {get}
//}
//
