//
//  Chain.swift
//  
//
//  Created by Adam Salih on 11.10.2022.
//

import Foundation

@dynamicMemberLookup
public protocol ChainedTypeWrapper: TypeWrapper {
    associatedtype NextWrapperType: TypeWrapper

    var wrapper: NextWrapperType { get set }

    subscript<L>(dynamicMember keyPath: WritableKeyPath<NextWrapperType, L>) -> L { get }
}

public extension ChainedTypeWrapper {
    subscript<L>(dynamicMember keyPath: WritableKeyPath<NextWrapperType, L>) -> L {
        get { wrapper[keyPath: keyPath] }
        set { wrapper[keyPath: keyPath] = newValue }
    }
}

public struct Chaining<CurrentType: Inheritable, ChainType: TypeWrapper>: ChainedTypeWrapper {
    public typealias NextWrapperType = ChainType
    public typealias CurrentType = CurrentType

    public var current: CurrentType?
    public weak var delegate: ChainingDelegate?
    public var wrapper: NextWrapperType

    public init(delegate: ChainingDelegate?) {
        self.current = nil
        self.delegate = delegate
        self.wrapper = .init(delegate: delegate)
    }
}

public protocol ChainingDelegate: AnyObject {
    func recevied<Value>(new value: Value)
}
