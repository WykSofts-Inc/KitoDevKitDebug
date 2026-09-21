//
//  UmbrellaResolutionTests.swift
//  KitoDevKitDebug
//
//  Created by Wycliff on 9/21/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//

import XCTest
@testable import KitoDevKitDebug

// Proves `import KitoDevKitDebug` alone reaches both debug tools. If a kit is
// removed from Exports.swift or Package.swift, these calls fail to compile.

final class UmbrellaResolutionTests: XCTestCase {
    func testNetKitIsReExported() {
        #if DEBUG
        KitoNetKit.clearAll()
        XCTAssertTrue(KitoNetKit.scenarios.isEmpty)
        #endif
    }

    func testFillKitIsReExported() {
        #if DEBUG
        let persona = KitoFillKit.randomPersona(seed: 1)
        XCTAssertFalse(persona.email.isEmpty)
        #endif
    }
}
