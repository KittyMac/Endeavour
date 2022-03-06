import XCTest

@testable import EndeavourTests

XCTMain([
    testCase(EndeavourAppTests.allTests),
    testCase(EndeavourTests.allTests),
    testCase(EndeavourServerTests.allTests)
])
