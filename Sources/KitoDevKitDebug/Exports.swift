//
//  Exports.swift
//  KitoDevKitDebug
//
//  Created by Wycliff on 9/21/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//

// The developer/QA umbrella — every DevKit debug tool, in one dependency.
// Intended for a DEBUG-only dependency (SPM has no `debugImplementation`;
// consumers gate the import with `#if DEBUG`, see README). Contains no
// source of its own — mirrors KitoDevKit's umbrella shape exactly, just for
// the tools that must never reach a release build.

#if DEBUG
@_exported import KitoNetKit
@_exported import KitoFillKit
#endif
