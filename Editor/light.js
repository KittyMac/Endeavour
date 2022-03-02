import {EditorView} from "@codemirror/view"
import {HighlightStyle, tags as t} from "@codemirror/highlight"

const textColor = "#272727"
const lightBackground = "#f5f5f5"
const highlightBackground = "#f3f9ff"
const gutterBackground = "#f5f5f5"
const hightlightGutterBackground = "#e5f1fe"
const background = "#ffffff"
const tooltipBackground = "#f5f5f5"
const selection = "#d9d9d9"
const cursor = "#272727"

export const lightTheme = EditorView.theme({
    "&.cm-editor": {
        color: textColor,
        fontSize: '1rem',
        flex: '1 1 auto',
        alignSelf: 'stretch',
        minHeight: '0px',
        overflow: 'hidden'
    },
    ".cm-scroller": {
        fontFamily:'Roboto Mono, Courier New, monospace',
        overflow: 'auto',
    },
    "&": {
        color: textColor,
        backgroundColor: background
    },

    ".cm-content": {
        caretColor: cursor
    },

    ".cm-cursor, .cm-dropCursor": {borderLeftColor: cursor},
    "&.cm-focused .cm-selectionBackground, .cm-selectionBackground, .cm-content ::selection": {backgroundColor: selection},

    ".cm-panels": {backgroundColor: lightBackground, color: textColor},
    ".cm-panels.cm-panels-top": {borderBottom: "2px solid black"},
    ".cm-panels.cm-panels-bottom": {borderTop: "2px solid black"},

    ".cm-searchMatch": {
        backgroundColor: "#72a1ff59",
        outline: "1px solid #457dff"
    },
    ".cm-searchMatch.cm-searchMatch-selected": {
        backgroundColor: "#6199ff2f"
    },

    ".cm-activeLine": {backgroundColor: highlightBackground},
    ".cm-selectionMatch": {backgroundColor: "#aafe661a"},

    "&.cm-focused .cm-matchingBracket, &.cm-focused .cm-nonmatchingBracket": {
        backgroundColor: "#bad0f847",
        outline: "1px solid #515a6b"
    },

    ".cm-gutters": {
        backgroundColor: gutterBackground,
        color: "#999999",
        border: "none"
    },

    ".cm-activeLineGutter": {
        backgroundColor: hightlightGutterBackground
    },

    ".cm-foldPlaceholder": {
        backgroundColor: "transparent",
        border: "none",
        color: "#ddd"
    },

    ".cm-tooltip": {
        border: "none",
        backgroundColor: tooltipBackground
    },
    ".cm-tooltip .cm-tooltip-arrow:before": {
        borderTopColor: "transparent",
        borderBottomColor: "transparent"
    },
    ".cm-tooltip .cm-tooltip-arrow:after": {
        borderTopColor: tooltipBackground,
        borderBottomColor: tooltipBackground
    },
    ".cm-tooltip-autocomplete": {
        "& > ul > li[aria-selected]": {
            backgroundColor: highlightBackground,
            color: textColor
        }
    }
})

export const lightHighlightStyle = HighlightStyle.define([
  {tag: t.link, textDecoration: "underline"},
  {tag: t.heading, textDecoration: "underline", fontWeight: "bold"},
  {tag: t.emphasis, fontStyle: "italic"},
  {tag: t.strong, fontWeight: "bold"},
  {tag: t.strikethrough, textDecoration: "line-through"},
  {tag: t.keyword, color: "#708"},
  {tag: [t.atom, t.bool, t.url, t.contentSeparator, t.labelName], color: "#219"},
  {tag: [t.literal, t.inserted], color: "#164"},
  {tag: [t.string, t.deleted], color: "#a11"},
  {tag: [t.regexp, t.escape, t.special(t.string)], color: "#e40"},
  {tag: t.definition(t.variableName), color: "#619bd3"},
  {tag: t.local(t.variableName), color: "#30a"},
  {tag: [t.typeName, t.namespace], color: "#085"},
  {tag: t.className, color: "#167"},
  {tag: [t.special(t.variableName), t.macroName], color: "#256"},
  {tag: t.definition(t.propertyName), color: "#00c"},
  {tag: t.comment, color: "#737f8c"},
  {tag: t.meta, color: "#999999"},
  {tag: t.invalid, color: "#f00"}
])

export const light = [lightTheme, lightHighlightStyle]
