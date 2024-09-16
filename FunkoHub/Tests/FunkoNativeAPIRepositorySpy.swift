//
//  FunkoNativeAPIRepositorySpy.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
@testable import FunkoHub

class FunkoNativeAPIRepositorySpy: FunkoNativeAPIRespository {
    
    var getFunkosCalled = false
    
    var isFailure = false
    
    override func getFunkos(completion: @escaping ([Funko]) -> Void) {
        getFunkosCalled = true
        let data = Funko(name: "test", type: .AOT, price: 0.0, date: Date())
        completion([data])
    }
}
