#define PAMPHLET_PREPROCESSOR

#include <./defines.js>

let globalTimers = [];

function initTimers() {
    setInterval(callTimers, 250);
}

function callTimers() {
    FOREACH(timer, globalTimers) {
        timer();
    }
}

function addTimer(callback) {
    globalTimers.push(callback);
}

function clearTimer(callback) {
    removeOne(globalTimers, callback);
}

function clearAllTimer() {
    globalTimers = [];
}