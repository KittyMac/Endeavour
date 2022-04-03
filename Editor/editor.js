import {Update, receiveUpdates, sendableUpdates, collab, getSyncedVersion, getClientID} from "@codemirror/collab"
import {Decoration, ViewPlugin, keymap, highlightSpecialChars, drawSelection, highlightActiveLine, dropCursor} from "@codemirror/view"
import {ChangeSet, Text, EditorState, StateEffect, SelectionRange} from "@codemirror/state"
import {history, historyKeymap} from "@codemirror/history"
import {foldGutter, foldKeymap} from "@codemirror/fold"
import {indentOnInput, indentUnit} from "@codemirror/language"
import {lineNumbers, highlightActiveLineGutter} from "@codemirror/gutter"
import {defaultKeymap} from "@codemirror/commands"
import {bracketMatching} from "@codemirror/matchbrackets"
import {closeBrackets, closeBracketsKeymap} from "@codemirror/closebrackets"
import {searchKeymap, highlightSelectionMatches} from "@codemirror/search"
import {autocompletion, completionKeymap} from "@codemirror/autocomplete"
import {commentKeymap} from "@codemirror/comment"
import {rectangularSelection} from "@codemirror/rectangular-selection"
import {defaultHighlightStyle, tags, HighlightStyle} from "@codemirror/highlight"
import {lintKeymap} from "@codemirror/lint"
import {EditorView} from "@codemirror/view"
import {indentWithTab} from "@codemirror/commands"
import {RangeSetBuilder} from "@codemirror/rangeset"

import {json} from "@codemirror/lang-json"
import {javascript} from "@codemirror/lang-javascript"

import {swift} from "./index.swift.js"

import {light} from "./light.js"
import {dark} from "./dark.js"
import {peerColors, newPeerDecoration, peerWidgetBaseTheme} from "./peerWidget.js"

let cm = {};
window.cm = cm;

cm.swiftSetup = [
    highlightSpecialChars(),
    history(),
    drawSelection(),
    dropCursor(),
    EditorState.allowMultipleSelections.of(true),
    indentOnInput(),
    defaultHighlightStyle.fallback,
    bracketMatching(),
    closeBrackets(),
    autocompletion(),
    rectangularSelection(),
    highlightSelectionMatches(),
    keymap.of([
        ...closeBracketsKeymap,
        ...defaultKeymap,
        ...searchKeymap,
        ...historyKeymap,
        ...foldKeymap,
        ...commentKeymap,
        ...completionKeymap,
        ...lintKeymap
    ]),
    indentUnit.of("    "),
    keymap.of([indentWithTab]),
    swift()
]

cm.javascriptSetup = [
    highlightSpecialChars(),
    history(),
    drawSelection(),
    dropCursor(),
    EditorState.allowMultipleSelections.of(true),
    indentOnInput(),
    defaultHighlightStyle.fallback,
    bracketMatching(),
    closeBrackets(),
    autocompletion(),
    rectangularSelection(),
    highlightSelectionMatches(),
    keymap.of([
        ...closeBracketsKeymap,
        ...defaultKeymap,
        ...searchKeymap,
        ...historyKeymap,
        ...foldKeymap,
        ...commentKeymap,
        ...completionKeymap,
        ...lintKeymap
    ]),
    indentUnit.of("    "),
    keymap.of([indentWithTab]),
    javascript()
]


cm.jsonSetup = [
    highlightSpecialChars(),
    history(),
    drawSelection(),
    dropCursor(),
    EditorState.allowMultipleSelections.of(true),
    indentOnInput(),
    defaultHighlightStyle.fallback,
    bracketMatching(),
    closeBrackets(),
    autocompletion(),
    rectangularSelection(),
    highlightSelectionMatches(),
    keymap.of([
        ...closeBracketsKeymap,
        ...defaultKeymap,
        ...searchKeymap,
        ...historyKeymap,
        ...foldKeymap,
        ...commentKeymap,
        ...completionKeymap,
        ...lintKeymap
    ]),
    indentUnit.of("    "),
    keymap.of([indentWithTab]),
    json()
]

