//
//  main.swift
//  FocusedXCTest
//
//  Created by Stanislaw Pankevich on 13/02/2017.
//  Copyright © 2017 Stanislav Pankevich. All rights reserved.
//

import Foundation

import XCTest

class Test1: XCTestCase {
  func test_1() {
    XCTAssert(true)
  }

  func test_focus_2() {
    XCTAssert(false)
  }
}

class FocusTest2: XCTestCase {
  func test_1() {
    XCTAssert(true)
  }

  func test_2() {
    XCTAssert(false)
  }
}

class TestObserver: NSObject, XCTestObservation {
  var testsFailed = 0

  func testBundleWillStart(_ testBundle: Bundle) {
    //print("TestObserver.testBundleWillStart> \(testBundle)")
  }

  func testBundleDidFinish(_ testBundle: Bundle) {
    //print("TestObserver.testBundleDidFinish> \(testBundle)")
  }

  func testSuiteWillStart(_ testSuite: XCTestSuite) {
    //print("TestObserver.testSuiteWillStart> \(testSuite)")
  }

  func testSuiteDidFinish(_ testSuite: XCTestSuite) {
    //print("TestObserver.testSuiteDidFinish> \(testSuite)")
  }

  func testSuite(_ testSuite: XCTestSuite, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
    //print("TestObserver.testSuite:didFailWithDescription:> \(testSuite)")
  }

  func testCaseWillStart(_ testCase: XCTestCase) {
    //print("TestObserver.testCaseWillStart> \(testCase)")
  }

  func testCaseDidFinish(_ testCase: XCTestCase) {
    //print("testCaseDidFinish: \(testCase)")
  }

  func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
    //print("TestObserver.testCase:didFailWithDescription> \(testCase)")
    testsFailed += 1
  }
}


func RunXCTests() -> Int {
  let testObserver = TestObserver()

  let observationCenter = XCTestObservationCenter.shared()
  observationCenter.addTestObserver(testObserver)

  let defaultSuite = XCTestSuite.default()

  let focusedTestSuite = XCTestSuite(name: "Focused Test Suite")

  var testSuites = [defaultSuite]
  while let testSuite = testSuites.popLast() {
    print("Test suite: \(testSuite)")

    for testOrSuite in testSuite.tests {
      if let test = testOrSuite as? XCTestCase {
        /// Test should have `test_focus` in it to initiate a
        /// focused testing.
        if let testName = test.name, testName.contains("_focus_") {
          focusedTestSuite.addTest(test)
        }
      }

      else if let testSuite = testOrSuite as? XCTestSuite {
        if let testSuiteName = testSuite.name, testSuiteName.contains("Focus") {
          focusedTestSuite.addTest(testSuite)
        } else {
          testSuites.append(testSuite)
        }
      }

      else {
        print(testSuite)
      }
    }
  }

  if focusedTestSuite.tests.count > 0 {
    print("Focused tests were detected: running them in a custom test suite.")
    focusedTestSuite.run()
  } else {
    defaultSuite.run()
  }

  if (testObserver.testsFailed > 0) {
    return 1
  }

  return 0;
}

let result = RunXCTests()
exit(Int32(result))
