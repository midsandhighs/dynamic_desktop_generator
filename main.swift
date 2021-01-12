//
//  filepath.swift
//  
//
//  Created by Jonathan Haenchen on 1/11/21.
//

import Foundation
import AppKit
import AVFoundation


let outputURL = URL(fileURLWithPath: "output1.heic")

// TODO: convert value of contentsOf from the file URL to the expected type for the DynamicDesktop struct
let dynamicDesktop = DynamicDesktop((contentsOf(atPath: sourceDir)

//
//print(contentsOf(atPath: sourceDir))

guard let imageDestination = CGImageDestinationCreateWithURL(
                                outputURL as CFURL,
                                AVFileType.heic as CFString,
                                dynamicDesktop.images.count,
                                nil
                             ) else {
    fatalError("Error creating image destination")
}

for (index, image) in dynamicDesktop.images.enumerated() {
    if index == 0 {
        let imageMetadata = CGImageMetadataCreateMutable()
        guard let tag = CGImageMetadataTagCreate(
                            "http://ns.apple.com/namespace/1.0/" as CFString,
                            "apple_desktop" as CFString,
                            "solar" as CFString,
                            .string,
                            try! dynamicDesktop.base64EncodedMetadata() as CFString
                        ),
            CGImageMetadataSetTagWithPath(
                imageMetadata, nil, "xmp:solar" as CFString, tag
            )
        else {
            fatalError("Error creating image metadata")
        }
        
        CGImageDestinationAddImageAndMetadata(imageDestination, image.cgImage, imageMetadata, nil)
    } else {
        CGImageDestinationAddImage(imageDestination, image.cgImage, nil)
    }
}

guard CGImageDestinationFinalize(imageDestination) else {
    fatalError("Error finalizing image")
}



let output = NSImage(contentsOf: outputURL)
