//
//  PieChartTests.swift
//  PieChartTests
//
//  Created by Amin on 12/14/1399 AP.
//

import XCTest
@testable import PieChart

class PieChartTests: XCTestCase {

    var sut:DonutChart!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = DonutChart()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFrom()  {
        // these test are for 6 degree whiteSpace and lineWidth of 10
        let fromIndex0 = sut.from(for: 0)
        let fromIndex1 = sut.from(for: 1)
        let fromIndex2 = sut.from(for: 2)
        let fromIndex3 = sut.from(for: 3)
        let fromIndex4 = sut.from(for: 4)
//        let fromIndex5 = sut.from(for: 5)
        
        XCTAssertEqual(fromIndex0, 0)
        XCTAssertEqual(fromIndex1, 0.305)
        XCTAssertEqual(fromIndex2, 0.589)
        XCTAssertEqual(fromIndex3, 0.789,accuracy: 0.001)
        XCTAssertEqual(fromIndex4, 0.926,accuracy:0.001)
//        XCTAssertEqual(fromIndex5, 1,accuracy:0.001)
        
    }
    func testTo() {
        let toIndex0 = sut.to(for: 0)
        let toIndex1 = sut.to(for: 1)
        let toIndex2 = sut.to(for: 2)
        let toIndex3 = sut.to(for: 3)
        let toIndex4 = sut.to(for: 4)
//        let toIndex5 = SUT.to(for: 5)
        
        XCTAssertEqual(toIndex0, 0.245,accuracy: 0.001)
        XCTAssertEqual(toIndex1, 0.529,accuracy: 0.001)
        XCTAssertEqual(toIndex2, 0.729,accuracy: 0.001)
        XCTAssertEqual(toIndex3, 0.866,accuracy: 0.001)
        XCTAssertEqual(toIndex4, 0.94,accuracy:0.001)
//        XCTAssertEqual(toIndex5, 1,accuracy:0.001)
    }
    
}
