import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

/// Attempt at duplicating the CM6 ChangeSet logic so that the server can keep a
/// version of the document in sync with the clients
enum ChangeSet {
    static func apply(document: DocumentContent,
                      changeSet: JsonElement) {

        // print("==== BEFORE DOCUMENT ====")
        // print(document)
        // print("==== UPDATE ====")
        // print(changeSet.toString())

        var sections: [Int] = []
        var inserted: [Hitch] = []

        // equiavlent to .fromJSON()
        changeSet.query(forEach: "$..changes") { changes in
            for idx in 0..<changes.count {
                guard let part = changes[element: idx] else { fatalError("ChangeSet JsonElement is missing") }

                if part.type == .int {
                    sections.append(part.intValue ?? 0)
                    sections.append(-1)
                } else if part.type == .array {
                    if part.count == 1 {
                        sections.append(part[int: 0] ?? 0)
                        sections.append(0)
                    } else {
                        while inserted.count < idx {
                            inserted.append(Hitch.empty)
                        }

                        var totalCount = 0
                        for jdx in 1..<part.count {
                            totalCount += part[hitch: jdx]?.count ?? 0
                            totalCount += 1
                        }

                        let combined = Hitch(capacity: totalCount)
                        for jdx in 1..<part.count {
                            combined.append(part[hitch: jdx] ?? Hitch.empty)
                            if jdx > 1 {
                                combined.append(.newLine)
                            }
                        }

                        inserted.append(combined)

                        sections.append(part[int: 0] ?? 0)
                        sections.append(combined.count)
                    }
                }
            }
        }

        // equivalent to iterChanges
        var posA = 0
        var posB = 0
        var idx = 0
        let individual = false
        while idx < sections.count-1 {
            var len = sections[idx+0]
            var ins = sections[idx+1]
            idx += 2

            if ins < 0 {
                posA += len
                posB += len
            } else {
                var endA = posA
                var endB = posB
                var text = Hitch()
                while true {
                    endA += len
                    endB += ins
                    if ins > 0 {
                        text = text.append(inserted[(idx - 2) >> 1])
                    }
                    if individual || idx == sections.count || sections[idx + 1] < 0 {
                        break
                    }
                    len = sections[idx+0]
                    ins = sections[idx+1]
                    idx += 2
                }

                // f(posA, endA, posB, endB, text)
                document.replace(from: posB, to: posB + (endA - posA), with: text)
                // print("replace from {0} to {1} with {2}" << [posB, posB + (endA - posA), text])

                posA = endA
                posB = endB
            }
        }

        // print("============\n\(document)\n============")
    }
}
