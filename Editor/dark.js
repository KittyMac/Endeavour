import {EditorView} from "@codemirror/view"
import {HighlightStyle, tags as t} from "@codemirror/highlight"


const textColor = "#d9d9d9"
const lightBackground = "#0a0a0a"
const highlightBackground = "#3f4044"
const gutterBackground = "#404040"
const hightlightGutterBackground = "#676c73"
const background = "#292a2c"
const tooltipBackground = "#262626"
const selection = "#4b4b4b"
const cursor = "#d9d9d9"

export const darkTheme = EditorView.theme({
    "&.cm-editor": {
        color: textColor,
        fontSize: '1rem',
        flex: '1 1 auto',
        alignSelf: 'stretch',
        minHeight: '0px'
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

export const darkHighlightStyle = HighlightStyle.define([
  {tag: t.link, textDecoration: "underline"},
  {tag: t.heading, textDecoration: "underline", fontWeight: "bold"},
  {tag: t.emphasis, fontStyle: "italic"},
  {tag: t.strong, fontWeight: "bold"},
  {tag: t.strikethrough, textDecoration: "line-through"},
  {tag: t.keyword, color: "#b800d2"},
  {tag: [t.atom, t.bool, t.url, t.contentSeparator, t.labelName], color: "#6859cf"},
  {tag: [t.literal, t.inserted], color: "#559e81"},
  {tag: [t.string, t.deleted], color: "#ca6666"},
  {tag: [t.regexp, t.escape, t.special(t.string)], color: "#f17d4e"},
  {tag: t.definition(t.variableName), color: "#94b9dc"},
  {tag: t.local(t.variableName), color: "#9579d7"},
  {tag: [t.typeName, t.namespace], color: "#6fc8a7"},
  {tag: t.className, color: "#69a3ae"},
  {tag: [t.special(t.variableName), t.macroName], color: "#639bad"},
  {tag: t.definition(t.propertyName), color: "#7171d6"},
  {tag: t.comment, color: "#929da9"},
  {tag: t.meta, color: "#929da9"},
  {tag: t.invalid, color: "#ff8888"}
])

export const dark = [darkTheme, darkHighlightStyle]
