# KitoDevKitDebug

The developer/QA umbrella — every Kito debug tool in one dependency:
[KitoNetKit](https://github.com/WykSofts-Inc/KitoNetKit) (network condition
simulation) and [KitoFillKit](https://github.com/WykSofts-Inc/KitoFillKit)
(synthetic form data). Mirrors
[KitoDevKit](https://github.com/WykSofts-Inc/KitoDevKit)'s shape exactly —
same pinning rule, same "no source of its own" umbrella pattern — but kept
as a **separate package**, on purpose.

## Why this is a separate package, not part of KitoDevKit

Swift Package Manager has no `debugImplementation` the way Gradle does.
There's no manifest declaration that says "this dependency exists only in
debug builds" — the resolver always fetches and links whatever's declared.
So the boundary has to be enforced by *humans not typing the wrong import*,
which means the two umbrellas must be separate packages: `import KitoDevKit`
must never be able to pull in a network interceptor, no matter what.

```swift
.package(url: "https://github.com/WykSofts-Inc/KitoDevKit.git", from: "1.0.0"),

#if DEBUG
.package(url: "https://github.com/WykSofts-Inc/KitoDevKitDebug.git", from: "1.0.0"),
#endif
```

And in code:

```swift
#if DEBUG
import KitoDevKitDebug
#endif
```

The `#if DEBUG` guard is required at **both** the package declaration and
every import site — SPM will still link a `#if DEBUG`-free dependency into a
Release archive if it's unconditionally declared in `Package.swift`; the
conditional package reference is what actually keeps it out.

## Install

```swift
#if DEBUG
.package(url: "https://github.com/WykSofts-Inc/KitoDevKitDebug.git", from: "1.0.0"),
#endif
```

## Samples

```swift
#if DEBUG
import KitoDevKitDebug

// Network simulation
KitoNetKit.setScenario(KitoNetScenario(urlPattern: "api/pay", condition: .offline))

// Synthetic form data
let persona = KitoFillKit.randomPersona(seed: 42)
#endif
```

## Versioning

Follows the same Track B rule as KitoDevKit — see
[KitoDevKit/docs/VERSIONING.md](https://github.com/WykSofts-Inc/KitoDevKit/blob/main/docs/VERSIONING.md).
Pins are `.exact(...)`, never `from:`.

## License

MIT
