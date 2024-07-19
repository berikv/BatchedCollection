
extension Collection {
    /**
     Splits the collection into batches of the specified size.

     This method returns a `BatchedSubSequence`, which is a view into the original collection,
     divided into subsequences of up to `batchSize` elements. This is useful for processing
     large collections in manageable chunks, such as when paginating results or processing
     data in parallel.

     - Parameter batchSize: The maximum number of elements in each batch. Must be greater than zero.
     - Returns: A `BatchedSubSequence` representing the original collection split into batches.

     # Example #
     ```
     let batched = Array(0..<7).batched(by: 3)

     print(Array(batched[0])) // prints "[0, 1, 2]"
     print(Array(batched[1])) // prints "[3, 4, 5]"
     print(Array(batched[2])) // prints "[6]"
     ```

     - Note: The last batch may contain fewer than `batchSize` elements if the total number
       of elements in the collection is not a multiple of `batchSize`.

     - Precondition: `batchSize` must be greater than zero.

     - Complexity: O(1) for creating the `BatchedSubSequence`. Accessing each batch has a complexity of O(1),
       and accessing elements within a batch has the same complexity as accessing elements
       in the original collection.
     */
    @inlinable @inline(__always)
    func batched(by batchSize: Int) -> BatchedSubSequence<Self> {
        return BatchedSubSequence(collection: self, batchSize: batchSize)
    }
}
