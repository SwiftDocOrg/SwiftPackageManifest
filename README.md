# SwiftPackageManifest

![CI][ci badge]
[![Documentation][documentation badge]][documentation]

A package that provides information about a Swift package,
as encoded by running `swift package dump-package`
in a directory containing a valid `Package.swift` manifest.

`SwiftPackageManifest` is similar to but distinct from
the Swift Package Manager's [`PackageDescription` module](https://developer.apple.com/documentation/swift_packages/package)
It's intended to be a lightweight, portable alternative
to the official library for the sole purpose of
reading generated Swift package manifests in JSON format.

> **Warning**:
> The format of `swift package dump-package` isn't versioned,
> and any changes to this format between Swift releases
> may cause decoding to fail.

## Usage

In a directory containing a valid `Package.swift` manifest,
run the following command to generate a JSON representation:

```terminal
$ swift package dump-package > Package.json
```

Read the contents of that file
and use `JSONDecoder` to deserialize a `Package` object from it:

```swift
import Foundation
import SwiftPackageManifest

let json = try! Data(contentsOfFile: "path/to/Package.json", options: [])
let decoder = JSONDecoder()
let package = try decoder.decode(Package.self, from: json)
```

## Installation

### Swift Package Manager

Add the SwiftPackageManifest package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/SwiftDocOrg/SwiftPackageManifest",
        from: "0.1.0"
    ),
  ]
)
```

Add `SwiftPackageManifest` as a dependency to your target(s):

```swift
targets: [
.target(
    name: "YourTarget",
    dependencies: ["SwiftPackageManifest"]),
```

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))

[ci badge]: https://github.com/SwiftDocOrg/SwiftPackageManifest/workflows/CI/badge.svg
[documentation badge]: https://github.com/SwiftDocOrg/SwiftPackageManifest/workflows/Documentation/badge.svg
[documentation]: https://github.com/SwiftDocOrg/SwiftPackageManifest/wiki
