import Foundation

// Stripped down code from CHitch.swift in Hitch, modified to use UTF16

@usableFromInline
struct CHitch16 {
    @usableFromInline
    var capacity: Int = 0
    @usableFromInline
    var count: Int = 0
    @usableFromInline
    var copyOnWrite: Bool = false
    @usableFromInline
    var mutableData: UnsafeMutablePointer<UInt16>?
    @usableFromInline
    var castedMutableData: UnsafePointer<UInt16>?
    @usableFromInline
    var staticData: UnsafePointer<UInt16>?

    @inlinable @inline(__always)
    init() { }

    @inlinable @inline(__always)
    var universalData: UnsafePointer<UInt16>? {
        if castedMutableData != nil { return castedMutableData }
        return staticData
    }

    @inlinable @inline(__always)
    func description() -> String {
        guard let raw = universalData else { return "" }
        return String(utf16CodeUnitsNoCopy: raw,
                      count: count,
                      freeWhenDone: false)
    }
}

// MARK: - Utility

@inlinable @inline(__always)
func memcasecmp(_ ptr1: UnsafePointer<UInt16>,
                _ ptr2: UnsafePointer<UInt16>,
                _ count: Int,
                _ ignoreCase: Bool) -> Int32 {
    if ignoreCase {
        return ptr1.withMemoryRebound(to: CChar.self, capacity: count) { ptr1 in
            return ptr2.withMemoryRebound(to: CChar.self, capacity: count) { ptr2 in
                return strncasecmp(ptr1, ptr2, count)
            }
        }
    }
    return memcmp(ptr1, ptr2, count)
}

// MARK: - Memory Allocation

@inlinable @inline(__always)
func chitch16_internal_malloc(_ capacity: Int) -> UnsafeMutablePointer<UInt16>? {
    return malloc(capacity * 2)?.bindMemory(to: UInt16.self, capacity: capacity)
}

@inlinable @inline(__always)
func chitch16_internal_realloc(_ ptr: UnsafeMutablePointer<UInt16>?, _ capacity: Int) -> UnsafeMutablePointer<UInt16>? {
    guard let ptr = ptr else { return nil }
    return realloc(ptr, capacity * 2)?.bindMemory(to: UInt16.self, capacity: capacity)
}

@inlinable @inline(__always)
func chitch16_internal_free(_ ptr: UnsafeMutablePointer<UInt16>?) {
    guard let ptr = ptr else { return }
    free(ptr)
}

// MARK: - INIT

@inlinable @inline(__always)
func chitch16_empty() -> CHitch16 {
    return CHitch16()
}

@inlinable @inline(__always)
func chitch16_static(_ raw: UnsafePointer<UInt16>?, _ count: Int, _ copyOnWrite: Bool) -> CHitch16 {
    var c = CHitch16()
    c.count = count
    c.capacity = count
    c.staticData = raw
    c.copyOnWrite = copyOnWrite
    return c
}

@inlinable @inline(__always)
func chitch16_init_capacity(_ capacity: Int) -> CHitch16 {
    var c = CHitch16()
    c.count = 0
    c.capacity = capacity
    c.mutableData = chitch16_internal_malloc(capacity + 1)
    c.castedMutableData = UnsafePointer(c.mutableData)
    return c
}

@inlinable @inline(__always)
func chitch16_init_raw(_ raw: UnsafeMutablePointer<UInt16>?, _ count: Int) -> CHitch16 {
    guard let raw = raw else { return chitch16_empty() }
    var c = CHitch16()
    c.count = count
    c.capacity = count
    c.mutableData = chitch16_internal_malloc(count + 1)
    c.castedMutableData = UnsafePointer(c.mutableData)
    c.mutableData?.assign(from: raw, count: count)
    return c
}

