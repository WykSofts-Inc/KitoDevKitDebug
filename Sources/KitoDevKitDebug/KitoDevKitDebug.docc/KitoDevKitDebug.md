# ``KitoDevKitDebug``

A debug-only umbrella that bundles every Kito developer and QA tool in one dependency.

## Overview

KitoDevKitDebug contains no source of its own. In `DEBUG` builds it re-exports
two packages, so a single import gives you both:

- **KitoNetKit** simulates network conditions, such as taking a matching
  endpoint offline, for testing error and retry paths.
- **KitoFillKit** generates synthetic form data, such as seeded random
  personas, for filling forms quickly during development.

It mirrors the shape of KitoDevKit but is kept as a separate package on
purpose. Swift Package Manager has no debug-only dependency declaration, so the
boundary is enforced by keeping the two umbrellas apart: `import KitoDevKit` can
never pull in a network interceptor.

Guard both the package declaration and every import site with `#if DEBUG`. The
conditional package reference is what keeps the tools out of a Release archive.

```swift
#if DEBUG
import KitoDevKitDebug

// Network simulation
KitoNetKit.setScenario(KitoNetScenario(urlPattern: "api/pay", condition: .offline))

// Synthetic form data
let persona = KitoFillKit.randomPersona(seed: 42)
#endif
```

The bundled packages are pinned with `exact:` versions rather than `from:`,
following the same versioning rule as KitoDevKit. See the documentation for
KitoNetKit and KitoFillKit for their full APIs.
