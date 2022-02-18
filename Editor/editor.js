import {Update, receiveUpdates, sendableUpdates, collab, getSyncedVersion} from "@codemirror/collab"
import {ViewPlugin, keymap, highlightSpecialChars, drawSelection, highlightActiveLine, dropCursor} from "@codemirror/view"
import {EditorState} from "@codemirror/state"
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
    indentUnit.of("  "),
    keymap.of([indentWithTab]),
    javascript()
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
    indentUnit.of("  "),
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
    indentUnit.of("  "),
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
    indentUnit.of("  "),
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

cm.endeavourExtension = function (documentUUID, startVersion) {
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
            let updates = sendableUpdates(this.view.state)
            if (this.pushing || !updates.length) {
                return
            }
            
            let version = getSyncedVersion(this.view.state)
            let localThis = this;
            
            this.pushing = true;
            this.send({
                service: "EndeavourService",
                command: "push",
                documentUUID: documentUUID,
                version: version,
                updates: updates
            }, function(xhttp) {
                localThis.receivedUpdate(xhttp);
            });
            
        }
        
        receivedUpdate(xhttp) {
            print(xhttp);

            this.pushing = false;

            // Regardless of whether the push failed or new updates came in
            // while it was running, try again if there's updates remaining
            //if (sendableUpdates(this.view.state).length) {
            //    setTimeout(() => this.push(), 100)
            //}
        }
        
        pull() {
            print("PULL");
        }
        
        /*
        async pull() {
            while (!this.done) {
                let version = getSyncedVersion(this.view.state)
                let updates = await pullUpdates(connection, version)
                this.view.dispatch(receiveUpdates(this.view.state, updates))
            }
        }
        */
        
        send(command, callback) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    callback(this);
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
    return [collab({startVersion}), plugin]
}


cm.CreateEditor = function(parentDivId, extensions, editable=true) {
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
            extensions: extensions,
            tabSize: 2
        }),
        parent: parentDiv
    })
}
