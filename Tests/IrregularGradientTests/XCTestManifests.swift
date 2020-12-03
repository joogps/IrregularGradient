import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IrregularGradientTests.allTests),
    ]
}
#endif
