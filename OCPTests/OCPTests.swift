//
//  OCPTests.swift
//  OCPTests
//
//  Created by WY NG on 10/11/2019.
//  Copyright © 2019 natalie. All rights reserved.
//

import XCTest
@testable import OCP

class OCPTests: XCTestCase {
    

    func testViewControllerNormalState() {
        let vc = ViewController(apiService: APIService())
        _ = vc.view
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            if case ViewControllerState.normal(_) = vc.state {
                
            } else {
                XCTFail()
            }
        }
    }
    
    func testViewControllerLoadingState() {
        let vc = ViewController(apiService: APIServiceMockLoading())
        _ = vc.view
        
        if case ViewControllerState.loading = vc.state {
            
        } else {
            XCTFail()
        }
    }
    
    func testViewControllerErrorState() {
        let vc = ViewController(apiService: APIServiceMockError())
        _ = vc.view
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            if case ViewControllerState.error(_) = vc.state {
                
            } else {
                XCTFail()
            }
        }
    }
    
    func testViewControllerEmptyState() {
        let vc = ViewController(apiService: APIServiceMockEmpty())
        _ = vc.view
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            if case ViewControllerState.empty = vc.state {
                
            } else {
                XCTFail()
            }
        }
    }
    
}
