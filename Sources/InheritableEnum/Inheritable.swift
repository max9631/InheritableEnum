//
//  Inheritable.swift
//  
//
//  Created by Adam Salih on 11.10.2022.
//

import Foundation

public struct NoneType {}

public protocol Inheritable: RawRepresentable {
    associatedtype Inherites = NoneType
    associatedtype NextWrapper: TypeWrapper = Wrapping<Inherites>
    associatedtype ChainType = Chaining<Self, NextWrapper>

    static func chain(with delegate: ChainingDelegate) -> ChainType
}

public extension Inheritable {
    static func chain(with delegate: ChainingDelegate) -> Chaining<Self, Wrapping<NoneType>> {
        .init(delegate: delegate)
    }
}

public extension Inheritable where Inherites: Inheritable {
    static func chain(with delegate: ChainingDelegate) -> Chaining<Self, Chaining<Inherites, Inherites.NextWrapper>> {
        .init(delegate: delegate)
    }
}