@inlinable @inline(__always)
func chitch16_init_raw(_ raw: UnsafePointer<UInt16>?, _ count: Int) -> CHitch16 {
    guard let raw = raw else { return chitch16_empty() }
    var c = CHitch16()
    c.count = count
    c.capacity = count
    c.mutableData = chitch16_internal_malloc(count + 1)
    c.castedMutableData = UnsafePointer(c.mutableData)
    c.mutableData?.assign(from: raw, count: count)
    return c
}

@inlinable @inline(__always)
func chitch16_init_string(_ string: String) -> CHitch16 {
    var new = chitch16_init_capacity(string.lengthOfBytes(using: .utf16))
    chitch16_concat_string(&new, string)
    return new
}

@inlinable @inline(__always)
func chitch16_init_substring(_ c0: CHitch16, _ lhs_positions: Int, _ rhs_positions: Int) -> CHitch16 {
    let size = rhs_positions - lhs_positions
    guard size > 0 && size <= c0.count else { return CHitch16() }
    guard lhs_positions >= 0 && lhs_positions <= c0.count else { return CHitch16() }
    guard rhs_positions >= 0 && rhs_positions <= c0.count else { return CHitch16() }

    if let c0_data = c0.mutableData {
        return chitch16_init_raw(c0_data + lhs_positions, size)
    }
    if let c0_data = c0.staticData {
        return chitch16_init_raw(c0_data + lhs_positions, size)
    }
    return CHitch16()
}

@inlinable @inline(__always)
func chitch16_init_substring_raw(_ raw: UnsafePointer<UInt16>?, _ count: Int, _ lhs_positions: Int, _ rhs_positions: Int) -> CHitch16 {
    guard let raw = raw else { return chitch16_empty() }
    let size = rhs_positions - lhs_positions
    guard size > 0 && size <= count else { return CHitch16() }
    guard lhs_positions >= 0 && lhs_positions <= count else { return CHitch16() }
    guard rhs_positions >= 0 && rhs_positions <= count else { return CHitch16() }
    return chitch16_init_raw(raw + lhs_positions, size)
}

@inlinable @inline(__always)
func chitch16_dealloc(_ chitch: inout CHitch16) {
    chitch16_internal_free(chitch.mutableData)
    chitch.mutableData = nil
    chitch.capacity = 0
    chitch.count = 0
    chitch.mutableData = nil
    chitch.castedMutableData = nil
    chitch.staticData = nil
}

@inlinable @inline(__always)
func chitch16_make_mutable(_ c0: inout CHitch16) {
    if let c0_data = c0.staticData {
        if c0.copyOnWrite == false {
            #if DEBUG
            fatalError("Mutating method called on Hitchable where copyOnWrite is set to false")
            #else
            print("warning: attempted to mutate a Hitchable where copyOnWrite is set to false")
            return
            #endif
        }
        c0 = chitch16_init_raw(UnsafeMutablePointer(mutating: c0_data), c0.count)
    }
}

@inlinable @inline(__always)
func chitch16_realloc(_ c0: inout CHitch16, _ newCapacity: Int) {
    // Note: UnsafeMutablePointer appears to be missing a realloc!
    guard newCapacity != c0.capacity else { return }

    if let c0_data = c0.mutableData {
        c0.count = min(c0.count, newCapacity)
        c0.capacity = newCapacity
        c0.mutableData = chitch16_internal_realloc(c0_data, newCapacity + 1)
        c0.castedMutableData = UnsafePointer(c0.mutableData)
        return
    }
    if let _ = c0.staticData {
        return
    }
    c0 = chitch16_init_capacity(newCapacity)
}

@inlinable @inline(__always)
func chitch16_resize(_ c0: inout CHitch16, _ newCapacity: Int) {
    if newCapacity > c0.capacity {
        chitch16_realloc(&c0, newCapacity + 1)
    } else if newCapacity < c0.capacity {
        c0.count = newCapacity
    }
}

@inlinable @inline(__always)
func chitch16_sanity(_ c0: inout CHitch16, _ desiredCapacity: Int) {
    if desiredCapacity > c0.capacity {
        chitch16_realloc(&c0, desiredCapacity + 1)
    }
}

