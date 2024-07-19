
@frozen
public struct BatchedSubSequence<C: Collection>: Collection {
    @usableFromInline
    let collection: C

    @usableFromInline
    let batchSize: Int

    public let startIndex: Int = 0
    public var endIndex: Int { (collection.count + batchSize - 1) / batchSize }

    @inlinable
    init(collection: C, batchSize: Int) {
        precondition(batchSize > 0, "batchSize must be greater than zero")
        self.collection = collection
        self.batchSize = batchSize
    }

    public subscript(position: Int) -> C.SubSequence {
        @inlinable
        get {
            precondition(position >= 0 && position < endIndex, "Index out of bounds")
            
            let startIndex = collection.index(collection.startIndex, offsetBy: position * batchSize)
            let distance = collection.distance(from: startIndex, to: collection.endIndex)
            let endIndex: C.Index

            if _fastPath(distance > batchSize) {
                endIndex = collection.index(startIndex, offsetBy: batchSize)
            } else {
                endIndex = collection.endIndex
            }

            return collection[startIndex..<endIndex]
        }
    }

    @inlinable @inline(__always)
    public func index(after i: Int) -> Int {
        i + 1
    }
}

extension BatchedSubSequence: BidirectionalCollection where C: BidirectionalCollection {
    @inlinable @inline(__always)
    public func index(before i: Int) -> Int {
        i - 1
    }
}
