/**
 Defines the executables and libraries produced by a package,
 and makes them visible to other packages.
 */
public struct Product: Equatable {
    /// A product type.
    public enum `Type`: String, Hashable, CaseIterable, CodingKey {
        case library
        case executable
    }

    /// The type of product (`library` or `executable`).
    public let `type`: `Type`

    /// The name of the product.
    public let name: String

    /// The targets that comprise the product.
    public let targets: [String]
}

// MARK: Decodable

extension Product: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case targets
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let nestedContainer = try container.nestedContainer(keyedBy: `Type`.self, forKey: .type)
        guard let type = `Type`.allCases.first(where: { nestedContainer.contains($0) }) else {
            let context = DecodingError.Context(codingPath: nestedContainer.codingPath, debugDescription: "unknown or invalid type")
            throw DecodingError.dataCorrupted(context)
        }

        self.`type` = type

        self.name = try container.decode(String.self, forKey: .name)
        self.targets = try container.decode([String].self, forKey: .targets)
    }
}
