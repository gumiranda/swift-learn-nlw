//
//  BelezixFlowController.swift
//  Belezix
//
//  Created by Gustavo Miranda de Aguiar on 16/12/24.
//

import Foundation
import UIKit

class BelezixFlowController {
    private var navigationController: UINavigationController?

    public init(){
        
    }
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
        let startViewController = SplashViewController(contentView: contentView)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}
