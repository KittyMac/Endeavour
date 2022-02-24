import {Update, receiveUpdates, sendableUpdates, collab, getSyncedVersion, getClientID} from "@codemirror/collab"
import {ViewPlugin, keymap, highlightSpecialChars, drawSelection, highlightActiveLine, dropCursor} from "@codemirror/view"
import {ChangeSet, Text, EditorState} from "@codemirror/state"
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
import {defaultHighlightStyle} from "@codemirror/highlight"
import {lintKeymap} from "@codemirror/lint"
import {EditorView} from "@codemirror/view"
import {indentWithTab} from "@codemirror/commands"

import {json} from "@codemirror/lang-json"
import {javascript} from "@codemirror/lang-javascript"

import {swift} from "./index.swift.js"

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

const myTheme = EditorView.baseTheme({
    "&.cm-editor": {
        fontSize: '1rem',
        flex: '1 1 auto',
        alignSelf: 'stretch',
        minHeight: '0px'
    },
    ".cm-scroller": {
        fontFamily:'Roboto Mono, Courier New, monospace',
        overflow: 'auto',
    },
})

cm.endeavourSend = function(command, callback) {
    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4) {
            if (this.status != 200) {
                callback();
            } else {                
                let serviceResponse = xhttp.getResponseHeader("Service-Response");
                try {
                    let serviceJson = JSON.parse(serviceResponse);
                    let updatesJson = JSON.parse(xhttp.responseText);
                    callback(serviceJson, updatesJson);
                }
                catch (error) {
                    callback();
                }
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
cm.endeavourPushQueue = [];
cm.endeavourPushUpdates = function(documentUUID, version, updates, callback) {
    
    if (documentUUID != undefined) {
        cm.endeavourPushQueue.push({
            service: "EndeavourService",
            command: "push",
            documentUUID: documentUUID,
            version: version,
            updates: updates,
            callback: callback
        });
    }
    
    if (cm.endeavourIsPushing == false && cm.endeavourPushQueue.length > 0) {
        let msg = cm.endeavourPushQueue.shift();
        
        let callback = msg.callback;
        msg.callback = undefined;
        
        cm.endeavourIsPushing = true;
        cm.endeavourSend(msg, function(serviceJson, responseJson) {
            cm.endeavourIsPushing = false;
            callback(responseJson);
        });
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
        cm.endeavourSend(msg, function(documentUUID, response) {
            cm.endeavourIsPulling = false;
            
            if (documentUUID != undefined && response != undefined) {
                let changes = response.map(function(x) {
                    return {
                        changes: ChangeSet.fromJSON(x.changes),
                        clientID: x.clientID
                    };
                });
                
                let plugin = cm.endeavourDocuments[documentUUID];
                plugin.pull(changes);
            }
            
            cm.endeavourPullUpdates();
        });
    }
}

// We pull regardless of how many documents we are connected to
cm.endeavourPullUpdates();

cm.endeavourExtension = function (serviceJson) {
    let startingDocumentUUID = serviceJson.documentUUID;
    let startingDocumentVersion = serviceJson.version;
    
    let plugin = ViewPlugin.fromClass(class {
        pushing = false;
        
        constructor(view) {
            this.documentUUID = startingDocumentUUID;
            this.view = view;
                        
            cm.endeavourDocuments[this.documentUUID] = this;
        }

        update(update) {
            if (update.docChanged) {
                this.push();
            }
        }
        
        documentVersion() {
            return getSyncedVersion(this.view.state) || 0;
        }
        
        clientID() {
            return getClientID(this.view.state);
        }
        
        push() {
            let updates = sendableUpdates(this.view.state)
            if (updates.length == 0) {
                return
            }
            updates = updates.map(function(x) {
                return {
                    changes: x.changes.toJSON(),
                    clientID: x.clientID
                };
            });
            
            let version = this.documentVersion();
            
            let localThis = this;
            cm.endeavourPushUpdates(this.documentUUID, version, updates, function(response) {
                // if we didn't error and there are more updates to send
                if (response != undefined && sendableUpdates(localThis.view.state).length) {
                    setTimeout(() => localThis.push(), 100)
                }
            });
        }
        
        pull(changes) {
            this.view.dispatch(receiveUpdates(this.view.state, changes));
        }
        
        destroy() { cm.endeavourDocuments[this.documentUUID] = undefined; }
    })
    return [collab({startingDocumentVersion}), plugin]
}

cm.CreateEditor = function(parentDivId, extensions, content="", editable=true) {
    let parentDiv = document.getElementById(parentDivId);
    
    extensions.push(myTheme);
        
    if (editable) {
        extensions.push(lineNumbers());
        extensions.push(foldGutter());
        extensions.push(highlightActiveLineGutter());
        extensions.push(highlightActiveLine());
    } else {
        extensions.push(EditorView.editable.of(false));
        extensions.push(EditorState.readOnly.of(true));
    }
        
    return new EditorView({
        state: EditorState.create({
            doc: Text.of(content.split("\n")),
            extensions: extensions,
            tabSize: 4
        }),
        parent: parentDiv
    })
}

