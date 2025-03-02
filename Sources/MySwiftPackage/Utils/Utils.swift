//////
//////  Utils.swift
//////  new swift package
//////
//////  Created by merajansari on 02/03/25.
//////
////
////import UIKit
////
////
////class Utils {
////    private let httpClient: HttpClient
////    
////    init() {
////        self.httpClient = HttpClient()
////    }
////    
////    @MainActor func screenshot(screenshotDetails: inout [String: String]) -> String? {
////        do {
////            let base64String = try ScreenshotController().takeScreenshot()
////            screenshotDetails["screenshot"] = base64String
////            return httpClient.postScreenshot(screenshotDetails: screenshotDetails)
////        } catch {
////            print("Error taking screenshot: \(error)")
//////            throw LTAppError.postScreenshotError("Error posting screenshot")
////            return nil
////        }
////    }
////    
////    func realDeviceScreenshot(realDeviceScreenshotDetails: [String: Any]) -> String? {
////        return httpClient.postRealDeviceScreenshot(realDeviceScreenshotDetails: realDeviceScreenshotDetails)
////    }
////    
////}
//
//
//
//
//
//
////
////  Utils.swift
////  new swift package
////
////  Created by merajansari on 02/03/25.
////
//
//import UIKit
//
//
//class Utils {
//    private let httpClient: HttpClient
//    
//    init() {
//        self.httpClient = HttpClient()
//    }
//    
//    @MainActor func screenshot(screenshotDetails: inout [String: String]) -> String? {
//        do {
//            let base64String = try ScreenshotController().takeScreenshot()
//            print("screenshot string: ")
//            print(base64String)
//            screenshotDetails["screenshot"] = base64String
//            return httpClient.postScreenshot(screenshotDetails: screenshotDetails)
//        } catch {
//            print("Error taking screenshot: \(error)")
//            return nil
//        }
//    }
//    
//    func realDeviceScreenshot(realDeviceScreenshotDetails: [String: Any]) -> String? {
//        return httpClient.postRealDeviceScreenshot(realDeviceScreenshotDetails: realDeviceScreenshotDetails)
//    }
//    
//    @MainActor private func takeScreenshot() -> UIImage? {
//        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
//        let renderer = UIGraphicsImageRenderer(size: keyWindow?.bounds.size ?? .zero)
//        return renderer.image { _ in
//            keyWindow?.drawHierarchy(in: keyWindow?.bounds ?? .zero, afterScreenUpdates: true)
//        }
//    }
//}
//




import UIKit
import XCTest

class Utils {
    private let httpClient: HttpClient
    
    init() {
        self.httpClient = HttpClient()
    }
    
    @MainActor func screenshot(screenshotDetails: inout [String: String]) -> String? {
        do {
            let base64String = try takeScreenshot()
            print("screenshot string: \(base64String)")
            screenshotDetails["screenshot"] = base64String
            return httpClient.postScreenshot(screenshotDetails: screenshotDetails)
        } catch {
            print("Error taking screenshot: \(error)")
            return nil
        }
    }
    
    func realDeviceScreenshot(realDeviceScreenshotDetails: [String: Any]) -> String? {
        return httpClient.postRealDeviceScreenshot(realDeviceScreenshotDetails: realDeviceScreenshotDetails)
    }
    
    @MainActor private func takeScreenshot() throws -> String {
        let screenshot = XCUIScreen.main.screenshot()
        let imageData = screenshot.pngRepresentation
        return imageData.base64EncodedString()
    }
}
