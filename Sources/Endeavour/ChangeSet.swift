import Foundation
import ArgumentParser
import Picaroon
import Flynn
import Hitch
import Spanker

struct Change {
    var sections: [Int] = []
    var inserted: [Hitch] = []

    init(json: JsonElement) {
        /*
         if (!Array.isArray(json)) throw new RangeError("Invalid JSON representation of ChangeSet")
                       let sections = [], inserted = []
                   for (let i = 0; i < json.length; i++) {
                       let part = json[i]
                       if (typeof part == "number") {
                           sections.push(part, -1)
                       } else if (!Array.isArray(part) || typeof part[0] != "number" || part.some((e, i) => i && typeof e != "string")) {
                           throw new RangeError("Invalid JSON representation of ChangeSet")
                       } else if (part.length == 1) {
                           sections.push(part[0], 0)
                       } else {
                           while (inserted.length < i) inserted.push(Text.empty)
                               inserted[i] = Text.of(part.slice(1))
                               sections.push(part[0], inserted[i].length)
                       }
                   }
         */
        guard json.type == .array else { fatalError("ChangeSet is not an array") }

        for idx in 0..<json.count {
            guard let part = json[element: idx] else { fatalError("ChangeSet JsonElement is missing") }

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

                    // TODO: I think this can store multiple strings! We are
                    // only handling the one now
                    inserted[idx] = part[hitch: 1] ?? Hitch.empty

                    sections.append(part[int: 0] ?? 0)
                    sections.append(inserted[idx].count)
                }
            }
        }
    }
}

/// Attempt at duplicating the CM6 ChangeSet logic so that the server can keep a
/// version of the document in sync with the clients
enum ChangeSet {
    static func apply(document: DocumentContent,
                      changeSet: JsonElement) {

        /*
         static fromJSON(json: any) {
               if (!Array.isArray(json)) throw new RangeError("Invalid JSON representation of ChangeSet")
                   let sections = [], inserted = []
               for (let i = 0; i < json.length; i++) {
                   let part = json[i]
                   if (typeof part == "number") {
                       sections.push(part, -1)
                   } else if (!Array.isArray(part) || typeof part[0] != "number" || part.some((e, i) => i && typeof e != "string")) {
                       throw new RangeError("Invalid JSON representation of ChangeSet")
                   } else if (part.length == 1) {
                       sections.push(part[0], 0)
                   } else {
                       while (inserted.length < i) inserted.push(Text.empty)
                           inserted[i] = Text.of(part.slice(1))
                           sections.push(part[0], inserted[i].length)
                   }
               }
               return new ChangeSet(sections, inserted)
           }
         */

        print("==== BEFORE DOCUMENT ====")
        print(document)
        print("==== UPDATE ====")
        print(changeSet)

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

                        // TODO: I think this can store multiple strings! We are
                        // only handling the one now
                        let insertion = part[hitch: 1] ?? Hitch.empty
                        inserted.append(insertion)

                        sections.append(part[int: 0] ?? 0)
                        sections.append(insertion.count)
                    }
                }
            }
        }

        // equivalent to iterChanges
        /*
         let inserted = (desc as ChangeSet).inserted
                 for (let posA = 0, posB = 0, i = 0; i < desc.sections.length;) {
                     let len = desc.sections[i++], ins = desc.sections[i++]
                     if (ins < 0) {
                         posA += len; posB += len
                     } else {
                         let endA = posA, endB = posB, text = Text.empty
                         for (;;) {
                             endA += len; endB += ins
                             if (ins && inserted) text = text.append(inserted[(i - 2) >> 1])
                                 if (individual || i == desc.sections.length || desc.sections[i + 1] < 0) break
                                     len = desc.sections[i++]; ins = desc.sections[i++]
                         }
                         f(posA, endA, posB, endB, text)
                         posA = endA; posB = endB
                     }
                 }
         */

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
                print("replace from {0} to {1} with {2}" << [posB, posB + (endA - posA), text])

                posA = endA
                posB = endB
            }
        }

        print("==== AFTER DOCUMENT ====")
        print(document)
        print("========================")

    }
}
