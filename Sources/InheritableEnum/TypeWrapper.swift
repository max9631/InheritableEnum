//
//  TypeWrapper.swift
//  
//
//  Created by Adam Salih on 11.10.2022.
//

import Foundation

public protocol TypeWrapper {
    associatedtype CurrentType

    var current: CurrentType? { get set }
    var delegate: ChainingDelegate? { get set }

    init(delegate: ChainingDelegate?)
}

public extension TypeWrapper where CurrentType: Inheritable {
    var value: CurrentType? {
        get { current }
        set {
            current = newValue
            if let value = newValue?.rawValue {
                delegate?.recevied(new: value)
            }
        }
    }
}

public struct Wrapping<CurrentType>: TypeWrapper {
    public var current: CurrentType?
    public weak var delegate: ChainingDelegate?

    public init(delegate: ChainingDelegate?) {
        current = nil
        self.delegate = delegate
    }
}
