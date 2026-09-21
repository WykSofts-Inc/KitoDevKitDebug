// swift-tools-version: 5.9
//
//  Package.swift
//  KitoDevKitDebug
//
//  Created by Wycliff on 9/21/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//


import PackageDescription

// This file is the debug-tooling BOM analog — see KitoDevKit/docs/VERSIONING.md
// Track B for the pinning rule. Kept as a SEPARATE package from KitoDevKit,
// never merged into it: that separation is what stops `import KitoDevKit`
// from silently shipping a network interceptor to production. See README.

let package = Package(
    name: "KitoDevKitDebug",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "KitoDevKitDebug", targets: ["KitoDevKitDebug"]),
    ],
    dependencies: [
        .package(url: "https://github.com/WykSofts-Inc/KitoNetKit.git", exact: "1.0.0"),
        .package(url: "https://github.com/WykSofts-Inc/KitoFillKit.git", exact: "1.0.0"),
    ],
    targets: [
        .target(
            name: "KitoDevKitDebug",
            dependencies: [
                .product(name: "KitoNetKit", package: "KitoNetKit"),
                .product(name: "KitoFillKit", package: "KitoFillKit"),
            ]
        ),
        .testTarget(name: "KitoDevKitDebugTests", dependencies: ["KitoDevKitDebug"]),
    ]
)
