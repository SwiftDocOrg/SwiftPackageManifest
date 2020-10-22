/**
 Information about a Swift package as provided by its manifest.

 Use `JSONDecoder` to decode a `Package` value
 from the output of running `swift package dump-package`
 in a directory containing a valid `Package.swift` manifest.

 - Important: This API is similar to but distinct from
              the Swift Package Manager's `PackageDescription` module
              (https://developer.apple.com/documentation/swift_packages/package).
              It's intended to be a lightweight, portable alternative
              to the official library for the sole purpose of
              reading generated Swift package manifests in JSON format.

 - Warning: The format of `swift package dump-package` isn't versioned,
            and any changes to this format between Swift releases
            may cause decoding to fail.
 */
public struct Package: Equatable {
    /// Declares other packages that this package depends on.
    public struct Dependency: Equatable {
        // Version requirements for the dependency.
        public enum Requirement {
            public typealias Range = (lowerBound: String, upperBound: String)

            /// A specific revision.
            case revision([String])

            /// A range of version numbers.
            case range([Range])

            /// A branch.
            case branch([String])

            /// An exact version
            case exact([String])
        }

        /// The name of the dependency.
        public let name: String?

        /// The URL for the dependency repository.
        public let url: String

        /// The version requirements for the dependency.
        public let requirement: Requirement
    }

    /// A platform that the Swift package supports.
    public struct SupportedPlatform: Decodable, Equatable {
        /// The name of the platform.
        let name: String

        /// The minimum deployment target of the platform.
        let minimumDeploymentTarget: String

        private enum CodingKeys: String, CodingKey {
            case name = "platformName"
            case minimumDeploymentTarget = "version"
        }
    }

    /// The name of the package.
    public let name: String

    /// The products provided by the package.
    public let products: [Product]

    /// The dependencies used by the package.
    public let dependencies: [Dependency]

    /// The targets defined in the package.
    public let targets: [Target]

    /// The platforms supported by the package.
    public let platforms: [SupportedPlatform]

    /// The name used for C modules.
    public let cModuleName: String?

    /// The C programming language standard used by the package.
    public let cLanguageStandard: String?

    /// The C++ programming language standard used by the package.
    public let cxxLanguageStandard: String?

    /// Declares the minimum version of Swift required to build this package.
    public let toolsVersion: String
}

// MARK: Decodable

extension Package: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case products
        case dependencies
        case targets
        case platforms
        case pkgConfig
        case cLanguageStandard
        case cxxLanguageStandard
        case toolsVersion

        enum NestedCodingKeys: String, CodingKey {
            case _version
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.products = try container.decode([Product].self, forKey: .products)
        self.dependencies = try container.decode([Dependency].self, forKey: .dependencies)
        self.targets = try container.decode([Target].self, forKey: .targets)
        self.platforms = try container.decode([SupportedPlatform].self, forKey: .platforms)

        self.cModuleName = try container.decode(String?.self, forKey: .pkgConfig)
        self.cLanguageStandard = try container.decode(String?.self, forKey: .cLanguageStandard)
        self.cxxLanguageStandard = try container.decode(String?.self, forKey: .cxxLanguageStandard)

        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.NestedCodingKeys.self, forKey: .toolsVersion)
        self.toolsVersion = try nestedContainer.decode(String.self, forKey: ._version)
    }
}

// MARK: -

// MARK: Decodable

extension Package.Dependency: Decodable {}

// MARK: -

// MARK: Equatable

extension Package.Dependency.Requirement: Equatable {
    public static func == (lhs: Package.Dependency.Requirement, rhs: Package.Dependency.Requirement) -> Bool {
        switch (lhs, rhs) {
        case let (.revision(l), .revision(r)),
             let (.exact(l), .exact(r)),
             let (.branch(l), .branch(r)):
            return l == r
        case let (.range(l), .range(r)):
            guard l.count == r.count else { return false }
            for case let ((ll, lu), (rl, ru)) in zip(l, r) {
                guard ll == rl, lu == ru else { return false }
            }
            return true
        default:
            return false
        }
    }
}

// MARK: Decodable

extension Package.Dependency.Requirement: Decodable {
    private enum CodingKeys: String, CodingKey {
        case revision
        case range
        case branch
        case exact

        enum NestedRangeCodingKeys: String, CodingKey {
          case lowerBound
          case upperBound
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.revision) {
            self = try .revision(container.decode([String].self, forKey: .revision))
        } else if container.contains(.range) {
            var nestedUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .range)

            var ranges: [Package.Dependency.Requirement.Range] = []
            while !nestedUnkeyedContainer.isAtEnd {
                let nestedContainer = try nestedUnkeyedContainer.nestedContainer(keyedBy: CodingKeys.NestedRangeCodingKeys.self)

                let lowerBound = try nestedContainer.decode(String.self, forKey: .lowerBound)
                let upperBound = try nestedContainer.decode(String.self, forKey: .upperBound)
                ranges.append((lowerBound: lowerBound, upperBound: upperBound))
            }

            self = .range(ranges)
        } else if container.contains(.branch) {
            self = try .branch(container.decode([String].self, forKey: .branch))
        } else if container.contains(.exact) {
            self = try .exact(container.decode([String].self, forKey: .exact))
        } else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "unknown or invalid requirement")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
