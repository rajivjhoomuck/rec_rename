// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "rec_rename",
  platforms: [.macOS("10.15")],
  products: [
    .executable(name: "rec_rename", targets: ["rec_rename"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.2.0")),
  ],
  targets: [
    .target(
      name: "rec_rename",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),
  ]
)
