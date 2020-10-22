import XCTest
import SwiftPackageManifest

final class PackageDecodingTests: XCTestCase {
    func testDecodePackageDump() throws {
        let decoder = JSONDecoder()
        let package = try decoder.decode(Package.self, from: Fixtures.example)

        XCTAssertEqual(package.name, "Example")
        XCTAssertEqual(package.toolsVersion, "5.1.0")

        XCTAssertEqual(package.products.count, 2)
        XCTAssertEqual(package.products[0].name, "swift-doc")
        XCTAssertEqual(package.products[0].targets, ["swift-doc"])
        XCTAssertEqual(package.products[0].type, .executable)
        XCTAssertEqual(package.products[1].name, "SwiftDoc")
        XCTAssertEqual(package.products[1].targets, ["SwiftDoc"])
        XCTAssertEqual(package.products[1].type, .library)

        XCTAssertEqual(package.dependencies.count, 9)
        XCTAssertEqual(package.dependencies[0].name, "swift-syntax")
        XCTAssertEqual(package.dependencies[0].url, "https://github.com/apple/swift-syntax.git")
        XCTAssertEqual(package.dependencies[0].requirement, .revision(["0.50200.0"]))

        XCTAssertEqual(package.targets.count, 5)
        XCTAssertEqual(package.targets[0].type, .regular)
        XCTAssertEqual(package.targets[0].name, "swift-doc")
        XCTAssertNil(package.targets[0].path)
        XCTAssertEqual(package.targets[0].dependencies, ["ArgumentParser", "SwiftDoc", "SwiftSemantics", "SwiftMarkup", "CommonMarkBuilder", "HypertextLiteral", "Markup", "DCOV", "GraphViz", "SwiftSyntaxHighlighter"])
        XCTAssertEqual(package.targets[0].resources, [])
        XCTAssertEqual(package.targets[0].settings, [])

        XCTAssertEqual(package.targets[4].type, .system)
        XCTAssertEqual(package.targets[4].name, "libxml2")
        XCTAssertEqual(package.targets[4].path, "Modules")
        XCTAssertEqual(package.targets[4].dependencies, [])
        XCTAssertEqual(package.targets[4].providers, [.apt(["libxml2-dev"])])
        XCTAssertEqual(package.targets[4].resources, [])
        XCTAssertEqual(package.targets[4].settings, [])
    }

    func testExactDependency() throws {
        let decoder = JSONDecoder()
        let package = try decoder.decode(Package.self, from: Fixtures.xcparseDump)

        XCTAssertEqual(package.toolsVersion, "5.1.0")
        XCTAssertEqual(package.dependencies.count, 1)
        XCTAssertEqual(package.dependencies[0].url, "https://github.com/apple/swift-package-manager.git")
        XCTAssertEqual(package.dependencies[0].requirement, .exact(["0.5.0"]))
    }
}
