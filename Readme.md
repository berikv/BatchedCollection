# BatchedCollection - Form Batches from Swift Collection types

**BatchedCollection** is a Swift library that allows you to form batches. These batches have a set maximum count of consecutive elements. The library works with all Swift collection types.

A batch is a group of consecutive elements from the collection. The batch has a given maximum size.

<img alt="Batched diagram created by ChatGPT" src="batchedgpt.webp" width="500">

## Key Features

* Efficient O(1) implementation
* Simple API
* Supports all Swift collection types

## Installation

Add the following to your `Package.swift` file:

    dependencies: [
        .package(url: "https://github.com/berikv/BatchedCollection.git", from: "0.0.1")
    ]

## Usage

### Basic example

Form batches from an array:

    let batched = Array(0..<7).batched(by: 3)
    
    print(Array(batched[0])) // prints "[0, 1, 2]"
    print(Array(batched[1])) // prints "[3, 4, 5]"
    print(Array(batched[2])) // prints "[6]"

### Practical example

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

### Detailed Explanation

The `batched(by:)` function extends collection types to split their elements into batches of a specified size. This is particularly useful when processing large collections in chunks to optimize performance or to meet certain constraints. The return type of `batched(by:)` is a  

<img alt="Batched diagram" src="batched.png" width="500">

### O(1) Implementation

The implementation of batched(by:) is highly efficient, with O(1) complexity for creating the BatchedSubSequence.
Together with Swifts zero-cost abstraction, this means that `.batched(by:)` is theoretically as efficient as it can be!

## Contribution

Contributions are welcome!

## License

You are free to use this software (see License.md).
I would appreciate it if you let me know if this was useful for you.