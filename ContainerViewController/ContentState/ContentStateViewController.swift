//
//  ContentStateViewController.swift
//  ContainerViewController
//
//  Created by Satyadev Chauhan on 07/01/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

class ContentStateViewController: UIViewController {

    private var state: State?
    private var shownViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if state == nil {
            transition(to: .loading)
        }
    }
    
    func transition(to newState: State) {
        shownViewController?.remove()
        let vc = viewController(for: newState)
        add(vc)
        shownViewController = vc
        state = newState
    }

}

extension ContentStateViewController {
    
    enum State {
        case loading
        case failed(Error)
        case render(UIViewController)
    }
}

private extension ContentStateViewController {
    
    func viewController(for state: State) -> UIViewController {
        switch state {
        case .loading:
            return LoadingViewController()
        case .failed(let error):
            return ErrorViewController(error: error)
        case .render(let viewController):
            return viewController
        }
    }
}
