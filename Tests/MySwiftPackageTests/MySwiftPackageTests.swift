import Testing
@testable import SmartuiXcui

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

import XCTest
import UIKit
@testable import SmartuiXcui  // Replace with your package name

final class MySwiftPackageTests: XCTestCase {

    func testCaptureScreenshot() async {
        let ltApp = LTApp()

        let screenshot = await ltApp.screenshot(name: "abc")
        
        XCTAssertNotNil(screenshot, "Screenshot should not be nil")
    }
}
