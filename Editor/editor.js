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

cm.endeavourExtension = function (serviceJson) {
    let documentUUID = serviceJson.documentUUID;
    let documentVersion = serviceJson.version;
    
    let plugin = ViewPlugin.fromClass(class {
        pushing = false;
        
        constructor(view) {
            this.view = view;
            this.pull();
        }

        update(update) {
            if (update.docChanged) {
                this.push();
            }
        }
        
        push() {
            let localThis = this;
            
            let updates = sendableUpdates(localThis.view.state)
            if (this.pushing || updates.length == 0) {
                return
            }
            
            updates = updates.map(function(x) {
                return {
                    changes: x.changes.toJSON(),
                    clientID: x.clientID
                };
            });
            
            let version = getSyncedVersion(localThis.view.state)
            localThis.pushing = true;
            localThis.send({
                service: "EndeavourService",
                command: "push",
                documentUUID: documentUUID,
                version: version,
                updates: updates,
            }, function(response) {
                localThis.pushing = false;
                
                // Regardless of whether the push failed or new updates came in
                // while it was running, try again if there's updates remaining
                if (sendableUpdates(localThis.view.state).length) {
                    setTimeout(() => localThis.push(), 100)
                }
            });
        }
        
        pull() {
            let localThis = this;
            
            
            let version = getSyncedVersion(this.view.state) || 0
            localThis.send({
                service: "EndeavourService",
                command: "pull",
                documentUUID: documentUUID,
                version: version,
            }, function(response) {
                if (response != undefined) {
                    let changes = response.map(function(x) {
                        return {
                            changes: ChangeSet.fromJSON(x.changes),
                            clientID: x.clientID
                        };
                    });
                    localThis.view.dispatch(receiveUpdates(localThis.view.state, changes));
                    localThis.pull()
                }
            });
        }
    
        send(command, callback) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    let serviceJson = xhttp.getResponseHeader("Service-Response");
                    try {
                        let updatesJson = JSON.parse(xhttp.responseText);
                        callback(updatesJson);
                    }
                    catch (error) {
                        callback();
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
        
        destroy() {  }
    })
    return [collab({documentVersion}), plugin]
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

