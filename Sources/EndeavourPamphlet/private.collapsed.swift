import Foundation

// swiftlint:disable all

public extension EndeavourPamphlet.Private {
    static func ScriptCombinedJs() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/script.combined.js"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/usr/local/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /usr/local/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    #else
        return uncompressedScriptCombinedJs
    #endif
    }
    static func ScriptCombinedJsGzip() -> Data {
        return compressedScriptCombinedJs
    }
}

private let uncompressedScriptCombinedJs = ###"""
function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}var alertsQueue=[];function handleAlertsQueue(){let e=function(e,t){e.style.height=t*e.actualHeight+"px",e.style.minHeight=e.style.height};var t=function(){1==alertsContainer.isOpen&&(alertsContainer.isOpen=!1,Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f0",void 0,(function(){alertsContainer.style.display="none"})))},n=function(n){var a=document.getElementById(n);null!=a&&""!==a&&"undefined"!==a&&(0==alertsQueue.length&&t(),Laba.animate(a,"!f0",(function(t,n){e(t,1-n)}),(function(){removeFromParent(a),handleAlertsQueue()})))};0!=alertsQueue.length?(0==alertsContainer.isOpen&&(alertsContainer.isOpen=!0,alertsContainer.style.display="flex",Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f1",void 0,(function(){}))),0==alertsContainer.children.length&&function(t){for(var a=t.value,r=t.ask,i=t.message,o=t.buttons,l=t.callbacks,s=UNIQUEID(),u="",m=!0,c=o.length-1;c>=0;c-=1){var f=o[c];m?(m=!1,u+=`<div id="${s}Btn${c}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;background:var(--fh-btn-background);" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="${s}Btn${c}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${f}</div></div>`):u+=`<div id="${s}Btn${c}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;color:var(--fh-btn-background);" onmousedown="this.style.color='var(--fh-btn-highlight)'" onmouseout="this.style.color='var(--fh-btn-background)'" onmouseup="this.style.color='var(--fh-btn-background)'"><div id="${s}Btn${c}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${f}</div></div>`}insertHtml(alertsContainer,r?`<div id="${s}" class="Alert" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;color:var(--fh-fblack);font-size:1rem;font-family:'Lato';margin-top:2rem;margin-left:0.5rem;margin-bottom:0rem;margin-right:0.5rem;">${i}</div> <input id="${s}Value" style="display:flex;flex: 1 1 auto;align-self:stretch;min-width:0rem;height:2rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;border:0.1rem solid var(--fh-fgrey);border-radius:1rem;font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:0.5rem;margin-bottom:2rem;margin-right:0.5rem;" type="text" placeholder="..." /> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${u}</div></div>`:`<div id="${s}" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;margin-top:0rem;margin-left:0rem;margin-bottom:0.5rem;margin-right:0rem;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:1rem;margin-bottom:1rem;margin-right:1rem;color:var(--fh-fblack);">${i}</div></div> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${u}</div></div>`);var h=document.getElementById(s+"Value");for(null!=h&&""!==h&&"undefined"!==h&&(h.callback=l[l.length-1],textFieldOnEnter(h,(function(){let e;null!=h&&""!==h&&"undefined"!==h&&(e=h.value),null!=h.callback&&""!==h.callback&&"undefined"!==h.callback&&h.callback(e),n(s)})),h.value=a,h.focus()),c=l.length-1;c>=0;c-=1){var d=document.getElementById(s+"Btn"+c);d.callback=l[c],d.addEventListener("mouseup",(function(e){let t;null!=h&&""!==h&&"undefined"!==h&&(t=h.value),null!=e.currentTarget.callback&&""!==e.currentTarget.callback&&"undefined"!==e.currentTarget.callback&&e.currentTarget.callback(t),n(s)}))}requestAnimationFrame((function(){var t=document.getElementById(s);t.actualHeight=t.offsetHeight,Laba.animate(t,"!f1",(function(t,n){e(t,n)}),(function(e){e.style.height=""}))}))}(alertsQueue.shift())):t()}function alert(e,t,n){null!=e&&""!==e&&(null!=alertsContainer.isOpen&&""!==alertsContainer.isOpen||(alertsContainer.isOpen=!1),null!=t&&""!==t||(t=["Ok"]),null!=n&&""!==n||(n=[void 0]),e=e.replaceAll("\n","<br>"),alertsQueue.push({message:e,buttons:t,callbacks:n}),handleAlertsQueue())}function ask(e,t,n,a){null!=e&&""!==e&&(null!=alertsContainer.isOpen&&""!==alertsContainer.isOpen||(alertsContainer.isOpen=!1),null!=n&&""!==n||(n=["Ok"]),null!=a&&""!==a||(a=[void 0]),e=e.replaceAll("\n","<br>"),alertsQueue.push({value:t,ask:!0,message:e,buttons:n,callbacks:a}),handleAlertsQueue())}function initButton(e,t,n){if(null!=e.length)for(let t,a=null!=e?e:[],r=0;t=a[r],r<a.length;r++)t.addEventListener("mouseup",(function(e){null!=n&&n(this)}));else e.addEventListener("mouseup",(function(e){null!=n&&n(this)}))}function StringBuilder(){var e=[];this.length=function(){for(var t=0,n=0;n<e.length;n++)t+=e[n].length;return t},this.setLength=function(t){let n=e.join("").substring(0,t);(e=[])[0]=n},this.insert=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=n,e[2]=a.substring(t)},this.delete=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=a.substring(n+1)},this.append=function(n){(n=t(n)).length>0&&(e[e.length]=n)},this.appendLine=function(n){if(n=t(n),this.isEmpty()){if(!(n.length>0))return;e[e.length]=n}else e[e.length]=n.length>0?"\r\n"+n:"\r\n"},this.clear=function(){e=[]},this.isEmpty=function(){return 0==e.length},this.toString=function(){return e.join("")};var t=function(e){return n(e)?a(e)!=a(new String)?String(e):e:""},n=function(e){return null!=e&&void 0!==e},a=function(e){if(!n(e.constructor))throw Error("Unexpected object type");var t=String(e.constructor).match(/function\s+(\w+)/);return n(t)?t[1]:"undefined"}}function easeLinear(e){return 0+1*e}function easeInQuad(e){return 0,1*e*e+0}function easeOutQuad(e){return 0,-1*e*(e-2)+0}function easeInOutQuad(e){return 0,(e/=.5)<1?.5*e*e+0:-.5*(--e*(e-2)-1)+0}function easeInCubic(e){return 0,1*e*e*e+0}function easeOutCubic(e){return 0,1*(--e*e*e+1)+0}function easeInOutCubic(e){return 0,(e/=.5)<1?.5*e*e*e+0:.5*((e-=2)*e*e+2)+0}function easeInQuart(e){return 0,1*e*e*e*e+0}function easeOutQuart(e){return 0,-1*(--e*e*e*e-1)+0}function easeInOutQuart(e){return 0,(e/=.5)<1?.5*e*e*e*e+0:-.5*((e-=2)*e*e*e-2)+0}function easeInQuint(e){return 0,1*e*e*e*e*e+0}function easeOutQuint(e){return 0,1*(--e*e*e*e*e+1)+0}function easeInOutQuint(e){return 0,(e/=.5)<1?.5*e*e*e*e*e+0:.5*((e-=2)*e*e*e*e+2)+0}function easeInSine(e){return 0,-1*Math.cos(e/1*(Math.PI/2))+1+0}function easeOutSine(e){return 0,1*Math.sin(e/1*(Math.PI/2))+0}function easeInOutSine(e){return 0,-.5*(Math.cos(Math.PI*e/1)-1)+0}function easeInExpo(e){return 0,1*Math.pow(2,10*(e/1-1))+0}function easeOutExpo(e){return 0,1*(1-Math.pow(2,-10*e/1))+0}function easeInOutExpo(e){return 0,(e/=.5)<1?.5*Math.pow(2,10*(e-1))+0:(e--,.5*(2-Math.pow(2,-10*e))+0)}function easeInCirc(e){return 0,-1*(Math.sqrt(1-e*e)-1)+0}function easeOutCirc(e){return e--,0,1*Math.sqrt(1-e*e)+0}function easeInOutCirc(e){return 0,(e/=.5)<1?-.5*(Math.sqrt(1-e*e)-1)+0:(e-=2,.5*(Math.sqrt(1-e*e)+1)+0)}function easeOutBounce(e){return e<4/11?121*e*e/16:e<8/11?9.075*e*e-9.9*e+3.4:e<.9?4356/361*e*e-35442/1805*e+16061/1805:10.8*e*e-20.52*e+10.72}function easeInBounce(e){return 1-easeOutBounce(1-e)}function easeInOutBounce(e){return e<.5?.5*easeInBounce(2*e):.5*easeOutBounce(2*e-1)+.5}function easeShake(e){return(Math.sin(3.14*e*6+.785)-.5)*(1-e)}String.prototype.format=function(){for(k in a=this,arguments)a=a.replace("{"+k+"}",arguments[k]);return a},Math.radians=function(e){return e*Math.PI/180},Math.degrees=function(e){return 180*e/Math.PI};var _allLabalTimers=[];class _LabaTimer{update(){var e=(performance.now()-this.startTime)/(this.endTime-this.startTime);if(this.endTime==this.startTime&&(e=1),e>=1&&(e=1),null!=this.onUpdate){var t=this.action.easing;null==t&&(t=easeInOutQuad),this.onUpdate(this.view,t(e))}if(e>=1)return this.action(e,!1),-1==this.loopCount?(this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):this.loopCount>1?(this.loopCount--,this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):(removeOne(_allLabalTimers,this),null!=this.onComplete&&this.onComplete(this.view),void this.view.labaCommitElemVars());this.action(e,!1),this.view.labaCommitElemVars()}constructor(e,t,n,a,r,i,o,l){this.view=e,this.loopCount=l,this.action=t,this.duration=r,this.onComplete=o,this.onUpdate=i,this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,this.action(0,!0),_allLabalTimers.push(this),this.update(0)}}class _LabaAction{constructor(e,t,n,a,r,i,o){this.operatorChar=t,this.elem=n,this.inverse=a,this.rawValue=r,this.easing=i,this.easingName=o,this.action=e.PerformActions[t],this._describe=e.DescribeActions[t],this._init=e.InitActions[t],0==this.inverse?(this.fromValue=0,this.toValue=1):(this.fromValue=1,this.toValue=0),null!=this._init&&this._init(this)}reset(e){if(null!=this._init){var t=new _LabaAction(e,this.operatorChar,this.elem,this.inverse,this.rawValue,this.easing,this.easingName);return this.fromValue=t.fromValue,this.toValue=t.toValue,!0}return!1}perform(e){return null!=this.action&&(this.action(this.elem,this.fromValue+(this.toValue-this.fromValue)*this.easing(e),this),!0)}describe(e){return null!=this._describe&&(this._describe(e,this),!0)}}class _Laba{isOperator(e){return","==e||"|"==e||"!"==e||"e"==e||e in this.InitActions}isNumber(e){return"+"==e||"-"==e||"0"==e||"1"==e||"2"==e||"3"==e||"4"==e||"5"==e||"6"==e||"7"==e||"8"==e||"9"==e||"."==e}update(){for(var e in _allLabalTimers)_allLabalTimers[e].update()}parseAnimationString(e,t){for(var n=0,a=0,r=0,i=this.allEasings[3],o=this.allEasingsByName[3],l=[],s=0;s<this.kMaxPipes;s++){l[s]=[];for(var u=0;u<this.kMaxActions;u++)l[s][u]=void 0}for(;n<t.length;){for(var m=!1,c=" ";n<t.length;){var f=t[n];if(this.isOperator(f))if("!"==f)m=!0;else if("|"==f)a++,r=0;else{if(","!=f){c=f,n++;break}0!=r&&(a++,r=0),l[a][r]=new _LabaAction(this,"d",e,!1,.26*this.kDefaultDuration,i,o),a++,r=0}n++}for(;n<t.length&&!this.isNumber(t[n])&&!this.isOperator(t[n]);)n++;var h=this.LabaDefaultValue;if(n<t.length&&this.isNumber(t[n])){var d=!1;"+"==t[n]?n++:"-"==t[n]&&(d=!0,n++),h=0;for(var p=!1,g=10;n<t.length;){f=t[n];if(this.isNumber(f)&&(f>="0"&&f<="9"&&(p?(h+=(f-"0")/g,g*=10):h=10*h+(f-"0")),"."==f&&(p=!0)),this.isOperator(f))break;n++}d&&(h*=-1)}if(" "!=c)if(c in this.InitActions)l[a][r]=new _LabaAction(this,c,e,m,h,i,o),r++;else if("e"==c){var b=h;b>=0&&n<this.allEasings.length&&(i=this.allEasings[b],o=this.allEasingsByName[b])}}return l}animateOne(e,t,n,a){for(var r=this,i=this.parseAnimationString(e,t),o=this.PerformActions.d,l=this.PerformActions.D,s=this.PerformActions.L,u=this.PerformActions.l,m=0,c=0,f=1,h=!1,d=0;d<this.kMaxPipes;d++)if(null!=i[d][0]){m++;for(var p=this.kDefaultDuration,g=0;g<this.kMaxActions;g++)null!=i[d][g]&&(i[d][g].action!=o&&i[d][g].action!=l||(p=i[d][g].fromValue),i[d][g].action==s&&(f=i[d][g].fromValue),i[d][g].action==u&&(h=!0,f=i[d][g].fromValue));c+=p}if(1==m)if(h)new _LabaTimer(e,(function(e,t){if(1==t)for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].reset(r));n++);for(var a=0;a<r.kMaxActions&&(null==i[0][a]||i[0][a].perform(e));a++);}),0,1,c,n,a,f);else{for(g=0;g<r.kMaxActions&&(null==i[0][g]||i[0][g].reset(r));g++);new _LabaTimer(e,(function(e,t){for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].perform(e));n++);}),0,1,c*r.kTimeScale,n,a,f)}else{for(var b=void 0,v=m-1;v>=0;v--){p=this.kDefaultDuration;var x=1,w=!1;for(g=0;g<this.kMaxActions;g++)null!=i[v][g]&&(i[v][g].action!=o&&i[v][g].action!=l||(p=i[v][g].fromValue),i[v][g].action==s&&(x=i[v][g].fromValue),i[v][g].action==u&&(w=!0,x=i[v][g].fromValue));let t=v;var V=b;null==V&&(V=a),null==V&&(V=function(){});let m=w,c=p,f=x,h=V;b=function(){if(m)new _LabaTimer(e,(function(e,n){if(1==n)for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);for(a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c,n,h,f);else{for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);new _LabaTimer(e,(function(e,n){for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c*r.kTimeScale,n,h,f)}}}null!=b?b():null!=a&&a(this.view)}}reset(e){if(null==e.labaTransformX){var t=e;t.labaResetElemVars=function(){t.labaTransformX=0,t.labaTransformY=0,t.labaTransformZ=0,t.labaRotationX=0,t.labaRotationY=0,t.labaRotationZ=0,t.labaScale=1,null!=t.style&&(t.labaAlpha=parseFloat(t.style.opacity)),isNaN(t.labaAlpha)&&(t.labaAlpha=1)},t.labaCommitElemVars=function(){if(null!=t.position&&(t.position.set(t.labaTransformX,t.labaTransformY),t.scale.set(t.labaScale,t.labaScale),t.rotation=t.labaRotationZ,t.alpha=t.labaAlpha),null!=t.style){var e=Matrix.identity();e=Matrix.multiply(e,Matrix.translate(t.labaTransformX,t.labaTransformY,t.labaTransformZ)),e=Matrix.multiply(e,Matrix.rotateX(Math.radians(t.labaRotationX))),e=Matrix.multiply(e,Matrix.rotateY(Math.radians(t.labaRotationY))),e=Matrix.multiply(e,Matrix.rotateZ(Math.radians(t.labaRotationZ))),e=Matrix.multiply(e,Matrix.scale(t.labaScale,t.labaScale,t.labaScale));let n="perspective(500px) matrix3d({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15})".format(e.m00,e.m10,e.m20,e.m30,e.m01,e.m11,e.m21,e.m31,e.m02,e.m12,e.m22,e.m32,e.m03,e.m13,e.m23,e.m33);t.style.webkitTransform=n,t.style.MozTransform=n,t.style.msTransform=n,t.style.OTransform=n,t.style.transform=n,t.style.opacity=t.labaAlpha}}}e.labaResetElemVars(),null==e.style&&null!=e.position&&(e.labaTransformX=e.position.x,e.labaTransformY=e.position.y,e.labaRotationZ=e.rotation,e.labaScale=e.scale.x,e.labaAlpha=e.alpha)}set(e,t,n,a,r,i,o,l,s){this.reset(e),e.labaTransformX=t,e.labaTransformY=n,e.labaTransformZ=a,e.labaRotationX=r,e.labaRotationY=i,e.labaRotationZ=o,e.labaScale=l,e.labaAlpha=s,e.labaCommitElemVars()}animate(e,t,n,a){if(null==e.labaTransformX&&this.reset(e),t.includes("["))for(var r=t.replace("["," ").split("]"),i=0;i<r.length;i++){var o=r[i];o.length>0&&(this.animateOne(e,o,n,a),a=void 0)}else this.animateOne(e,t,n,a),a=void 0}cancel(e){for(var t in _allLabalTimers)_allLabalTimers[t].view==e&&removeOne(_allLabalTimers,_allLabalTimers[t])}describeOne(e,t,n){for(var a=this.parseAnimationString(e,t),r=this.PerformActions.d,i=this.PerformActions.D,o=this.PerformActions.L,l=this.PerformActions.l,s=0,u=0,m=1,c="absolute",f=0;f<this.kMaxPipes;f++)if(null!=a[f][0]){s++;for(var h=this.kDefaultDuration,d=0;d<this.kMaxActions;d++)null!=a[f][d]&&(a[f][d].action!=r&&a[f][d].action!=i||(h=a[f][d].fromValue),a[f][d].action==o&&(m=a[f][d].fromValue),a[f][d].action==l&&(m=a[f][d].fromValue,c="relative"));u+=h}if(1==s){var p=n.length();for(f=0;f<this.kMaxActions&&(null==a[0][f]||a[0][f].describe(n));f++);m>1?n.append(" {0} repeating {1} times, ".format(c,m)):-1==m&&n.append(" {0} repeating forever, ".format(c)),p!=n.length()?(n.append(" {0}  ".format(a[0][0].easingName)),n.setLength(n.length()-2),0==u?n.append(" instantly."):n.append(" over {0} seconds.".format(u*this.kTimeScale))):(n.length()>2&&n.setLength(n.length()-2),n.append(" wait for {0} seconds.".format(u*this.kTimeScale)))}else for(var g=0;g<s;g++){p=n.length(),h=this.kDefaultDuration;var b=1,v="absolute";for(d=0;d<this.kMaxActions;d++)null!=a[g][d]&&(a[g][d].action!=r&&a[g][d].action!=i||(h=a[g][d].fromValue),a[g][d].action==o&&(b=a[g][d].fromValue),a[g][d].action==l&&(b=a[g][d].fromValue,v="relative"));var x=g;for(d=0;d<this.kMaxActions&&(null==a[x][d]||a[x][d].reset(this));d++);for(d=0;d<this.kMaxActions&&(null==a[x][d]||a[x][d].describe(n));d++);b>1?n.append(" {0} repeating {1} times, ".format(v,b)):-1==b&&n.append(" {0} repeating forever, ".format(v)),p!=n.length()?(n.append(" {0}  ".format(a[x][0].easingName)),n.setLength(n.length()-2),0==h?n.append(" instantly."):n.append(" over {0} seconds.".format(h*this.kTimeScale))):n.append(" wait for {0} seconds.".format(h*this.kTimeScale)),g+1<s&&n.append(" Once complete then  ")}}describe(e,t){if(null==t||0==t.length)return"do nothing";var n=new StringBuilder;if(t.includes("[")){var a=t.replace("["," ").split("]"),r=0;n.append("Perform a series of animations at the same time.\n");for(var i=0;i<a.length;i++){var o=a[i];o.length>0&&(n.append("Animation #{0} will ".format(r+1)),this.describeOne(e,o,n),n.append("\n"),r++)}}else this.describeOne(e,t,n);return n.length()>0&&(n.insert(0,n.toString().substring(0,1).toUpperCase()),n.delete(1,1)),n.toString()}registerOperation(e,t,n,a){this.InitActions[e]=t,this.PerformActions[e]=n,this.DescribeActions[e]=a}constructor(){this.allEasings=[easeLinear,easeInQuad,easeOutQuad,easeInOutQuad,easeInCubic,easeOutCubic,easeInOutCubic,easeInQuart,easeOutQuart,easeInOutQuart,easeInQuint,easeOutQuint,easeInOutQuint,easeInSine,easeOutSine,easeInOutSine,easeInExpo,easeOutExpo,easeInOutExpo,easeInCirc,easeOutCirc,easeInOutCirc,easeInBounce,easeOutBounce,easeInOutBounce,easeShake],this.allEasingsByName=["ease linear","ease out quad","ease in quad","ease in/out quad","ease in cubic","ease out cubic","ease in/out cubic","ease in quart","ease out quart","ease in/out quart","ease in quint","ease out quint","ease in/out quint","ease in sine","eas out sine","ease in/out sine","ease in expo","ease out expo","ease in out expo","ease in circ","ease out circ","ease in/out circ","ease in bounce","ease out bounce","ease in/out bounce","ease shake"],this.LabaDefaultValue=Number.MIN_VALUE,this.InitActions={},this.PerformActions={},this.DescribeActions={},this.kMaxPipes=40,this.kMaxActions=40,this.kDefaultDuration=.57,this.kTimeScale=1;let e=this.LabaDefaultValue,t=this.kDefaultDuration;this.registerOperation("L",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("l",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("d",(function(n){return n.rawValue==e&&(n.rawValue=t),n.fromValue=n.toValue=n.rawValue,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("D",(function(n){n.rawValue==e&&(n.rawValue=t);for(var a=0,r=n.elem;null!=(r=r.previousSibling);)a++;return n.fromValue=n.toValue=n.rawValue*a,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("x",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move from {0} x pos, ".format(t.rawValue)):e.append("move to {0} x pos, ".format(t.rawValue))})),this.registerOperation("y",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move from {0} y pos, ".format(t.rawValue)):e.append("move to {0} y pos, ".format(t.rawValue))})),this.registerOperation("z",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformZ):(t.fromValue=t.elem.labaTransformZ,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformZ=t}),(function(e,t){t.inverse?e.append("move from {0} z pos, ".format(t.rawValue)):e.append("move to {0} z pos, ".format(t.rawValue))})),this.registerOperation("<",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX+t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX-t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from right {0} units, ".format(t.rawValue)):e.append("move left {0} units, ".format(t.rawValue))})),this.registerOperation(">",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX-t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX+t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from left {0} units, ".format(t.rawValue)):e.append("move right {0} units, ".format(t.rawValue))})),this.registerOperation("^",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY+t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY-t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from below {0} units, ".format(t.rawValue)):e.append("move up {0} units, ".format(t.rawValue))})),this.registerOperation("v",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY-t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY+t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from above {0} units, ".format(t.rawValue)):e.append("move down {0} units, ".format(t.rawValue))})),this.registerOperation("s",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaScale,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaScale=t}),(function(e,t){t.inverse?e.append("scale in from {0}%, ".format(100*t.rawValue)):e.append("scale to {0}%, ".format(100*t.rawValue))})),this.registerOperation("r",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationZ+t.rawValue,t.toValue=t.elem.labaRotationZ):(t.fromValue=t.elem.labaRotationZ,t.toValue=t.elem.labaRotationZ-t.rawValue),t}),(function(e,t,n){e.labaRotationZ=t}),(function(e,t){t.inverse?e.append("rotate in from around z by {0}, ".format(t.rawValue)):e.append("rotate around z by {0}, ".format(t.rawValue))})),this.registerOperation("p",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationX+t.rawValue,t.toValue=t.elem.labaRotationX):(t.fromValue=t.elem.labaRotationX,t.toValue=t.elem.labaRotationX-t.rawValue),t}),(function(e,t,n){e.labaRotationX=t}),(function(e,t){t.inverse?e.append("rotate in from around x by {0}, ".format(t.rawValue)):e.append("rotate around x by {0}, ".format(t.rawValue))})),this.registerOperation("w",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationY+t.rawValue,t.toValue=t.elem.labaRotationY):(t.fromValue=t.elem.labaRotationY,t.toValue=t.elem.labaRotationY-t.rawValue),t}),(function(e,t,n){e.labaRotationY=t}),(function(e,t){t.inverse?e.append("rotate in from around y by {0}, ".format(t.rawValue)):e.append("rotate around y by {0}, ".format(t.rawValue))})),this.registerOperation("f",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaAlpha,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaAlpha=t}),(function(e,t){t.inverse?e.append("fade from {0}% to {1}%, ".format(100*t.fromValue,100*t.toValue)):e.append("fade to {0}%, ".format(100*t.rawValue))}))}}var Laba=new _Laba;class Matrix{constructor(e,t,n,a,r,i,o,l,s,u,m,c,f,h,d,p){this.m00=e,this.m01=t,this.m02=n,this.m03=a,this.m10=r,this.m11=i,this.m12=o,this.m13=l,this.m20=s,this.m21=u,this.m22=m,this.m23=c,this.m30=f,this.m31=h,this.m32=d,this.m33=p}static identity(){return new Matrix(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)}static translate(e,t,n){return new Matrix(1,0,0,e,0,1,0,t,0,0,1,n,0,0,0,1)}static scale(e,t,n){return new Matrix(e,0,0,0,0,t,0,0,0,0,n,0,0,0,0,1)}static rotateX(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(1,0,0,0,0,n,-t,0,0,t,n,0,0,0,0,1)}static rotateY(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,0,t,0,0,1,0,0,-t,0,n,0,0,0,0,1)}static rotateZ(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,-t,0,0,t,n,0,0,0,0,1,0,0,0,0,1)}static ortho(e,t,n,a,r,i){return new Matrix(2/(t-e),0,0,-(t+e)/(t-e),0,2/(a-n),0,-(a+n)/(a-n),0,0,-2/(i-r),-(i+r)/(i-r),0,0,0,1)}static ortho2d(e,t,n,a){return new Matrix.ortho(e,t,n,a,-1,1)}static frustrum(e,t,n,a,r,i){return new Matrix(2*r/(t-e),0,(t+e)/(t-e),0,0,2*r/(a-n),(a+n)/(a-n),0,0,0,-(i+r)/(i-r),-2*i*r/(i-r),0,0,-1,0)}static perspective(e,t,n,a){let r=n*tan(e*Float.pi/360),i=-r;return m4_frustrum(i*t,r*t,i,r,n,a)}static multiply(e,t){var n=Matrix.identity();return n.m00=e.m00*t.m00+e.m01*t.m10+e.m02*t.m20+e.m03*t.m30,n.m10=e.m10*t.m00+e.m11*t.m10+e.m12*t.m20+e.m13*t.m30,n.m20=e.m20*t.m00+e.m21*t.m10+e.m22*t.m20+e.m23*t.m30,n.m30=e.m30*t.m00+e.m31*t.m10+e.m32*t.m20+e.m33*t.m30,n.m01=e.m00*t.m01+e.m01*t.m11+e.m02*t.m21+e.m03*t.m31,n.m11=e.m10*t.m01+e.m11*t.m11+e.m12*t.m21+e.m13*t.m31,n.m21=e.m20*t.m01+e.m21*t.m11+e.m22*t.m21+e.m23*t.m31,n.m31=e.m30*t.m01+e.m31*t.m11+e.m32*t.m21+e.m33*t.m31,n.m02=e.m00*t.m02+e.m01*t.m12+e.m02*t.m22+e.m03*t.m32,n.m12=e.m10*t.m02+e.m11*t.m12+e.m12*t.m22+e.m13*t.m32,n.m22=e.m20*t.m02+e.m21*t.m12+e.m22*t.m22+e.m23*t.m32,n.m32=e.m30*t.m02+e.m31*t.m12+e.m32*t.m22+e.m33*t.m32,n.m03=e.m00*t.m03+e.m01*t.m13+e.m02*t.m23+e.m03*t.m33,n.m13=e.m10*t.m03+e.m11*t.m13+e.m12*t.m23+e.m13*t.m33,n.m23=e.m20*t.m03+e.m21*t.m13+e.m22*t.m23+e.m23*t.m33,n.m33=e.m30*t.m03+e.m31*t.m13+e.m32*t.m23+e.m33*t.m33,n}}function isDarkMode(){return!(!window.matchMedia||!window.matchMedia("(prefers-color-scheme: dark)").matches)}function watchDarkMode(e){window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change",(t=>{e(t.matches)}))}function print(e){console.log(e)}function hide(e){e.style.display="none"}function show(e){e.style.display="flex"}function hashCode(e){return e.split("").reduce((function(e,t){return(e=(e<<5)-e+t.charCodeAt(0))&e}),0)}function onRangeChange(e,t){var n,a,r;e.addEventListener("input",(function(e){n=1,(a=e.target.value)!=r&&t(e),r=a})),e.addEventListener("change",(function(e){n||t(e)}))}function rad2Deg(e){return e*(180/Math.PI)}function deg2Rad(e){return e*(Math.PI/180)}function rand01(){return Math.random()}function randSign(){return Math.random()<.5?-1:1}function randomFromArray(e){return e[Math.floor(Math.random()*e.length)]}function getChild(e,t){return e.getElementById(t)}function insertAt(e,t,n){e.splice(t,0,n)}function removeAt(e,t){return e.splice(t,1),e}function removeOne(e,t){var n=e.indexOf(t);return n>-1&&e.splice(n,1),e}function removeAll(e,t){for(var n=0;n<e.length;)e[n]===t?e.splice(n,1):++n;return e}function removeAllChildren(e){for(;e.firstChild;)e.removeChild(e.firstChild)}function removeFromParent(e){e.parentElement&&e.parentElement.removeChild(e)}function disableDiv(e){e.style.opacity=.5,e.style.pointerEvents="none"}function enableDiv(e){e.style.opacity=1,e.style.pointerEvents="auto"}function replaceHtml(e,t){e.innerHTML=t,runAllScriptsIn(e)}function insertHtml(e,t){let n=e.children.length;e.insertAdjacentHTML("beforeend",t);for(var a=n;a<e.children.length;a++)runAllScriptsIn(e.children[a]);return e.children[n]}function runAllScriptsIn(div){"text/javascript"==div.type&&eval(div.innerHTML);var scripts=Array.from(div.getElementsByTagName("script"));for(let _arr=null!=scripts?scripts:[],_idx=0,child;child=_arr[_idx],_idx<_arr.length;_idx++)null!=child.type&&"text/javascript"!=child.type||eval(child.innerHTML)}function prettyDate(e){return new Date(e).toLocaleDateString("en-US")}function lerp(e,t,n){return e*(1-n)+t*n}function clamp(e,t,n){return e<=t?t:e>=n?n:e}function clamp01(e){return e<=0?0:e>=1?1:e}function parseVec(e){if(null==e)return{x:0,y:0};var t=e.split(",");return{x:parseFloat(t[0]),y:parseFloat(t[1])}}function distanceSq(e,t){return(t.x-e.x)*(t.x-e.x)+(t.y-e.y)*(t.y-e.y)}function allElementsFromPoint(e,t){for(var n,a=[],r=[];(n=document.elementFromPoint(e,t))&&n!==document.documentElement;)a.push(n),r.push(n.style.visibility),n.style.visibility="hidden";for(var i=0;i<a.length;i++)a[i].style.visibility=r[i];return a.reverse(),a}function textFieldOnReturn(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function textFieldOnChange(e,t){e.addEventListener("keyup",(function(n){clearTimeout(e.searchTimeout),13===n.keyCode?(n.preventDefault(),t()):e.searchTimeout=setTimeout((function(){t()}),650)}))}function textFieldOnEnter(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function UUID(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function UNIQUEID(){return"bxxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function stripHtml(e){print(e);let t=(new DOMParser).parseFromString(e,"text/html");return print(t.body.textContent),t.body.textContent||""}function unstripHtml(e){return e.replace("&lt;","<")}function clone(e){return JSON.parse(JSON.stringify(e))}function isSmallScreen(){return window.innerWidth<window.innerHeight||window.innerWidth<900}function sendIfModified(e,t,n,a){var r=new XMLHttpRequest;r.onreadystatechange=function(){4==this.readyState&&(503==this.status?window.location.href="./":(200!=this.status&&(null!=this.responseText&&this.responseText.length>0||this.statusText),null!=a&&a(this)))},r.open("POST","./");let i=sessionStorage.getItem("Session-Id");null!=i&&r.setRequestHeader("Session-Id",i),r.setRequestHeader("Flynn-Tag","hotload"),r.setRequestHeader("Pragma","no-cache"),r.setRequestHeader("Expires","-1"),r.setRequestHeader("Cache-Control","no-cache"),null!=t&&r.setRequestHeader("If-Modified-Since",t),e instanceof FormData?r.send(e):(r.setRequestHeader("Content-Type","application/json;charset=UTF-8"),r.send(JSON.stringify(e)))}function send(e,t){return sendIfModified(e,void 0,!1,t)}function endSession(e){send({endUserSession:!0},(function(){e()}))}let globalTimers=[];function initTimers(){setInterval(callTimers,250)}function callTimers(){for(let e,t=null!=globalTimers?globalTimers:[],n=0;e=t[n],n<t.length;n++)e.counter-=250,e.counter<=0&&(e.counter=e.delay,e.callback())}function addTimer(e,t){globalTimers.push({callback:t,delay:e,counter:e})}function clearTimer(e){for(let t,n=null!=globalTimers?globalTimers:[],a=0;t=n[a],a<n.length;a++)t.callback==e&&removeOne(globalTimers,t)}function clearAllTimer(){globalTimers=[]}function InitFigurehead(){initTimers(),function e(){Laba.update(),window.requestAnimationFrame(e)}()}let endeavour={send:function(e,t){send(e,(function(e){let n=e.getResponseHeader("Service-Response");if(null!=n){let a=JSON.parse(n);t(e,a)}else t(e,void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,t){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},t)},leave:function(e,t){endeavour.send({service:"EndeavourService",command:"leave",documentUUID:e},t)},save:function(e,t){endeavour.send({service:"EndeavourService",command:"save",documentUUID:e},t)}};

"""###
private let compressedScriptCombinedJs = Data(base64Encoded:"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")!

public extension EndeavourPamphlet.Private {
    static func ShellFontsHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/shell.fonts.html"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/usr/local/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /usr/local/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    #else
        return uncompressedShellFontsHtml
    #endif
    }
    static func ShellFontsHtmlGzip() -> Data {
        return compressedShellFontsHtml
    }
}

private let uncompressedShellFontsHtml = ###"""
<link rel="preload" href="public/fonts/lato.woff2" as="font" type="font/woff2" crossorigin> <link rel="preload" href="public/fonts/roboto.woff2" as="font" type="font/woff2" crossorigin> <style>
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 400;
        font-display: swap;
        src: url(public/fonts/lato.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
    @font-face {
        font-family: 'Roboto';
        font-style: normal;
        font-weight: 500;
        font-display: swap;
        src: url(public/fonts/roboto.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style>
"""###
private let compressedShellFontsHtml = Data(base64Encoded:"H4sIAAAAAAACA91SXU/DIBR991eQvnSL1lK2zli7xX3Ik08m/gDW0o7IoAGaZjH+dyk0mVtissw378M9PffA6eVCzpn4AIryedDYLEkZgJ2ilaXtlrMirqQwOubEyPtOVhUKANHzoK8GwBwa6r/jQSuU1FoqVjOxAPll3kpu5TXu2hw4XdwAG8/9qqgiBQWfrtDHUNszfshA+GpPED6dis4hA0KqPeFnWkdZvTMZmEJ4ppRMN5xYT92R5qhpVWSgVXz0y+DGdrf9jxmFjobj49ZWsEKWNFJE1Laf91toI4IQ47ueJJPEY4oimyaOoNUqsmntyXrmcbMc0NVRb4PgDHvyMPW49GKCkMfHZEDnjKwwYNojfvFtYIw3vuWvS2f+5m72mqmnf5v6zyf1n+aex/7RfwO/HPn2tgMAAA==")!

public extension EndeavourPamphlet.Private {
    static func ShellHtml() -> String {
    #if DEBUG
        let fileOnDiskPath = "/Volumes/Development/Development/chimerasw3/Endeavour/Resources/private/shell.html"
        if let contents = try? String(contentsOf:URL(fileURLWithPath: fileOnDiskPath)) {
            if contents.hasPrefix("#define PAMPHLET_PREPROCESSOR") {
                do {
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/usr/local/bin/pamphlet")
                    task.arguments = ["preprocess", fileOnDiskPath]
                    let outputPipe = Pipe()
                    task.standardOutput = outputPipe
                    try task.run()
                    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                    let output = String(decoding: outputData, as: UTF8.self)
                    return output
                } catch {
                    return "Failed to use /usr/local/bin/pamphlet to preprocess the requested file"
                }
            }
            return contents
        }
        return String()
    #else
        return uncompressedShellHtml
    #endif
    }
    static func ShellHtmlGzip() -> Data {
        return compressedShellHtml
    }
}

private let uncompressedShellHtml = ###"""
<!doctype html> <html> <head> <meta charset="utf-8"> <meta name="apple-mobile-web-app-capable" content="yes"> <meta name="viewport" content="user-scalable=no,width=device-width,initial-scale=1.0,viewport-fit=cover"> <meta name="color-scheme" content="dark light"> <title>PicaroonTemplate</title> <link rel="manifest" href="/public/manifest.json"> <link rel="apple-touch-icon" sizes="192x192" href="/public/icon192.png"> <link rel="apple-touch-icon" sizes="512x512" href="/public/icon512.png"> <link rel="preload" href="public/fonts/lato.woff2" as="font" type="font/woff2" crossorigin> <link rel="preload" href="public/fonts/roboto.woff2" as="font" type="font/woff2" crossorigin> <style>
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 400;
        font-display: swap;
        src: url(public/fonts/lato.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
    @font-face {
        font-family: 'Roboto';
        font-style: normal;
        font-weight: 500;
        font-display: swap;
        src: url(public/fonts/roboto.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style> <link rel="preload" href="public/endeavour/robotomono_400.woff" as="font" type="font/woff2" crossorigin> <style>
    @font-face {
      font-family: 'Roboto Mono';
      font-style: normal;
      font-weight: 400;
      font-display: swap;
      src: url(public/endeavour/robotomono_400.woff) format('woff');
      unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    },
    @font-face {
      font-family: 'Roboto Mono';
      font-style: bold;
      font-weight: 500;
      font-display: swap;
      src: url(public/endeavour/robotomono_500.woff) format('woff');
      unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style> <style>
    :root {
        --fh-link: rgba(55, 64, 255);
                
        --fh-fclear: rgba(255,255,255,0);
        --fh-fwhite: rgba(255,255,255,1);
        --fh-fdarkgrey: rgba(100,100,100,1);
        --fh-fgrey: rgba(200,200,200,1);
        --fh-flightgrey: rgba(242,242,242,1);
        --fh-fblack: rgba(83,84,87,1);
        --fh-fred: rgba(255, 0, 0, 1);
        --fh-fgreen: rgba(0, 255, 0, 1);
        --fh-fblue: rgba(0, 0, 255, 1);
        --fh-fcyan: rgba(0, 255, 255, 1);
        --fh-fyellow: rgba(255, 255, 0, 1);
        
        --fh-clear: rgba(255,255,255,0);
        --fh-white: rgba(255,255,255,1);
        --fh-darkgrey: rgba(100,100,100,1);
        --fh-grey: rgba(200,200,200,1);
        --fh-lightgrey: rgba(242,242,242,1);
        --fh-black: rgba(83,84,87,1);
        --fh-red: rgba(255, 0, 0, 1);
        --fh-green: rgba(0, 255, 0, 1);
        --fh-blue: rgba(0, 0, 255, 1);
        --fh-cyan: rgba(0, 255, 255, 1);
        --fh-yellow: rgba(255, 255, 0, 1);
        
        --fh-dclear: rgba(255,255,255,0.4);
        --fh-dwhite: rgba(255,255,255,0.4);
        --fh-ddarkgrey: rgba(100,100,100,0.4);
        --fh-dgrey: rgba(200,200,200,0.4);
        --fh-dlightgrey: rgba(242,242,242,0.4);
        --fh-dblack: rgba(83,84,87,0.4);
        --fh-dred: rgba(255, 0, 0, 0.4);
        --fh-dgreen: rgba(0, 255, 0, 0.4);
        --fh-dblue: rgba(0, 0, 255, 0.4);
        --fh-dcyan: rgba(0, 255, 255, 0.4);
        --fh-dyellow: rgba(255, 255, 0, 0.4);
        
        --fh-error-red: rgba(208,116,112,1);
        
        --fh-main-background: rgba(251,253,254,1);
        
        --fh-std-shadow: rgba(0,0,0,0.1);
        
        --fh-btn-background: rgba(66,147,247,1);
        --fh-btn-highlight: rgba(48,107,179,1);
        
        --fh-item-outline: rgba(200,200,200,1);
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --fh-link: rgba(157, 162, 255);
            
            --fh-fclear: rgba(0,0,0,0);
            --fh-fwhite: rgba(65,65,65,1);
            --fh-fdarkgrey: rgba(155,155,155,1);
            --fh-fgrey: rgba(55,55,55,1);
            --fh-flightgrey: rgba(32,32,32,1);
            --fh-fblack: rgba(172,171,168,1);
            --fh-fred: rgba(255, 0, 0, 1);
            --fh-fgreen: rgba(0, 255, 0, 1);
            --fh-fblue: rgba(0, 0, 255, 1);
            --fh-fcyan: rgba(0, 255, 255, 1);
            --fh-fyellow: rgba(255, 255, 0, 1);
        
            --fh-clear: rgba(0,0,0,0);
            --fh-white: rgba(55,55,55,1);
            --fh-darkgrey: rgba(155,155,155,1);
            --fh-grey: rgba(55,55,55,1);
            --fh-lightgrey: rgba(32,32,32,1);
            --fh-black: rgba(172,171,168,1);
            --fh-red: rgba(255, 0, 0, 1);
            --fh-green: rgba(0, 255, 0, 1);
            --fh-blue: rgba(0, 0, 255, 1);
            --fh-cyan: rgba(0, 255, 255, 1);
            --fh-yellow: rgba(255, 255, 0, 1);
        
            --fh-dclear: rgba(0,0,0,0);
            --fh-dwhite: rgba(0,0,0,1);
            --fh-ddarkgrey: rgba(155,155,155,1);
            --fh-dgrey: rgba(55,55,55,1);
            --fh-dlightgrey: rgba(32,32,32,1);
            --fh-dblack: rgba(172,171,168,1);
            --fh-dred: rgba(255, 0, 0, 0.4);
            --fh-dgreen: rgba(0, 255, 0, 0.4);
            --fh-dblue: rgba(0, 0, 255, 0.4);
            --fh-dcyan: rgba(0, 255, 255, 0.4);
            --fh-dyellow: rgba(255, 255, 0, 0.4);
        
            --fh-error-red: rgba(208,116,112,1);
            
            --fh-main-background: rgba(4,2,1,1);
            
            --fh-std-shadow: rgba(70,98,136,0.3);
            
            --fh-btn-background: rgba(66,147,247,1);
            --fh-btn-highlight: rgba(48,107,179,1);
            
            --fh-item-outline: rgba(85,85,85,1);
        }
    }

    @media (prefers-color-scheme: light) { }
    
</style> <script>
        // Required by Picaroon to hook up server-side actor with user to maintain state across connections
        if (sessionStorage.getItem("Session-Id") == undefined) {
            let sessionUUID = document.cookie.match(/SESSION_UUID=([A-Z0-9\-]*);?/);
            if (sessionUUID != undefined && sessionUUID.length > 1) {
                sessionStorage.setItem("Session-Id", sessionUUID[1]);
            }
        }
    </script> <script src="script.combined.js"></script> <style>
        h1 {
            font-size:2rem;font-family:'Roboto';
        }
        h2 {
            font-size:1.5rem;font-family:'Roboto';
        }
        h3 {
            font-size:1rem;font-family:'Roboto';
        }
        body {
            background:var(--fh-main-background);;
            overflow-y:scroll;overflow-x:hidden;;
            -webkit-text-size-adjust: none;
        }
        *:focus {
            outline: none;
        }
    </style> </head> <body> <noscript> <div style="position:fixed;display:flex;justify-content:center;align-items:center;width:100%;height:100%;padding:0px;margin:0px;overflow:hidden;"> <h1>This app requires Javascript to be enabled.</h1> </div> </noscript> <div style="display:flex;flex-direction:column;min-height:100%;flex: 1 1 auto;align-items:stretch;"><a href="https://github.com/KittyMac/Endeavour" class="github-corner" aria-label="View source on GitHub"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#535457; color:white; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style> <div style="display:flex;flex-direction:row;min-height:5rem;width:100%;margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;"><div style="display:flex;flex-direction:column;flex: 1 1 auto;min-height:5rem;"><div style="display:flex;font-size:2.2rem;font-family:'Roboto';color:var(--fh-fblack);">Endeavour</div> <div style="display:flex;font-size:1.0rem;font-family:'Lato';color:var(--fh-fblack);">Collaborative Swift editor using CodeMirror6</div></div></div> <div style="display:flex;flex-direction:row;justify-content:flex-end;margin-top:0rem;margin-left:0.5rem;margin-bottom:0rem;margin-right:0.5rem;flex: 1 1 auto;align-self:stretch;"><div id="newDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="sharedDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="newDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Shared Document</div></div> <div style="display:flex;flex: 1 1 auto;align-self:stretch;"></div> <div id="newDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="newDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="newDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">New Document</div></div> <div id="joinDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="askJoinDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="joinDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Join Document</div></div></div> <div id="documents" style="display:flex;flex-direction:column;width:100%;"></div></div> <div id="alertsContainer" style="display:flex;left:0px;top:0px;margin:0px;padding:0px;width:100%;height:100%;position:fixed;position:absolute;background:rgba(0,0,0,0.5);justify-content:center;align-items:center;overflow:hidden;display:none;"></div> <script src="public/endeavour/editor.bundle.js"></script> <script>
        InitFigurehead();
        
        function handleCreateDocument(xhttp, serviceJson) {
            let documentUUID = serviceJson.documentUUID;
            let documentID = `document${documentUUID}`
            let editorID = `editor${documentUUID}`
            let headerID = `header${documentUUID}`
            let saveID = `save${documentUUID}`
                            
            let html = `<div id="document${documentUUID}" style="display:flex;flex-direction:column;max-height:50rem;box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;border:0.15rem solid var(--fh-item-outline);overflow:hidden;border-radius:0.75rem;background:var(--fh-white);"><div style="display:flex;flex-direction:row;align-items:center;padding-top:0.5rem;padding-left:1rem;padding-bottom:0.5rem;padding-right:1rem;margin-top:0rem;margin-left:0rem;margin-bottom:0rem;margin-right:-0.125rem;"><div id="header${documentUUID}" style="display:flex;font-size:1rem;font-family:'Lato';color:var(--fh-fblack);justify-content:flex-start;align-items:flex-end;">Creating new document...</div> <div style="display:flex;flex: 1 1 auto;align-self:stretch;"></div> <div id="save${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="saveDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="save${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Save</div></div> <div id="leave${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="leaveDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="leave${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Leave</div></div></div> <div style="display:flex;flex-direction:column;flex: 1 1 auto;align-items:stretch;min-height:10rem;background:rgba(255,255,255,1);"><div id="editor${documentUUID}" style="display:flex;border-top:0.1rem solid var(--fh-item-outline);flex: 1 1 auto;width:100%;overflow:hidden;"></div></div></div>`
            insertHtml(documents, html);
            
            let documentHeader = document.getElementById(headerID);
            documentHeader.innerText = `Document ${documentUUID}`;
            
            let documentSave = document.getElementById(saveID);
            disableDiv(documentSave);
            
            let documentStatus = function(status) {
                let ignoreErrors = [
                    //"Version mismatch"
                ];
                                
                let displayText = `Document ${status.documentUUID}`;
                let isError = false;
                                
                let errorText = status.error;
                if (errorText != undefined) {
                    for (let _arr = (ignoreErrors != undefined ? ignoreErrors : []), _idx = 0, ignoreError = undefined; ignoreError = _arr[_idx], _idx < _arr.length; _idx++) {
                        if (errorText.includes(ignoreError)) {
                            errorText = undefined;
                        }
                    }
                }
                
                if (errorText != undefined) {
                    displayText = errorText;
                    isError = true;
                }
                
                if (displayText != undefined && documentHeader.innerText != displayText) {
                    print(displayText);
                    documentHeader.innerText = displayText;
                    
                    if (isError) {
                        documentHeader.style.color = `rgba(214,62,87,1)`;
                    } else {
                        documentHeader.style.color = `rgba(83,84,87,1)`;
                    }
                }
                
                // If the version of the document is 0 then there have been
                // no changes and the save button should be disabled
                if (status.version == 0) {
                    disableDiv(documentSave);
                } else {
                    enableDiv(documentSave);
                }
            }

            let editor = cm.CreateEditor(editorID, [
                cm.swiftSetup,
                cm.endeavourExtension(serviceJson, documentStatus)
            ], xhttp.responseText, true);
            
            let myDocument = document.getElementById(documentID);
            Laba.animate(myDocument, "!<200!f")
        }
        
        function askJoinDocument() {
            ask("Enter the document UUID to join",
                "",
                ["Cancel", "Join"],
                [undefined, joinDocument]);
        }
        
        function leaveDocument(documentUUID) {
            endeavour.leave(documentUUID, function(xhttp, serviceJson) {
                let documentID = `document${documentUUID}`
                let myDocument = document.getElementById(documentID);
                let fromHeight = myDocument.clientHeight;
                Laba.animate(myDocument, "^50f0", function(item,t) {
                    item.style.height = lerp(fromHeight,0,t) + "px";
                }, function() {
                    removeFromParent(myDocument);
                });
            });
        }
        
        function saveDocument(documentUUID) {
            endeavour.save(documentUUID, function(xhttp, serviceJson) {
                print(xhttp)
                print(serviceJson)
                //let documentID = `document${documentUUID}`
                //let myDocument = document.getElementById(documentID);
                //let fromHeight = myDocument.clientHeight;
                //Laba.animate(myDocument, "^50f0", function(item,t) {
                //    item.style.height = lerp(fromHeight,0,t) + "px";
                //}, function() {
                //    removeFromParent(myDocument);
                //});
            });
        }
        
        function sharedDocument() {
            endeavour.join("SwiftSample", handleCreateDocument);
        }
        
        function newDocument() {
            endeavour.new(handleCreateDocument);
        }
        
        function joinDocument(documentUUID) {
            endeavour.join(documentUUID, handleCreateDocument);
        }

    </script> </body> </html>
"""###
private let compressedShellHtml = Data(base64Encoded:"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")!

