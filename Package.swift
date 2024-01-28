// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MuPDFReader",
  platforms: [
    .macOS(.v11)
  ],
  dependencies: [
    .package(path: "../MuPDF")
  ],
  targets: [
    .executableTarget(
      name: "MuPDFReader",
      dependencies: ["MuPDF"],
      linkerSettings: [.unsafeFlags(["-L/opt/homebrew/lib"])]
    )
  ]

)
