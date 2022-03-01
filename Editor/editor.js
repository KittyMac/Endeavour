import {Update, receiveUpdates, sendableUpdates, collab, getSyncedVersion, getClientID} from "@codemirror/collab"
import {ViewPlugin, keymap, highlightSpecialChars, drawSelection, highlightActiveLine, dropCursor} from "@codemirror/view"
import {ChangeSet, Text, EditorState, StateEffect} from "@codemirror/state"
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

import {json} from "@codemirror/lang-json"
import {javascript} from "@codemirror/lang-javascript"

import {swift} from "./index.swift.js"

import {light} from "./light.js"
import {dark} from "./dark.js"

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
        return {};
    }
}

cm.endeavourSend = function(command, documentUUID) {
    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4) {
            let serviceResponse = xhttp.getResponseHeader("Service-Response");
            let serviceJson = cm.endeavourJsonParse(serviceResponse);
        
            if (documentUUID == undefined) {
                documentUUID = serviceJson.documentUUID;
            }
        
            let plugin = cm.endeavourDocuments[documentUUID];
            
            try {
                if (this.status != 200) {
                    plugin.didError(xhttp.responseText);
                } else {                
                    let contentJson = cm.endeavourJsonParse(xhttp.responseText)                
                    switch (command.command) {
                    case "pull":
                        plugin.didPull(serviceJson, contentJson);
                        break;
                    case "push":
                        plugin.didPush(serviceJson, contentJson);
                        break;
                    }
                }
            
                switch (command.command) {
                case "pull":
                    cm.endeavourIsPulling = false;
                    cm.endeavourPullUpdates();
                    break;
                case "push":
                    cm.endeavourIsPushing = false;
                    break;
                }
            } catch (error) {
                if (plugin != undefined) {
                    plugin.didError(error);
                } else {
                    print(`Uncaught error: ${error}`);
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
cm.endeavourPushUpdates = function(documentUUID, version, updates) {
    if (cm.endeavourIsPushing == false) {
        let msg = {
            service: "EndeavourService",
            command: "push",
            documentUUID: documentUUID,
            version: version,
            updates: updates
        };
        cm.endeavourIsPushing = true;
        cm.endeavourSend(msg, documentUUID);
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

cm.endeavourExtension = function (serviceJson, statusCallback) {
    let startingDocumentUUID = serviceJson.documentUUID;
    let startingDocumentVersion = parseInt(serviceJson.version);
    
    // We pull regardless of how many documents we are connected to
    cm.endeavourPullUpdates();
    
    let plugin = ViewPlugin.fromClass(class {
        pushing = false;
        
        constructor(view) {
            this.statusCallback = statusCallback;
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
            
            cm.endeavourPushUpdates(this.documentUUID, this.documentVersion(), updates);
        }
        
        didPush(serviceJson, contentJson) {
            if (sendableUpdates(this.view.state).length) {
                setTimeout(() => this.push(), 100)
            }
        }
        
        didPull(serviceJson, contentJson) {
            let changes = contentJson.map(function(x) {
                return {
                    changes: ChangeSet.fromJSON(x.changes),
                    clientID: x.clientID
                };
            });
            
            this.view.dispatch(receiveUpdates(this.view.state, changes));
            
            if (statusCallback != undefined) {
                statusCallback(`Document ${this.documentUUID}`, false);
            }
        }
        
        didError(errorResponse) {
            if (statusCallback != undefined) {
                statusCallback(errorResponse, true);
            }
        }
        
        destroy() { cm.endeavourDocuments[this.documentUUID] = undefined; }
    })
    return [collab({startVersion: startingDocumentVersion}), plugin]
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
    
    if (window.matchMedia &&  window.matchMedia('(prefers-color-scheme: dark)').matches) {
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
        }
    });

    return editor;
}

