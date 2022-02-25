#define PAMPHLET_PREPROCESSOR

var alertsQueue = [];

function handleAlertsQueue() {
    var openContainer = function() {
        if (alertsContainer.isOpen == false) {
            alertsContainer.isOpen = true;
            
            alertsContainer.style.display = "flex";
            Laba.cancel(alertsContainer);
            Laba.animate(alertsContainer, "f1", undefined, function() { });
        }
    }
    var closeContainer = function() {
        if (alertsContainer.isOpen == true) {
            alertsContainer.isOpen = false;
            
            Laba.cancel(alertsContainer);
            Laba.animate(alertsContainer, "f0", undefined, function() {
                alertsContainer.style.display = "none";
            });
        }
    }
    var closeAlert = function (uniqueID) {
        var alertDiv = document.getElementById(uniqueID);
        if (alertDiv != undefined) {
            if (alertsQueue.length == 0) {
                closeContainer();
            }
        	Laba.animate(alertDiv, "!f0", function(div, t) {
        	    div.style.height = ((1.0 - t) * div.actualHeight) + "px";
                div.style.minHeight = div.style.height;
        	}, function() {
        	    removeFromParent(alertDiv);
                handleAlertsQueue();
        	});
        }
    }
    
    var openAlert = function (alert) {
        var message = alert.message;
        var buttons = alert.buttons;
        var callbacks = alert.callbacks;
        
        var uniqueID = UNIQUEID();
        var buttonsHtml = '';
        var first = true;
        for (var idx = buttons.length-1; idx >= 0; idx -= 1) {
            var btnName = buttons[idx];
            if (first) {
                first = false;
                buttonsHtml += `ALERT_BUTTON_CONTROL_DEFAULT(${uniqueID}Btn${idx},${btnName})`;
            } else {
                buttonsHtml += `ALERT_BUTTON_CONTROL(${uniqueID}Btn${idx},${btnName})`;
            }
        }
        var alertHtml = `ALERT(${uniqueID},${message},${buttonsHtml})`;
        insertHtml(alertsContainer, alertHtml);
    
        for (var idx = callbacks.length-1; idx >= 0; idx -= 1) {
            var button0 = document.getElementById(uniqueID + "Btn" + idx);
            button0.callback = callbacks[idx];
            button0.addEventListener("mouseup", function(evt) {
                if (evt.currentTarget.callback != undefined) {
                    evt.currentTarget.callback();
                }
                closeAlert(uniqueID);
            });
        }
        
        requestAnimationFrame(function() {
            var alertDiv = document.getElementById(uniqueID);
        
            alertDiv.actualHeight = alertDiv.offsetHeight;
        	Laba.animate(alertDiv, "!f1", function(div, t) {
        	    div.style.height = (t * div.actualHeight) + "px";
                div.style.minHeight = div.style.height;
        	}, function(div) {
                div.style.height = "";
        	});
        });
    }
    
    if (alertsQueue.length == 0) {
        closeContainer();
        return;
    }
    
    openContainer();
    
    if (alertsContainer.children.length == 0) {
        openAlert(alertsQueue.shift());
    }
}

function alert(message, buttons, callbacks) {
    if (message == undefined || message.length == 0) {
        return;
    }
    
    if (alertsContainer.isOpen == undefined) {
        alertsContainer.isOpen = false;
    }
    
    if (buttons == undefined) {
        buttons = ["Ok"];
    }
    if (callbacks == undefined) {
        callbacks = [undefined];
    }
    
    alertsQueue.push({
        message:message,
        buttons:buttons,
        callbacks:callbacks,
    })
    
    handleAlertsQueue();
}