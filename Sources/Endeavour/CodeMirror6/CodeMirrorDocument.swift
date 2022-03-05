import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

/// Attempt at duplicating the CM6 ChangeSet logic so that the server can keep a
/// version of the document in sync with the clients.
///
/// CodeMirror text documents works as follows:
/// document offsets are 0 indexed by counting utf16 code units, new lines are always
/// one code unit (fine unless line separator is configured to something > 1 utf16 code unit)
class CodeMirrorDocument {
    var document = chitch16_init_capacity(1024)

    func set(document string: String) {
        chitch16_concat_string(&document, string)
    }

    func hitch() -> Hitch {
        return Hitch(string: document.description())
    }

    func apply(changeSet: JsonElement) {

        // print("==== BEFORE DOCUMENT ====")
        // print(document.description())
        // print("==== UPDATE ====")
        // print(changeSet.toString())

        var sections: [Int] = []
        var inserted: [CHitch16] = []

        // equiavlent to .fromJSON()
        changeSet.query(forEach: "$..changes") { changes in
            for idx in 0..<changes.count {
                guard let part = changes[element: idx] else {
                    fatalError("ChangeSet JsonElement is missing")
                }

                if part.type == .int {
                    sections.append(part.intValue ?? 0)
                    sections.append(-1)
                } else if part.type == .array {
                    if part.count == 1 {
                        sections.append(part[int: 0] ?? 0)
                        sections.append(0)
                    } else {
                        while inserted.count < idx {
                            inserted.append(chitch16_empty())
                        }

                        var totalCount = 0
                        for jdx in 1..<part.count {
                            totalCount += part[hitch: jdx]?.count ?? 0
                            totalCount += 1
                        }

                        var combined = CHitch16()
                        for jdx in 1..<part.count {
                            if let string = part[string: jdx] {
                                if jdx > 1 {
                                    chitch16_concat_char(&combined, 10)
                                }
                                chitch16_concat_string(&combined, string)
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
        while idx < sections.count-1 {
            var len = sections[idx+0]
            var ins = sections[idx+1]
            idx += 2

            if ins < 0 {

                // confirm the document length...
                // if len != document.count {
                //    fatalError()
                // }

                posA += len
                posB += len
            } else {
                var endA = posA
                var endB = posB
                var text = chitch16_empty()
                while true {
                    endA += len
                    endB += ins
                    if ins > 0 {
                        let toInsert = inserted[(idx - 2) >> 1]
                        if let raw = toInsert.universalData {
                            chitch16_concat(&text, raw, toInsert.count)
                        }
                    }
                    if idx == sections.count || sections[idx + 1] < 0 {
                        break
                    }
                    len = sections[idx+0]
                    ins = sections[idx+1]
                    idx += 2
                }

                // f(posA, endA, posB, endB, text)
                chitch16_replace(&document,
                                posB,
                                posB + (endA - posA),
                                text)
                // print("replace from {0} to {1} with {2}" << [posB, posB + (endA - posA), text.description()])

                posA = endA
                posB = endB
            }
        }

        // TODO: counts are messed up if 🍎 is used

        // print("============\n\(document.description())\n============")
    }
}