cm.minimalSetup = [
    highlightSpecialChars(),
    history(),
    drawSelection(),
    dropCursor(),
    EditorState.allowMultipleSelections.of(true),
    indentOnInput(),
    defaultHighlightStyle.fallback,
    bracketMatching(),
    closeBrackets(),
    keymap.of([
        ...closeBracketsKeymap,
        ...defaultKeymap,
        ...searchKeymap,
        ...historyKeymap,
        ...commentKeymap,
        ...completionKeymap,
        ...lintKeymap
    ]),
    indentUnit.of("    "),
    keymap.of([indentWithTab]),
    json()
]

cm.endeavourJsonParse = function(json) {
    try {
        return JSON.parse(json);
    } catch (error) {
        return json;
    }
}

cm.endeavourSendErrorCount = 0;

cm.broadcastStatus = function(documentUUID, command, message) {
    let allDocumentUUIDs = [];
    if (documentUUID != undefined) {
        allDocumentUUIDs.push(documentUUID);
    }
    if (command.documentUUIDs != undefined) {
        allDocumentUUIDs = allDocumentUUIDs.concat(command.documentUUIDs);
    }
    
    allDocumentUUIDs.forEach(function(documentUUID) {
        cm.endeavourDocuments[documentUUID]?.didError(message);
    });
}

cm.endeavourSend = function(command, documentUUID) {
    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4) {
            let plugin = undefined;
            
            if (command.command == "pull") {
                cm.endeavourIsPulling = false;
            } else if (command.command == "push") {
                cm.endeavourIsPushing = false;
            }
            
            let serviceResponse = xhttp.getResponseHeader("Service-Response");
            let serviceJson = cm.endeavourJsonParse(serviceResponse);
            if (serviceJson != undefined) {
                plugin = cm.endeavourDocuments[serviceJson.documentUUID];
            }
            
            if (this.status != 200) {
                cm.endeavourSendErrorCount += 1;
                
                if (plugin != undefined) {
                    plugin.didError(xhttp.responseText);
                }
            } else {
                cm.endeavourSendErrorCount = 0;                
                let contentJson = cm.endeavourJsonParse(xhttp.responseText);
                switch (command.command) {
                case "pull":
                    plugin.didPull(serviceJson, contentJson, xhttp.responseText);
                    break;
                case "push":
                    plugin.didPush(serviceJson, contentJson, xhttp.responseText);
                    break;
                }
            }
                        
            if (cm.endeavourSendErrorCount > 6) {
                cm.broadcastStatus(documentUUID, command, "Disconnected from server")
                cm.endeavourIsPulling = false;
                return;
            }
            
            if (command.command == "pull") {
                cm.endeavourPullUpdates();
            }
        }
    };
    xhttp.open("POST", "/");
    let sessionId = sessionStorage.getItem("Session-Id");
    if (sessionId != undefined) {
        xhttp.setRequestHeader("Session-Id", sessionId);
    }    
    xhttp.setRequestHeader("Pragma", "no-cache");
    xhttp.setRequestHeader("Expires", "-1");
    xhttp.setRequestHeader("Cache-Control", "no-cache");
    xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhttp.send(JSON.stringify(command));
}

// Modern browsers can only keep open a limited number of concurrent connections to the backend.
// To allow for any number of open documents, we need all documents to share the same long pull,
// otherwise we can lead to a deadlock.
cm.endeavourDocuments = {};

cm.endeavourIsPushing = false;
cm.endeavourPushUpdates = function(plugin, docUpdates, docRanges) {
    if (cm.endeavourIsPushing == false) {
        let msg = {
            service: "EndeavourService",
            command: "push",
            documentUUID: plugin.documentUUID,
            clientID: plugin.clientID(),
            version: plugin.documentVersion()
        };
        if (docUpdates.length > 0) {
            msg.updates = docUpdates;
        }
        if (docRanges != undefined) {
            msg.cursors = {
                clientID: plugin.clientID(),
                ranges: docRanges
            };
        }
        if (msg.cursors || msg.updates) {
            cm.endeavourIsPushing = true;
            cm.endeavourSend(msg, plugin.documentUUID);
        }
    }
}

