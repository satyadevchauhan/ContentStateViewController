//
//  FirstViewController.swift
//  ContainerViewController
//
//  Created by Satyadev Chauhan on 07/01/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    private lazy var stateViewController = ContentStateViewController()
    
    private var filePath = Bundle.main.url(forResource: "products", withExtension: "json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(stateViewController)
        loadProduct()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadProduct))
    }
    
    private func render(_ product: Product) {
        DispatchQueue.main.async { [weak self] in
            let contentVC = ProductViewController(product: product)
            self?.stateViewController.transition(to: .render(contentVC))
        }
    }
    
    private func render(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.stateViewController.transition(to: .failed(error))
        }
    }
    
    @objc func loadProduct() {
        stateViewController.transition(to: .loading)
        DispatchQueue.global().async { [weak self] in
            self?.getProduct { result in
                self?.parseResponse(result)
            }
        }
    }
    
    fileprivate func parseResponse(_ result: Result<Data, Error>) {
        switch result {
        case .success( _):
            do {
                let product = try result.decoded() as Products
                render(product.products.randomElement()!)
            } catch {
                render(error)
            }
        case .failure(let error):
            render(error)
            // Since we now know the type of 'error', we can easily
            // switch on it to perform much better error handling
            // for each possible type of error.
            /*switch error {
             case .networkUnavailable:
             self?.showErrorView(withMessage: .offline)
             case .timedOut:
             self?.showErrorView(withMessage: .timedOut)
             case .invalidStatusCode(let code):
             self?.showErrorView(withMessage: .statusCode(code))
             }*/
        }
    }
}

extension FirstViewController {
    
    func getProduct(_ completion: @escaping (Result<Data, Error>) -> Void) {
        if let filePath = filePath {
            do {
                let data = try Data(contentsOf: filePath)
                sleep(2)
                completion(.success(data))
            }
            catch {
                let error = NSError(domain: "Domain", code: 100, userInfo: ["errorCode" : 100, "errorMessage" : "Parser failed."])
                completion(.failure(error))
            }
        }
        else {
            let error = NSError(domain: "Domain", code: 101, userInfo: ["errorCode" : 101, "errorMessage" : "API failed."])
            completion(.failure(error))
        }
    }
}
