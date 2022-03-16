import {Extension} from "@codemirror/state"
import {EditorView} from "@codemirror/view"
import {ViewPlugin, ViewUpdate} from "@codemirror/view"
import {Decoration, DecorationSet, WidgetType} from "@codemirror/view"
import {RangeSetBuilder} from "@codemirror/rangeset"

export const peerColors = [
    { color: 'var(--end-peer0-dark)', light: 'var(--end-peer0-light)' },
    { color: 'var(--end-peer1-dark)', light: 'var(--end-peer1-light)' },
    { color: 'var(--end-peer2-dark)', light: 'var(--end-peer2-light)' },
    { color: 'var(--end-peer3-dark)', light: 'var(--end-peer3-light)' },
    { color: 'var(--end-peer4-dark)', light: 'var(--end-peer4-light)' },
    { color: 'var(--end-peer5-dark)', light: 'var(--end-peer5-light)' },
    { color: 'var(--end-peer6-dark)', light: 'var(--end-peer6-light)' },
    { color: 'var(--end-peer7-dark)', light: 'var(--end-peer7-light)' }
];

export const peerWidgetBaseTheme = EditorView.baseTheme({
    //"&light .cm-peerLine": {backgroundColor: "#d4fafa"},
    //"&dark .cm-peerLine": {backgroundColor: "#1a2727"},
    
    '.cm-peerCaret': {
        position: 'relative',
        borderLeft: '1px solid black',
        borderRight: '1px solid black',
        marginLeft: '-1px',
        marginRight: '-1px',
        boxSizing: 'border-box',
        display: 'inline'
    },
    '.cm-peerInfo': {
        position: 'absolute',
        top: '-1.05em',
        left: '-1px',
        fontSize: '.75rem',
        fontFamily: 'serif',
        fontStyle: 'normal',
        fontWeight: 'normal',
        lineHeight: 'normal',
        userSelect: 'none',
        paddingLeft: '0.3rem',
        paddingRight: '0.3rem',
        zIndex: 101,
        transition: 'opacity .3s ease-in-out',
        backgroundColor: 'inherit',
        borderRadius: '0.3rem 0.3rem 0.3rem 0rem'
    }
})

class PeerWidget extends WidgetType {
    
    constructor (peerInfo) {
        super()
        this.peerInfo = peerInfo;
        this.color = peerColors[peerInfo.peerIdx];
        this.name = peerInfo.name || peerInfo.clientID;
    }
    
    toDOM() {
        const placeholder = document.createElement('div');
        placeholder.innerHTML = `<span class="cm-peerCaret" style="color: ${this.color.light};background-color: ${this.color.color}; border-color: ${this.color.color}"><div class='cm-peerInfo'>${this.name}</div></span>`;
        return placeholder.firstElementChild;
    }
    
    eq (widget) {
        return widget.color === this.color
    }

    compare (widget) {
        return widget.color === this.color
    }

    updateDOM () {
        return false;
    }

    get estimatedHeight () {
        return -1
    }

    ignoreEvent () {
        return true
    }
}

export function newPeerDecoration(peerInfo) {
    return Decoration.widget({ widget: new PeerWidget(peerInfo) })
}
