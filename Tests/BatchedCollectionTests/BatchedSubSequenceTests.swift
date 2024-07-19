import XCTest
@testable import BatchedCollection

final class BatchedSubSequenceTests: XCTestCase {
    
    func testBatchedRangeCount() {
        let range: Range<Int> = 0..<42
        let batched = range.batched(by: 5)

        XCTAssertEqual(batched.count, 9)
    }

    func testBatchedRangeSubscript() {
        let range: Range<Int> = 0..<42
        let batched = range.batched(by: 5)
        print(Range<Int>.SubSequence.self == Range<Int>.self)
        

        XCTAssertEqual(batched[0], 0..<5)
        XCTAssertEqual(batched[4], 20..<25)
        XCTAssertEqual(batched[8], 40..<42)
    }

    func testBatchedRangeIteration() {
        let range: Range<Int> = 0..<42
        let batched = range.batched(by: 5)
        var seen = [Range<Int>]()

        for batch in batched {
            seen.append(batch)
        }

        let expected = [
            0..<5,
            5..<10,
            10..<15,
            15..<20,
            20..<25,
            25..<30,
            30..<35,
            35..<40,
            40..<42
        ]
        XCTAssertEqual(seen, expected)
    }

    func testBatchedClosedRangeCount() {
        let range: ClosedRange<Int> = 0...42
        let batched = range.batched(by: 5)

        XCTAssertEqual(batched.count, 9)
    }

    func testBatchedClosedRangeSubscript() {
        let range: ClosedRange<Int> = 0...42
        let batched = range.batched(by: 5)

        XCTAssertEqual(Array(batched[0]), Array(0..<5))
        XCTAssertEqual(Array(batched[4]), Array(20..<25))
        XCTAssertEqual(Array(batched[8]), Array(40..<43))
    }

    func testBatchedArrayCount() {
        let array: [Int] = Array(0..<42)
        let batched = array.batched(by: 5)
        
        XCTAssertEqual(batched.count, 9)
    }

    func testBatchedArraySubscript() {
        let array: [Int] = Array(0..<42)
        let batched = array.batched(by: 5)

        XCTAssertEqual(Array(batched[0]), Array(0..<5))
        XCTAssertEqual(Array(batched[4]), Array(20..<25))
        XCTAssertEqual(Array(batched[8]), Array(40..<42))
    }

    func testBatchedArrayIteration() {
        let array: [Int] = Array(0..<42)
        let batched = array.batched(by: 5)
        var seen = [ArraySlice<Int>]()

        for batch in batched {
            seen.append(batch)
        }

        let expected = [
            array[0..<5],
            array[5..<10],
            array[10..<15],
            array[15..<20],
            array[20..<25],
            array[25..<30],
            array[30..<35],
            array[35..<40],
            array[40..<42]
        ]
        XCTAssertEqual(seen, expected)
    }
}
