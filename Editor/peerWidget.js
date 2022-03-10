import {Extension} from "@codemirror/state"
import {EditorView} from "@codemirror/view"
import {ViewPlugin, ViewUpdate} from "@codemirror/view"
import {Decoration, DecorationSet, WidgetType} from "@codemirror/view"
import {RangeSetBuilder} from "@codemirror/rangeset"

export const peerColors = [
    { color: '#1a6480', light: '#30bced33' },
    { color: '#3c8047', light: '#6eeb8333' },
    { color: '#805e21', light: '#ffbc4233' },
    { color: '#807225', light: '#ecd44433' },
    { color: '#80352b', light: '#ee635233' },
    { color: '#627b80', light: '#9ac2c933' },
    { color: '#578055', light: '#8acb8833' },
    { color: '#0e7480', light: '#1be7ff33' }
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
        fontSize: '.75em',
        fontFamily: 'serif',
        fontStyle: 'normal',
        fontWeight: 'normal',
        lineHeight: 'normal',
        userSelect: 'none',
        color: 'white',
        paddingLeft: '2px',
        paddingRight: '2px',
        zIndex: 101,
        transition: 'opacity .3s ease-in-out',
        backgroundColor: 'inherit'
    },
    '.cm-peerSelection0': { backgroundColor: peerColors[0].light },
    '.cm-peerSelection1': { backgroundColor: peerColors[1].light },
    '.cm-peerSelection2': { backgroundColor: peerColors[2].light },
    '.cm-peerSelection3': { backgroundColor: peerColors[3].light },
    '.cm-peerSelection4': { backgroundColor: peerColors[4].light },
    '.cm-peerSelection5': { backgroundColor: peerColors[5].light },
    '.cm-peerSelection6': { backgroundColor: peerColors[6].light },
    '.cm-peerSelection7': { backgroundColor: peerColors[7].light }
})

class PeerWidget extends WidgetType {
    
    constructor (peerInfo) {
        super()
        this.peerInfo = peerInfo;
        this.color = peerColors[peerInfo.peerIdx].color;
        this.name = peerInfo.name || peerInfo.clientID;
    }
    
    toDOM() {
        const placeholder = document.createElement('div');
        placeholder.innerHTML = `<span class="cm-peerCaret" style="background-color: ${this.color}; border-color: ${this.color}"><div class='cm-peerInfo'>${this.name}</div></span>`;
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

export function newPeerDecoration(peerdIdx, name) {
    return Decoration.widget({ widget: new PeerWidget(peerdIdx, name) })
}
