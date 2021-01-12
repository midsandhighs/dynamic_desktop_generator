//
//  NSImage+CGImage.swift
//  
//
//  Created by Jonathan Haenchen on 1/11/21.
//

import Foundation
import AppKit

extension NSImage {
    public var cgImage: CGImage? {
        guard let imageData = self.tiffRepresentation,
            let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil)
        else {
            return nil
        }
        
        return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
    }
}
