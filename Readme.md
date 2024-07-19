# BatchedCollection - Form Batches from Swift Collection types

**BatchedCollection** is a Swift library that allows you to form batches. These batches have a set maximum count of consecutive elements. The library works with all Swift collection types.

A batch is a group of consecutive elements from the collection. The batch has a given maximum size.

<p>
    <img src="batchedgpt.webp" width="500" alt>
    <em>
    <br/>
    ChatGPT prompt: A detailed flow-diagram style image showing a collection being split into batches. The collection contains elements 0 until 7. Numbers 0 to 2 go into the first batch, numbers 3 to 5 go into the second batch, numbers 6 and 7 go into the third batch. Numbers are rendered in a circle and each batch is captured in a square box. The color theme is toned down and apt for technical / api documentation.
    </em>
</p>

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

### Basic example

Form batches from an array:

    let batched = Array(0..<7).batched(by: 3)
    
    print(Array(batched[0])) // prints "[0, 1, 2]"
    print(Array(batched[1])) // prints "[3, 4, 5]"
    print(Array(batched[2])) // prints "[6]"

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

By formatting the numbers by e.g. 8 per line, the list can be **much easier** to parse:

    let description = numbers
        .batched(by: 8)
        .map{ batch in batch.map { String(format: "%02d", $0) }.joined(separator: ", ") }
        .joined(separator: "\n")
    print("let numbers = [\n\(description)]")

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
