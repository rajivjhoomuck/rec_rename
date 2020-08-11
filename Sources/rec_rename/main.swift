import Foundation
import ArgumentParser

private let fileManager = FileManager.default

struct Renamer: ParsableCommand {
  @Argument(help: "The directory from where to start the renaming")
  var dirPath: String

  @Argument(help: "The pattern to match against in the file names")
  var pattern: String

  @Argument(help: "The replacement text")
  var replace: String


  func validate() throws {
    print("⚠️: No validation is run for the provided directory path")
    guard pattern.count > 1 else {
      throw ValidationError("Validation failed: provided pattern is less than 2 characters.")
    }
  }

  func run() throws {
    try rename(startPath: dirPath, pattern: pattern, replacement: replace)
  }

  func rename(startPath: String, pattern: String, replacement: String) throws {
    // path is the full name of the item, not just the root
    func renameIfNeededItem(named item: String, at path: String, to replacement: String) throws {
      if let patternRange = item.range(of: pattern) {
        var itemCopy = item
        itemCopy.replaceSubrange(patternRange, with: replacement)
        let currentAbsolutePath = (path as NSString).appendingPathComponent(item)
        let targetAbsolutePath = (path as NSString).appendingPathComponent(itemCopy)

        try fileManager.moveItem(
          atPath: currentAbsolutePath,
          toPath: targetAbsolutePath
        )
      }
    }

    let items = try fileManager.contentsOfDirectory(atPath: startPath)
    for item in items {
      let dirPath = (startPath as NSString).appendingPathComponent(item)
      let fullItemPath = (startPath as NSString).appendingPathComponent(item)
      let fileWrapper = try FileWrapper(
        url: URL(fileURLWithPath: fullItemPath),
        options: .immediate
      )

      if fileWrapper.isDirectory {
        try rename(startPath: dirPath, pattern: pattern, replacement: replacement)
      }
      try renameIfNeededItem(named: item, at: startPath, to: replacement)
    }
  }
}

Renamer.main()
