# BatchedCollection - Form Batches from Swift Collections

**BatchedCollection** is a library designed to help you group elements from any Swift collection into batches of a specified size. This is particularly useful for features like pagination or feeding input to a system that only accepts a certain maximum number of inputs, like a SIMD vector.

A batch groups subsequent elements of a collection into batches with a maximum size that you define.

## Key Features

* Efficient O(1) implementation
* Simple API
* Supports all Swift collection types

## Installation

Add the following to your `Package.swift` file:

    dependencies: [
        .package(url: "https://github.com/berikv/BatchedCollection.git", from: "0.0.2")
    ]

## Usage

### Basic examples

Form batches of a Range:

    let batches = (0..<7).batched(by: 3)
    
    batches[0] == 0..<3 // true, because `Range.SubSequence == Range`
    batches[2] == 6..<7 // true

Form batches from an Array:

    let batches = Array(0..<7).batched(by: 3)
    
    print(Array(batches[0])) // prints "[0, 1, 2]"
    print(Array(batches[1])) // prints "[3, 4, 5]"
    print(Array(batches[2])) // prints "[6]"

### Practical example

<p>
    <img src="fair.webp" width="500" alt>
    <em>
    <br/>
    A Carousel can only hold so many people.
    </em>
</p>

Imagine writing a fair simulator where the carousel only allows **34 visitors at a time**. You can batch the visitors into groups of 34:

    while parkIsOpen {
        let visitors = await getQueuedCarouselVisitors()
        for batch in visitors.batched(by: 34) {
            await carousel.clear()
            await carousel.board(batch)
            await carousel.run()
        }
    }

To make this work, `carousel.board()` accepts a collection of visitors:

    extension Carousel {
        func board(_ passengers: some Collection<Visitors>) async { ... }
    }

### Concrete example

Another example where this can be useful is in source rewriting. A long
list of integers may look unwieldy:

    let numbers = [3, 48, 23, 32, 55, 50, 71, 14, 93, 43, 66, 25, 9, 35, 59, 40, 45, 75, 88, 35, 62, 17, 16, 74, 32, 35, 39, 37, 4, 97, 67, 49, 95, 50, 9, 14, 85, 79, 24, 78, 85, 72, 1, 79, 1, 53, 39, 1, 48, 74]

A small formatting script can help, by batching the numbers by e.g. 8:

    let description = numbers
        .batched(by: 8)
        .map { batch in batch
            .map { String(format: "%02d", $0) }
            .joined(separator: ", ")
        }
        .joined(separator: "\n    ")

    print("let numbers = [\n    \(description)]") // copy paste the new `let numbers` definition

When the numbers are listed 8 per line, the list can be **much easier** to parse:

    let numbers = [
        03, 48, 23, 32, 55, 50, 71, 14
        93, 43, 66, 25, 09, 35, 59, 40
        45, 75, 88, 35, 62, 17, 16, 74
        32, 35, 39, 37, 04, 97, 67, 49
        95, 50, 09, 14, 85, 79, 24, 78
        85, 72, 01, 79, 01, 53, 39, 01
        48, 74]

### Detailed Explanation

The `batched(by:)` function extends collection types to split their elements into batches of a specified size. This is particularly useful when processing large collections in chunks to optimize performance or to meet certain constraints. The return type of `batched(by:)` is a BatchedSubSequence, which itself is a collection of Collection.SubSequence of the original collection:

<p>
    <img src="batched.png" width="500" alt>
    <em>
    <br/>
    Memory layout of a BatchedSubSequence consists of an integer to hold the batch size, followed by the memory of the underlying collection.
    </em>
</p>

### O(1) Implementation

The implementation of batched(by:) is highly efficient, with O(1) complexity for creating the BatchedSubSequence.
Together with Swifts zero-cost abstraction, this means that `.batched(by:)` is theoretically as efficient as it can be!

## Contribution

Contributions are welcome!

## License

You are free to use this software (see License.md).
I would appreciate it if you let me know if this was useful for you.
