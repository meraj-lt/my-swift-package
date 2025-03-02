//
//  Utils.swift
//  new swift package
//
//  Created by merajansari on 02/03/25.
//

import UIKit


class Utils {
    private let httpClient: HttpClient
    
    init() {
        self.httpClient = HttpClient()
    }
    
    @MainActor func screenshot(screenshotDetails: inout [String: String]) -> String? {
        guard let screenshotImage = takeScreenshot(),
              let imageData = screenshotImage.pngData() else {
            return nil
        }
        
        let base64String = imageData.base64EncodedString()
        screenshotDetails["screenshot"] = base64String
        return httpClient.postScreenshot(screenshotDetails: screenshotDetails)
    }
    
    func realDeviceScreenshot(realDeviceScreenshotDetails: [String: Any]) -> String? {
        return httpClient.postRealDeviceScreenshot(realDeviceScreenshotDetails: realDeviceScreenshotDetails)
    }
    
    @MainActor private func takeScreenshot() -> UIImage? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        let renderer = UIGraphicsImageRenderer(size: keyWindow?.bounds.size ?? .zero)
        return renderer.image { _ in
            keyWindow?.drawHierarchy(in: keyWindow?.bounds ?? .zero, afterScreenUpdates: true)
        }
    }
}
