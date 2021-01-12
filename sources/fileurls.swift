//
//  fileurls.swift
//  dynamic_desktop
//
//  Created by Jonathan Haenchen on 1/11/21.
//
import Foundation
import AppKit

let home = FileManager.default.homeDirectoryForCurrentUser
let filePath = "opt/images/"
let sourceDir = home.appendingPathComponent(filePath)
func contentsOf(atPath: URL) -> [URL] {
    let fileManager = FileManager.default
    do {
      let contents = try fileManager.contentsOfDirectory(atPath: sourceDir.path)
      let urls = contents.map { return sourceDir.appendingPathComponent($0) }
      return urls
    } catch {
      return []
    }
}
