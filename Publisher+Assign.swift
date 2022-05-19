//
//  Publisher+Assign.swift
//  MakeItSo
//

//  Copyright © 2020 Google LLC. All rights reserved.
//

import Combine

/// https://forums.swift.org/t/does-assign-to-produce-memory-leaks/29546/11
extension Publisher where Failure == Never {
  func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
    sink { [weak root] in
      root?[keyPath: keyPath] = $0
    }
  }
}