// MARK: - MUTATING METHODS

@inlinable @inline(__always)
func chitch16_concat(_ c0: inout CHitch16, _ rhs: UnsafePointer<UInt16>?, _ rhs_count: Int) {
    guard rhs_count > 0 else { return }
    guard let rhs = rhs else { return }

    chitch16_sanity(&c0, c0.count + rhs_count)
    guard let c0_data = c0.mutableData else { return }

    (c0_data + c0.count).assign(from: rhs, count: rhs_count)
    c0.count += rhs_count
}

@inlinable @inline(__always)
func chitch16_concat_char(_ c0: inout CHitch16, _ rhs: UInt16) {

    chitch16_sanity(&c0, c0.count + 1)
    guard let c0_data = c0.mutableData else { return }

    c0_data[c0.count] = rhs
    c0.count += 1
}

@inlinable @inline(__always)
func chitch16_concat_string(_ c0: inout CHitch16, _ string: String) {
    for scalar in string.unicodeScalars {
        for v in scalar.utf16 {
            chitch16_concat_char(&c0, v)
        }
    }
}

@inlinable @inline(__always)
func chitch16_replace(_ c0: inout CHitch16, _ from: Int, _ to: Int, _ replace: CHitch16) {
    if from == to && replace.count == 0 {
        return
    }

    let replace_data = replace.universalData

    let find_count = to - from

    let c0_count = c0.count
    let replace_count = replace.count

    // Expansion: our array is going to need to grow before we can perform the replacement
    if replace_count > find_count {
        let capacity_required = c0_count + (replace_count - find_count)

        chitch16_sanity(&c0, capacity_required)
        guard let c0_data = c0.mutableData else { return }

        let from_ptr = c0_data + from

        // work our way from back to front, copying and replacing as we go
        let start = c0_data
        let old_end = c0_data + c0_count
        let new_end = c0_data + capacity_required

        var old_ptr_a = old_end
        var old_ptr_b = old_end
        var new_ptr = new_end

        var fix_count = 0

        while old_ptr_a >= start {
            // is this the thing we need to replace?
            if old_ptr_a == from_ptr {
                fix_count = old_ptr_b - (old_ptr_a + find_count)
                if fix_count > 0 {
                    memmove(new_ptr - fix_count, (old_ptr_a + find_count), fix_count * 2)
                    new_ptr -= fix_count
                }

                new_ptr -= replace_count

                if let replace_data = replace_data {
                    memmove(new_ptr, replace_data, replace_count * 2)
                }
                old_ptr_b = old_ptr_a
            }

            old_ptr_a -= 1
        }

        // final copy
        if old_ptr_a >= start {
            fix_count = old_ptr_b - (old_ptr_a + find_count)
            if fix_count > 0 {
                memmove((old_ptr_a + find_count), new_ptr - fix_count, fix_count * 2)
            }
        }

        c0.count = capacity_required
    } else {
        // Our array can stay the same size as we perform the replacement. Since we can go front to
        // back we don't need to know the number of occurrences a priori.
        guard let c0_data = c0.mutableData else { return }

        let from_ptr = c0_data + from

        // work our way from back to front, copying and replacing as we go
        let start = c0_data
        let old_end = c0_data + c0_count

        var old_ptr = start
        var new_ptr = start

        while old_ptr <= old_end {
            // is this the thing we need to replace?
            if old_ptr == from_ptr {
                old_ptr += find_count

                if let replace_data = replace_data {
                    memmove(new_ptr, replace_data, replace_count * 2)
                }
                new_ptr += replace_count
            } else {
                new_ptr.pointee = old_ptr.pointee
                new_ptr += 1
                old_ptr += 1
            }
        }

        c0.count = (new_ptr - start) - 1
        if c0.count < 0 {
            c0.count = 0
        }
    }
}