cm.endeavourIsPulling = false;
cm.endeavourPullUpdates = function() {    
    if (cm.endeavourIsPulling == false) {
        var documentUUIDs = [];
        var documentVersions = [];
        
        for (let documentUUID in cm.endeavourDocuments) {
            let plugin = cm.endeavourDocuments[documentUUID];
            documentUUIDs.push(documentUUID);
            documentVersions.push(plugin.documentVersion());
        }
        
        let msg = {
            service: "EndeavourService",
            command: "pull",
            documentUUIDs: documentUUIDs,
            documentVersions: documentVersions
        };
        
        cm.endeavourIsPulling = true;
        cm.endeavourSend(msg);
    }
}

cm.removeOne = function(arr, value) {
    var index = arr.indexOf(value);
    if (index > -1) {
        arr.splice(index, 1);
    }
    return arr;
}

cm.endeavourExtension = function (serviceJson, statusCallback) {
    let startingDocumentUUID = serviceJson.documentUUID;
    let startingDocumentVersion = parseInt(serviceJson.version);
    
    let plugin = ViewPlugin.fromClass(class {
        pushing = false;
        
        constructor(view) {
            
            // We pull regardless of how many documents we are connected to
            cm.endeavourPullUpdates();
            
            this.statusCallback = statusCallback;
            this.documentUUID = startingDocumentUUID;
            this.view = view;
            this.peers = [];
            this.cursors = [];
            cm.endeavourDocuments[this.documentUUID] = this;
            
            statusCallback(
                serviceJson,
                {
                    documentUUID: this.documentUUID,
                    version: this.documentVersion(),
                    clientID: this.clientID(),
                    peers: this.peers
                }
            );
            
            this.decorations = this.getDeco(view);
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
                this.decorations = this.getDeco(this.view);
            });
            
            cm.endeavourPushUpdates(this, [], []);
        }

        update(update) {
            if (update == undefined || update.docChanged || update.selectionSet) {
                let docUpdates = sendableUpdates(this.view.state).map(function(x) {
                    return {
                        changes: x.changes.toJSON(),
                        clientID: x.clientID
                    };
                });
                
                cm.endeavourPushUpdates(this, docUpdates, update?.state?.selection?.ranges);
            }
        }
        
        documentVersion() {
            return getSyncedVersion(this.view.state) || 0;
        }
        
        clientID() {
            return getClientID(this.view.state);
        }
                
        didPush(serviceJson, contentJson, contentText) {
            if (sendableUpdates(this.view.state).length) {
                setTimeout(() => this.update(undefined), 100)
            }
        }
        
        didPull(serviceJson, contentJson, contentText) {
            
            // Pulls can return multiple different things. Detect what it is
            // and do the appropriate thing:
                        
            if (serviceJson.command == "cursors") {
                // peers updated their cursor positions                
                let json = cm.endeavourJsonParse(contentText);
                this.peers = json.peers;
                this.cursors = json.cursors;
                this.decorations = this.getDeco(this.view);
                
                this.peers.forEach(function(peer) {
                    if (peer.name == undefined) {
                        peer.name = peer.clientID;
                    }
                    peer.colors = peerColors[peer.peerIdx];
                    if (peer.colors == undefined) {
                        peer.colors = peerColors[0];
                    }
                });
                
                this.view.dispatch({});
            }
            
            // Full document refresh:
            if (serviceJson.command == "save") {
                
                // Suppress our code from sharing this change with the server
                cm.endeavourIsPushing = true;
                this.view.dispatch({
                    changes: {
                        from: 0,
                        to: this.view.state.doc.length,
                        insert: contentText
                    }
                });
                
                // Horrible hack to reset our version history
                for (let idx = 0; idx < this.view.state.values.length; idx++) {
                    let value = this.view.state.values[idx];
                    if (value?.version != undefined && value?.unconfirmed != undefined) {
                        value.version = 0;
                        value.unconfirmed.length = 0;
                    }
                }
                
                cm.endeavourIsPushing = false;
            }
            
            // Partial document updates:
            if (serviceJson.command == "update") {
                let changes = contentJson.map(function(x) {
                    return {
                        changes: ChangeSet.fromJSON(x.changes),
                        clientID: x.clientID
                    };
                });
                this.view.dispatch(receiveUpdates(this.view.state, changes));
            }
            
            if (statusCallback != undefined) {
                statusCallback(
                    serviceJson,
                    {
                        documentUUID: this.documentUUID,
                        version: this.documentVersion(),
                        clientID: this.clientID(),
                        peers: this.peers
                    }
                );
            }
        }
        
        didError(errorResponse) {
            if (statusCallback != undefined) {
                statusCallback(
                    serviceJson,
                    {
                        documentUUID: this.documentUUID,
                        version: this.documentVersion(),
                        clientID: this.clientID(),
                        peers: this.peers,
                        error: errorResponse
                    }
                );
            }
        }
        
        getDeco(view) {
            // Note: go through all visible lines, match again all peer selection
            // ranges, and add the appropriate decorations.
            let ranges = [];
            let localThis = this;
            
            let hex2rgb = function (colorString) {
                let idx = colorString.indexOf("#");
                if (idx >= 0) {
                    colorString = colorString.slice(idx+1);
                }
                
                var hex = 0;
                if (colorString.length == 6) {
                    // RRGGBB
                    hex = (parseInt(colorString, 16) << 8) + 255;
                }
                if (colorString.length == 8) {
                    // RRGGBBAA
                    hex = parseInt(colorString, 16);
                }
                
                return [
                    ((hex >> 24) & 0xFF),
                    ((hex >> 16) & 0xFF),
                    ((hex >> 8) & 0xFF),
                    ((hex >> 0) & 0xFF)
                ];
            }
                        
            this.cursors.forEach(function(peer) {
                let peerInfo = undefined;
                localThis.peers.forEach(function(otherPeerInfo) {
                    if (otherPeerInfo.clientID == peer.clientID) {
                        peerInfo = otherPeerInfo;
                    }
                });
                
                if (peerInfo == undefined || peerInfo.clientID == localThis.clientID()) {
                    return;
                }
                    
                let peerDeco = newPeerDecoration(peerInfo);
                
                if (peer.ranges != undefined) {
                    peer.ranges.forEach(function(range) {
                        range = SelectionRange.fromJSON(range)
                        if (range.value == undefined) {
                            range.value = {};
                        }
                        if (range.value.startSide == undefined) {
                            range.value.startSide = 0;
                        }
                        ranges.push({
                            peerInfo: peerInfo,
                            peer: peerDeco,
                            range: range
                        });
                    })
                }
            });
            
            ranges.sort(function(a, b) {
                return a.range.from - b.range.from || a.range.value.startSide - b.range.value.startSide;
            });
            
            let decorations = [];
            let colorsPerLine = {};
            let firstForPeer = [];
            
            let computedStyle = getComputedStyle(document.documentElement)
            
            // Ranges should be added in sorted (by from and value.startSide) order
            for (let {from, to} of view.visibleRanges) {
                for (let pos = from; pos <= to;) {
                    let line = view.state.doc.lineAt(pos);
                    
                    ranges.forEach(function(peerRange) {
                        let peerFrom = peerRange.range.from;
                        let peerTo = peerRange.range.to;
                        
                        if (peerFrom >= line.from &&
                            peerFrom <= line.to &&
                            firstForPeer.includes(peerRange.peerInfo.peerIdx) == false) {
                            firstForPeer.push(peerRange.peerInfo.peerIdx);
                            decorations.push({
                                from: peerFrom,
                                to: peerFrom,
                                value: peerRange.peer,
                                label: "cursor",
                                line: line.number
                            });
                        }
                        
                        
                        let lhs = -1;
                        let rhs = -1;
                        
                        if (peerFrom >= line.from && peerFrom <= line.to) {
                            lhs = peerFrom;
                        }
                        if (peerTo >= line.from && peerTo <= line.to) {
                            rhs = peerTo;
                        }
                        
                        // The only thing that seems to work well is using a line decoration to
                        // cover the whole line. Other decoration schemes seem to make funky funky
                        // things happen in the editor. Since we cannot nest spans using the 
                        // line decoration, we need to calculate the combined color of a line and
                        // set just one decoration for that
                        if ((lhs != -1 && rhs != -1) ||
                            (lhs == -1 && rhs != -1) ||
                            (lhs != -1 && rhs == -1) ||
                            (peerFrom < line.from && peerTo > line.to))
                        {
                            let peerIdx = peerRange.peerInfo.peerIdx;
                            let root = document.documentElement;
                            let lineIdx = line.from;
                            
                            let colorString = computedStyle.getPropertyValue(`--end-peer${peerIdx}-light`);
                            let color = hex2rgb(colorString)
                            
                            let colorPerLine = colorsPerLine[lineIdx];
                            if (colorPerLine == undefined) {
                                colorsPerLine[lineIdx] = [
                                    color[0], color[1], color[2], color[3], 1.0
                                ];
                            } else {
                                colorPerLine[0] += color[0];
                                colorPerLine[1] += color[1];
                                colorPerLine[2] += color[2];
                                colorPerLine[3] += color[3];
                                colorPerLine[4] += 1.0;
                            }                            
                        }
                        
                        /*
                        if (lhs != -1 && rhs != -1) {
                            // We're fully inside this line
                            decorations.push({
                                from: lhs,
                                to: rhs,
                                value: peerRange.selection,
                                label: "selection-inside",
                                line: line.number
                            });
                        } else if (lhs == -1 && rhs != -1) {
                            // We overlap this line from the left
                            decorations.push({
                                from: line.from,
                                to: rhs,
                                value: peerRange.selection,
                                label: "overlap-left",
                                line: line.number
                            })
                        } else if (lhs != -1 && rhs == -1) {
                            // We overlap this line from the right
                            decorations.push({
                                from: lhs,
                                to: line.to,
                                value: peerRange.selection,
                                label: "overlap-right",
                                line: line.number
                            })
                        } else if (peerFrom < line.from && peerTo > line.to) {
                            // the line is fully inside the selection
                            if (line.from == line.to) {
                                decorations.push({
                                    from: line.from,
                                    to: line.from,
                                    value: peerRange.wholeLine,
                                    label: "empty-line",
                                    line: line.number
                                })
                            } else {
                                decorations.push({
                                    from: line.from,
                                    to: line.to,
                                    value: peerRange.line,
                                    label: "line-inside",
                                    line: line.number
                                })
                            }
                        }*/
                    });
                
                    pos = line.to + 1
                }
            }
            
            for (const fromPos in colorsPerLine) {
                let fromPosInt = parseInt(fromPos);
                let color = colorsPerLine[fromPos];
                color[0] /= color[4];
                color[1] /= color[4];
                color[2] /= color[4];
                
                let lineDeco = Decoration.line({
                    attributes: { style: `background-color: rgba(${color[0]},${color[1]},${color[2]},0.6)` }
                })
                
                decorations.push({
                    from: fromPosInt,
                    to: fromPosInt,
                    value: lineDeco,
                })
            }
            
            return Decoration.set(decorations, true);
        }
        
        destroy() { cm.endeavourDocuments[this.documentUUID] = undefined; }
    }, {
        decorations: v => v.decorations
    });
    
    return [
        collab({startVersion: startingDocumentVersion}),
        peerWidgetBaseTheme,
        plugin
    ];
}

cm.CreateEditor = function(parentDivId, extensions, content="", editable=true) {
    let parentDiv = document.getElementById(parentDivId);
        
    if (editable) {
        extensions.push(lineNumbers());
        extensions.push(foldGutter());
        extensions.push(highlightActiveLineGutter());
        extensions.push(highlightActiveLine());
    } else {
        extensions.push(EditorView.editable.of(false));
        extensions.push(EditorState.readOnly.of(true));
    }
    
    var darkExtensions = [].concat(extensions);
    var lightExtensions = [].concat(extensions);
    
    darkExtensions.push(dark);
    lightExtensions.push(light);
    
    if (isDarkMode()) {
        extensions = darkExtensions;
    } else {
        extensions = lightExtensions;
    }
        
    let editor = new EditorView({
        state: EditorState.create({
            doc: Text.of(content.split("\n")),
            extensions: extensions,
            tabSize: 4
        }),
        parent: parentDiv
    });
            
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
        if (event.matches) {
            editor.dispatch({
                effects: StateEffect.reconfigure.of(darkExtensions)
            });
        } else {
            editor.dispatch({
                effects: StateEffect.reconfigure.of(lightExtensions)
            });
        };
    });

    return editor;
}

