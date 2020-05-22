import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CapstoneProjectTests.allTests),
    ]
}
#endif
