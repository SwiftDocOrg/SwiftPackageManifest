/**
 The basic building blocks of a package.

 A target can define a module or a test suite.

 Targets can depend on other targets in this package,
 and on products in packages which this package depends on.
 */
public struct Target: Equatable {
    /// A target type.
    public enum `Type`: String, Hashable, Decodable {
        case regular
        case test
        case system
    }

    public enum SystemPackageProvider: Equatable {
        /**
         A list of packages installed using
         the apt-get package manager on Ubuntu
         to create a system package provider instance.
        */

        case apt([String])

        /**
         A list of packages installed using
         the homebrew package manager on macOS
         to create a system package provider instance.
        */
        case brew([String])
    }

    /// The type of target (`regular`, `test`, or `system`)
    public let `type`: `Type`

    /// The name of the target.
    public let name: String

    /// The path to the target sources.
    public let path: String?

    /// The paths to sources that are excluded from the target.
    public let excludedPaths: [String]

    /// The names of the dependencies used by the target.
    public let dependencies: [String]

    /// The paths to resources bundled into the target.
    public let resources: [String]

    /// The settings specified for build the target.
    public let settings: [String]

    /// The name used for C modules.
    public let cModuleName: String?

    /// The providers of system packages used by the target.
    public let providers: [SystemPackageProvider]
}

// MARK: Decodable

extension Target: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case path
        case exclude
        case dependencies
        case resources
        case settings
        case providers
        case pkgConfig

        enum NestedDependencyCodingKeys: String, CodingKey {
            case byName
        }

        enum NestedSystemPackageProviderKeys: String, CodingKey {
            case apt
            case brew
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(`Type`.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.excludedPaths = try container.decode([String].self, forKey: .exclude)

        var dependencies: [String] = []
        do {
            var nestedUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .dependencies)
            while !nestedUnkeyedContainer.isAtEnd {
                let nestedKeyedContainer = try nestedUnkeyedContainer.nestedContainer(keyedBy: CodingKeys.NestedDependencyCodingKeys.self)
                let names = try nestedKeyedContainer.decode([String].self, forKey: .byName)
                dependencies.append(contentsOf: names)
            }
        }
        self.dependencies = dependencies

        self.resources = try container.decode([String].self, forKey: .resources)
        self.settings = try container.decode([String].self, forKey: .settings)

        var providers: [SystemPackageProvider] = []
        do {
            if var nestedUnkeyedContainer = try? container.nestedUnkeyedContainer(forKey: .providers) {
                while !nestedUnkeyedContainer.isAtEnd {
                    let nestedKeyedContainer = try nestedUnkeyedContainer.nestedContainer(keyedBy: CodingKeys.NestedSystemPackageProviderKeys.self)
                    if nestedKeyedContainer.contains(.apt) {
                        let packages = try nestedKeyedContainer.decode([[String]].self, forKey: .apt)
                        providers.append(.apt(packages.flatMap { $0 }))
                    } else if nestedKeyedContainer.contains(.brew) {
                        let packages = try nestedKeyedContainer.decode([[String]].self, forKey: .apt)
                        providers.append(.brew(packages.flatMap { $0 }))
                    } else {
                        let context = DecodingError.Context(codingPath: nestedKeyedContainer.codingPath, debugDescription: "unknown or invalid system package provider")
                        throw DecodingError.dataCorrupted(context)
                    }
                }
            }
        }
        self.providers = providers

        self.cModuleName = try container.decodeIfPresent(String.self, forKey: .pkgConfig)
    }
}
