import Foundation

enum Fixtures {
    static let example = #"""
    {
        "cLanguageStandard": null,
        "cxxLanguageStandard": null,
        "dependencies": [
            {
                "name": "swift-syntax",
                "requirement": {
                    "revision": [
                        "0.50200.0"
                    ]
                },
                "url": "https:\/\/github.com\/apple\/swift-syntax.git"
            },
            {
                "name": "SwiftSemantics",
                "requirement": {
                    "range": [
                        {
                            "lowerBound": "0.1.0",
                            "upperBound": "0.2.0"
                        }
                    ]
                },
                "url": "https:\/\/github.com\/SwiftDocOrg\/SwiftSemantics.git"
            },
            {
                "name": "CommonMark",
                "requirement": {
                    "branch": [
                        "master"
                    ]
                },
                "url": "https:\/\/github.com\/SwiftDocOrg\/CommonMark.git"
            },
            {
                "name": "SwiftMarkup",
                "requirement": {
                    "range": [
                        {
                            "lowerBound": "0.0.5",
                            "upperBound": "0.1.0"
                        }
                    ]
                },
                "url": "https:\/\/github.com\/SwiftDocOrg\/SwiftMarkup.git"
            },
            {
                "name": "GraphViz",
                "requirement": {
                    "revision": [
                        "03405c13dc1c31f50c08bbec6e7587cbee1c7fb3"
                    ]
                },
                "url": "https:\/\/github.com\/SwiftDocOrg\/GraphViz.git"
            },
            {
                "name": "HypertextLiteral",
                "requirement": {
                    "range": [
                        {
                            "lowerBound": "0.0.2",
                            "upperBound": "0.1.0"
                        }
                    ]
                },
                "url": "https:\/\/github.com\/NSHipster\/HypertextLiteral.git"
            },
            {
                "name": "Markup",
                "requirement": {
                    "range": [
                        {
                            "lowerBound": "0.0.3",
                            "upperBound": "0.1.0"
                        }
                    ]
                },
                "url": "https:\/\/github.com\/SwiftDocOrg\/Markup.git"
            },
            {
                "name": "SwiftSyntaxHighlighter",
                "requirement": {
                    "revision": [
                        "1.0.0"
                    ]
                },
                "url": "https:\/\/github.com\/NSHipster\/SwiftSyntaxHighlighter.git"
            },
            {
                "name": "swift-argument-parser",
                "requirement": {
                    "range": [
                        {
                            "lowerBound": "0.0.2",
                            "upperBound": "0.1.0"
                        }
                    ]
                },
                "url": "https:\/\/github.com\/apple\/swift-argument-parser.git"
            }
        ],
        "name": "Example",
        "pkgConfig": null,
        "platforms": [
            {
                "platformName": "macos",
                "version": "10.10"
            },
            {
                "platformName": "ios",
                "version": "9.0"
            },
            {
                "platformName": "tvos",
                "version": "9.0"
            }
        ],
        "products": [
            {
                "name": "swift-doc",
                "targets": [
                    "swift-doc"
                ],
                "type": {
                    "executable": null
                }
            },
            {
                "name": "SwiftDoc",
                "targets": [
                    "SwiftDoc"
                ],
                "type": {
                    "library": [
                        "automatic"
                    ]
                }
            }
        ],
        "providers": null,
        "swiftLanguageVersions": null,
        "targets": [
            {
                "dependencies": [
                    {
                        "byName": [
                            "ArgumentParser"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftDoc"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftSemantics"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftMarkup"
                        ]
                    },
                    {
                        "byName": [
                            "CommonMarkBuilder"
                        ]
                    },
                    {
                        "byName": [
                            "HypertextLiteral"
                        ]
                    },
                    {
                        "byName": [
                            "Markup"
                        ]
                    },
                    {
                        "byName": [
                            "DCOV"
                        ]
                    },
                    {
                        "byName": [
                            "GraphViz"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftSyntaxHighlighter"
                        ]
                    }
                ],
                "exclude": [],
                "name": "swift-doc",
                "resources": [],
                "settings": [],
                "type": "regular"
            },
            {
                "dependencies": [],
                "exclude": [],
                "name": "DCOV",
                "resources": [],
                "settings": [],
                "type": "regular"
            },
            {
                "dependencies": [
                    {
                        "byName": [
                            "SwiftSyntax"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftSemantics"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftMarkup"
                        ]
                    }
                ],
                "exclude": [],
                "name": "SwiftDoc",
                "resources": [],
                "settings": [],
                "type": "regular"
            },
            {
                "dependencies": [
                    {
                        "byName": [
                            "SwiftDoc"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftSyntax"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftSemantics"
                        ]
                    },
                    {
                        "byName": [
                            "SwiftMarkup"
                        ]
                    }
                ],
                "exclude": [],
                "name": "SwiftDocTests",
                "resources": [],
                "settings": [],
                "type": "test"
            },
            {
                "dependencies": [],
                "exclude": [],
                "name": "libxml2",
                "path": "Modules",
                "pkgConfig": "libxml-2.0",
                "providers": [
                    {
                        "apt": [
                            [
                                "libxml2-dev"
                            ]
                        ]
                    }
                ],
                "resources": [],
                "settings": [],
                "type": "system"
            },
        ],
        "toolsVersion": {
            "_version": "5.1.0"
        }
    }
    """#.data(using: .utf8)!

    /// Generated from https://github.com/blaquez/xcparse/blob/61bfe78c55e2e0fc2bc3d3d49add3dbd3829a56b/Package.swift
    /// using `Apple Swift version 5.2.4 (swiftlang-1103.0.32.9 clang-1103.0.32.53)`
    /// Contains 'exact' version requirement
    static let xcparseDump = #"""
    {
        "cLanguageStandard" : null,
        "cxxLanguageStandard" : null,
        "dependencies" : [
            {
            "name" : "swift-package-manager",
            "requirement" : {
                "exact" : [
                "0.5.0"
                ]
            },
            "url" : "https:\/\/github.com\/apple\/swift-package-manager.git"
            }
        ],
        "name" : "xcparse",
        "pkgConfig" : null,
        "platforms" : [
            {
            "platformName" : "macos",
            "version" : "10.13"
            }
        ],
        "products" : [
            {
            "name" : "xcparse",
            "targets" : [
                "xcparse"
            ],
            "type" : {
                "executable" : null
            }
            },
            {
            "name" : "XCParseCore",
            "targets" : [
                "XCParseCore"
            ],
            "type" : {
                "library" : [
                "automatic"
                ]
            }
            }
        ],
        "providers" : null,
        "swiftLanguageVersions" : [
            "5"
        ],
        "targets" : [
            {
            "dependencies" : [
                {
                "byName" : [
                    "XCParseCore"
                ]
                },
                {
                "byName" : [
                    "SPMUtility"
                ]
                }
            ],
            "exclude" : [

            ],
            "name" : "xcparse",
            "resources" : [

            ],
            "settings" : [

            ],
            "type" : "regular"
            },
            {
            "dependencies" : [
                {
                "byName" : [
                    "SPMUtility"
                ]
                }
            ],
            "exclude" : [

            ],
            "name" : "XCParseCore",
            "resources" : [

            ],
            "settings" : [

            ],
            "type" : "regular"
            },
            {
            "dependencies" : [
                {
                "byName" : [
                    "xcparse"
                ]
                }
            ],
            "exclude" : [

            ],
            "name" : "xcparseTests",
            "resources" : [

            ],
            "settings" : [

            ],
            "type" : "test"
            }
        ],
        "toolsVersion" : {
            "_version" : "5.1.0"
        }
    }
    """#.data(using: .utf8)!
}
