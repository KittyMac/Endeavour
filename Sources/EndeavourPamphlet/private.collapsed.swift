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
function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}var alertsQueue=[];function handleAlertsQueue(){let e=function(e,t){e.style.height=t*e.actualHeight+"px",e.style.minHeight=e.style.height};var t=function(){1==alertsContainer.isOpen&&(alertsContainer.isOpen=!1,Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f0",void 0,(function(){alertsContainer.style.display="none"})))},n=function(n){var a=document.getElementById(n);null!=a&&""!==a&&"undefined"!==a&&(0==alertsQueue.length&&t(),Laba.animate(a,"!f0",(function(t,n){e(t,1-n)}),(function(){removeFromParent(a),handleAlertsQueue()})))};0!=alertsQueue.length?(0==alertsContainer.isOpen&&(alertsContainer.isOpen=!0,alertsContainer.style.display="flex",Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f1",void 0,(function(){}))),0==alertsContainer.children.length&&function(t){for(var a=t.value,r=t.ask,i=t.message,o=t.buttons,l=t.callbacks,s=UNIQUEID(),u="",m=!0,c=o.length-1;c>=0;c-=1){var f=o[c];m?(m=!1,u+=`<div id="${s}Btn${c}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;background:var(--fh-btn-background);" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="${s}Btn${c}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${f}</div></div>`):u+=`<div id="${s}Btn${c}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;color:var(--fh-btn-background);" onmousedown="this.style.color='var(--fh-btn-highlight)'" onmouseout="this.style.color='var(--fh-btn-background)'" onmouseup="this.style.color='var(--fh-btn-background)'"><div id="${s}Btn${c}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${f}</div></div>`}insertHtml(alertsContainer,r?`<div id="${s}" class="Alert" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;color:var(--fh-fblack);font-size:1rem;font-family:'Lato';margin-top:2rem;margin-left:0.5rem;margin-bottom:0rem;margin-right:0.5rem;">${i}</div> <input id="${s}Value" style="display:flex;flex: 1 1 auto;align-self:stretch;min-width:0rem;height:2rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;border:0.1rem solid var(--fh-fgrey);border-radius:1rem;font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:0.5rem;margin-bottom:2rem;margin-right:0.5rem;" type="text" placeholder="..." /> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${u}</div></div>`:`<div id="${s}" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;margin-top:0rem;margin-left:0rem;margin-bottom:0.5rem;margin-right:0rem;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:1rem;margin-bottom:1rem;margin-right:1rem;color:var(--fh-fblack);">${i}</div></div> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${u}</div></div>`);var h=document.getElementById(s+"Value");for(null!=h&&""!==h&&"undefined"!==h&&(h.callback=l[l.length-1],textFieldOnEnter(h,(function(){let e;null!=h&&""!==h&&"undefined"!==h&&(e=h.value),null!=h.callback&&""!==h.callback&&"undefined"!==h.callback&&h.callback(e),n(s)})),h.value=a,h.focus()),c=l.length-1;c>=0;c-=1){var d=document.getElementById(s+"Btn"+c);d.callback=l[c],d.addEventListener("mouseup",(function(e){let t;null!=h&&""!==h&&"undefined"!==h&&(t=h.value),null!=e.currentTarget.callback&&""!==e.currentTarget.callback&&"undefined"!==e.currentTarget.callback&&e.currentTarget.callback(t),n(s)}))}requestAnimationFrame((function(){var t=document.getElementById(s);t.actualHeight=t.offsetHeight,Laba.animate(t,"!f1",(function(t,n){e(t,n)}),(function(e){e.style.height=""}))}))}(alertsQueue.shift())):t()}function alert(e,t,n){null!=e&&""!==e&&(null!=alertsContainer.isOpen&&""!==alertsContainer.isOpen||(alertsContainer.isOpen=!1),null!=t&&""!==t||(t=["Ok"]),null!=n&&""!==n||(n=[void 0]),e=e.replaceAll("\n","<br>"),alertsQueue.push({message:e,buttons:t,callbacks:n}),handleAlertsQueue())}function ask(e,t,n,a){null!=e&&""!==e&&(null!=alertsContainer.isOpen&&""!==alertsContainer.isOpen||(alertsContainer.isOpen=!1),null!=n&&""!==n||(n=["Ok"]),null!=a&&""!==a||(a=[void 0]),e=e.replaceAll("\n","<br>"),alertsQueue.push({value:t,ask:!0,message:e,buttons:n,callbacks:a}),handleAlertsQueue())}function initButton(e,t,n){if(null!=e.length)for(let t,a=null!=e?e:[],r=0;t=a[r],r<a.length;r++)t.addEventListener("mouseup",(function(e){null!=n&&n(this)}));else e.addEventListener("mouseup",(function(e){null!=n&&n(this)}))}function StringBuilder(){var e=[];this.length=function(){for(var t=0,n=0;n<e.length;n++)t+=e[n].length;return t},this.setLength=function(t){let n=e.join("").substring(0,t);(e=[])[0]=n},this.insert=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=n,e[2]=a.substring(t)},this.delete=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=a.substring(n+1)},this.append=function(n){(n=t(n)).length>0&&(e[e.length]=n)},this.appendLine=function(n){if(n=t(n),this.isEmpty()){if(!(n.length>0))return;e[e.length]=n}else e[e.length]=n.length>0?"\r\n"+n:"\r\n"},this.clear=function(){e=[]},this.isEmpty=function(){return 0==e.length},this.toString=function(){return e.join("")};var t=function(e){return n(e)?a(e)!=a(new String)?String(e):e:""},n=function(e){return null!=e&&void 0!==e},a=function(e){if(!n(e.constructor))throw Error("Unexpected object type");var t=String(e.constructor).match(/function\s+(\w+)/);return n(t)?t[1]:"undefined"}}function easeLinear(e){return 0+1*e}function easeInQuad(e){return 0,1*e*e+0}function easeOutQuad(e){return 0,-1*e*(e-2)+0}function easeInOutQuad(e){return 0,(e/=.5)<1?.5*e*e+0:-.5*(--e*(e-2)-1)+0}function easeInCubic(e){return 0,1*e*e*e+0}function easeOutCubic(e){return 0,1*(--e*e*e+1)+0}function easeInOutCubic(e){return 0,(e/=.5)<1?.5*e*e*e+0:.5*((e-=2)*e*e+2)+0}function easeInQuart(e){return 0,1*e*e*e*e+0}function easeOutQuart(e){return 0,-1*(--e*e*e*e-1)+0}function easeInOutQuart(e){return 0,(e/=.5)<1?.5*e*e*e*e+0:-.5*((e-=2)*e*e*e-2)+0}function easeInQuint(e){return 0,1*e*e*e*e*e+0}function easeOutQuint(e){return 0,1*(--e*e*e*e*e+1)+0}function easeInOutQuint(e){return 0,(e/=.5)<1?.5*e*e*e*e*e+0:.5*((e-=2)*e*e*e*e+2)+0}function easeInSine(e){return 0,-1*Math.cos(e/1*(Math.PI/2))+1+0}function easeOutSine(e){return 0,1*Math.sin(e/1*(Math.PI/2))+0}function easeInOutSine(e){return 0,-.5*(Math.cos(Math.PI*e/1)-1)+0}function easeInExpo(e){return 0,1*Math.pow(2,10*(e/1-1))+0}function easeOutExpo(e){return 0,1*(1-Math.pow(2,-10*e/1))+0}function easeInOutExpo(e){return 0,(e/=.5)<1?.5*Math.pow(2,10*(e-1))+0:(e--,.5*(2-Math.pow(2,-10*e))+0)}function easeInCirc(e){return 0,-1*(Math.sqrt(1-e*e)-1)+0}function easeOutCirc(e){return e--,0,1*Math.sqrt(1-e*e)+0}function easeInOutCirc(e){return 0,(e/=.5)<1?-.5*(Math.sqrt(1-e*e)-1)+0:(e-=2,.5*(Math.sqrt(1-e*e)+1)+0)}function easeOutBounce(e){return e<4/11?121*e*e/16:e<8/11?9.075*e*e-9.9*e+3.4:e<.9?4356/361*e*e-35442/1805*e+16061/1805:10.8*e*e-20.52*e+10.72}function easeInBounce(e){return 1-easeOutBounce(1-e)}function easeInOutBounce(e){return e<.5?.5*easeInBounce(2*e):.5*easeOutBounce(2*e-1)+.5}function easeShake(e){return(Math.sin(3.14*e*6+.785)-.5)*(1-e)}String.prototype.format=function(){for(k in a=this,arguments)a=a.replace("{"+k+"}",arguments[k]);return a},Math.radians=function(e){return e*Math.PI/180},Math.degrees=function(e){return 180*e/Math.PI};var _allLabalTimers=[];class _LabaTimer{update(){var e=(performance.now()-this.startTime)/(this.endTime-this.startTime);if(this.endTime==this.startTime&&(e=1),e>=1&&(e=1),null!=this.onUpdate){var t=this.action.easing;null==t&&(t=easeInOutQuad),this.onUpdate(this.view,t(e))}if(e>=1)return this.action(e,!1),-1==this.loopCount?(this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):this.loopCount>1?(this.loopCount--,this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):(removeOne(_allLabalTimers,this),null!=this.onComplete&&this.onComplete(this.view),void this.view.labaCommitElemVars());this.action(e,!1),this.view.labaCommitElemVars()}constructor(e,t,n,a,r,i,o,l){this.view=e,this.loopCount=l,this.action=t,this.duration=r,this.onComplete=o,this.onUpdate=i,this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,this.action(0,!0),_allLabalTimers.push(this),this.update(0)}}class _LabaAction{constructor(e,t,n,a,r,i,o){this.operatorChar=t,this.elem=n,this.inverse=a,this.rawValue=r,this.easing=i,this.easingName=o,this.action=e.PerformActions[t],this._describe=e.DescribeActions[t],this._init=e.InitActions[t],0==this.inverse?(this.fromValue=0,this.toValue=1):(this.fromValue=1,this.toValue=0),null!=this._init&&this._init(this)}reset(e){if(null!=this._init){var t=new _LabaAction(e,this.operatorChar,this.elem,this.inverse,this.rawValue,this.easing,this.easingName);return this.fromValue=t.fromValue,this.toValue=t.toValue,!0}return!1}perform(e){return null!=this.action&&(this.action(this.elem,this.fromValue+(this.toValue-this.fromValue)*this.easing(e),this),!0)}describe(e){return null!=this._describe&&(this._describe(e,this),!0)}}class _Laba{isOperator(e){return","==e||"|"==e||"!"==e||"e"==e||e in this.InitActions}isNumber(e){return"+"==e||"-"==e||"0"==e||"1"==e||"2"==e||"3"==e||"4"==e||"5"==e||"6"==e||"7"==e||"8"==e||"9"==e||"."==e}update(){for(var e in _allLabalTimers)_allLabalTimers[e].update()}parseAnimationString(e,t){for(var n=0,a=0,r=0,i=this.allEasings[3],o=this.allEasingsByName[3],l=[],s=0;s<this.kMaxPipes;s++){l[s]=[];for(var u=0;u<this.kMaxActions;u++)l[s][u]=void 0}for(;n<t.length;){for(var m=!1,c=" ";n<t.length;){var f=t[n];if(this.isOperator(f))if("!"==f)m=!0;else if("|"==f)a++,r=0;else{if(","!=f){c=f,n++;break}0!=r&&(a++,r=0),l[a][r]=new _LabaAction(this,"d",e,!1,.26*this.kDefaultDuration,i,o),a++,r=0}n++}for(;n<t.length&&!this.isNumber(t[n])&&!this.isOperator(t[n]);)n++;var h=this.LabaDefaultValue;if(n<t.length&&this.isNumber(t[n])){var d=!1;"+"==t[n]?n++:"-"==t[n]&&(d=!0,n++),h=0;for(var p=!1,g=10;n<t.length;){f=t[n];if(this.isNumber(f)&&(f>="0"&&f<="9"&&(p?(h+=(f-"0")/g,g*=10):h=10*h+(f-"0")),"."==f&&(p=!0)),this.isOperator(f))break;n++}d&&(h*=-1)}if(" "!=c)if(c in this.InitActions)l[a][r]=new _LabaAction(this,c,e,m,h,i,o),r++;else if("e"==c){var b=h;b>=0&&n<this.allEasings.length&&(i=this.allEasings[b],o=this.allEasingsByName[b])}}return l}animateOne(e,t,n,a){for(var r=this,i=this.parseAnimationString(e,t),o=this.PerformActions.d,l=this.PerformActions.D,s=this.PerformActions.L,u=this.PerformActions.l,m=0,c=0,f=1,h=!1,d=0;d<this.kMaxPipes;d++)if(null!=i[d][0]){m++;for(var p=this.kDefaultDuration,g=0;g<this.kMaxActions;g++)null!=i[d][g]&&(i[d][g].action!=o&&i[d][g].action!=l||(p=i[d][g].fromValue),i[d][g].action==s&&(f=i[d][g].fromValue),i[d][g].action==u&&(h=!0,f=i[d][g].fromValue));c+=p}if(1==m)if(h)new _LabaTimer(e,(function(e,t){if(1==t)for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].reset(r));n++);for(var a=0;a<r.kMaxActions&&(null==i[0][a]||i[0][a].perform(e));a++);}),0,1,c,n,a,f);else{for(g=0;g<r.kMaxActions&&(null==i[0][g]||i[0][g].reset(r));g++);new _LabaTimer(e,(function(e,t){for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].perform(e));n++);}),0,1,c*r.kTimeScale,n,a,f)}else{for(var b=void 0,v=m-1;v>=0;v--){p=this.kDefaultDuration;var w=1,x=!1;for(g=0;g<this.kMaxActions;g++)null!=i[v][g]&&(i[v][g].action!=o&&i[v][g].action!=l||(p=i[v][g].fromValue),i[v][g].action==s&&(w=i[v][g].fromValue),i[v][g].action==u&&(x=!0,w=i[v][g].fromValue));let t=v;var V=b;null==V&&(V=a),null==V&&(V=function(){});let m=x,c=p,f=w,h=V;b=function(){if(m)new _LabaTimer(e,(function(e,n){if(1==n)for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);for(a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c,n,h,f);else{for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);new _LabaTimer(e,(function(e,n){for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c*r.kTimeScale,n,h,f)}}}null!=b?b():null!=a&&a(this.view)}}reset(e){if(null==e.labaTransformX){var t=e;t.labaResetElemVars=function(){t.labaTransformX=0,t.labaTransformY=0,t.labaTransformZ=0,t.labaRotationX=0,t.labaRotationY=0,t.labaRotationZ=0,t.labaScale=1,null!=t.style&&(t.labaAlpha=parseFloat(t.style.opacity)),isNaN(t.labaAlpha)&&(t.labaAlpha=1)},t.labaCommitElemVars=function(){if(null!=t.position&&(t.position.set(t.labaTransformX,t.labaTransformY),t.scale.set(t.labaScale,t.labaScale),t.rotation=t.labaRotationZ,t.alpha=t.labaAlpha),null!=t.style){var e=Matrix.identity();e=Matrix.multiply(e,Matrix.translate(t.labaTransformX,t.labaTransformY,t.labaTransformZ)),e=Matrix.multiply(e,Matrix.rotateX(Math.radians(t.labaRotationX))),e=Matrix.multiply(e,Matrix.rotateY(Math.radians(t.labaRotationY))),e=Matrix.multiply(e,Matrix.rotateZ(Math.radians(t.labaRotationZ))),e=Matrix.multiply(e,Matrix.scale(t.labaScale,t.labaScale,t.labaScale));let n="perspective(500px) matrix3d({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15})".format(e.m00,e.m10,e.m20,e.m30,e.m01,e.m11,e.m21,e.m31,e.m02,e.m12,e.m22,e.m32,e.m03,e.m13,e.m23,e.m33);t.style.webkitTransform=n,t.style.MozTransform=n,t.style.msTransform=n,t.style.OTransform=n,t.style.transform=n,t.style.opacity=t.labaAlpha}}}e.labaResetElemVars(),null==e.style&&null!=e.position&&(e.labaTransformX=e.position.x,e.labaTransformY=e.position.y,e.labaRotationZ=e.rotation,e.labaScale=e.scale.x,e.labaAlpha=e.alpha)}set(e,t,n,a,r,i,o,l,s){this.reset(e),e.labaTransformX=t,e.labaTransformY=n,e.labaTransformZ=a,e.labaRotationX=r,e.labaRotationY=i,e.labaRotationZ=o,e.labaScale=l,e.labaAlpha=s,e.labaCommitElemVars()}animate(e,t,n,a){if(null==e.labaTransformX&&this.reset(e),t.includes("["))for(var r=t.replace("["," ").split("]"),i=0;i<r.length;i++){var o=r[i];o.length>0&&(this.animateOne(e,o,n,a),a=void 0)}else this.animateOne(e,t,n,a),a=void 0}cancel(e){for(var t in _allLabalTimers)_allLabalTimers[t].view==e&&removeOne(_allLabalTimers,_allLabalTimers[t])}describeOne(e,t,n){for(var a=this.parseAnimationString(e,t),r=this.PerformActions.d,i=this.PerformActions.D,o=this.PerformActions.L,l=this.PerformActions.l,s=0,u=0,m=1,c="absolute",f=0;f<this.kMaxPipes;f++)if(null!=a[f][0]){s++;for(var h=this.kDefaultDuration,d=0;d<this.kMaxActions;d++)null!=a[f][d]&&(a[f][d].action!=r&&a[f][d].action!=i||(h=a[f][d].fromValue),a[f][d].action==o&&(m=a[f][d].fromValue),a[f][d].action==l&&(m=a[f][d].fromValue,c="relative"));u+=h}if(1==s){var p=n.length();for(f=0;f<this.kMaxActions&&(null==a[0][f]||a[0][f].describe(n));f++);m>1?n.append(" {0} repeating {1} times, ".format(c,m)):-1==m&&n.append(" {0} repeating forever, ".format(c)),p!=n.length()?(n.append(" {0}  ".format(a[0][0].easingName)),n.setLength(n.length()-2),0==u?n.append(" instantly."):n.append(" over {0} seconds.".format(u*this.kTimeScale))):(n.length()>2&&n.setLength(n.length()-2),n.append(" wait for {0} seconds.".format(u*this.kTimeScale)))}else for(var g=0;g<s;g++){p=n.length(),h=this.kDefaultDuration;var b=1,v="absolute";for(d=0;d<this.kMaxActions;d++)null!=a[g][d]&&(a[g][d].action!=r&&a[g][d].action!=i||(h=a[g][d].fromValue),a[g][d].action==o&&(b=a[g][d].fromValue),a[g][d].action==l&&(b=a[g][d].fromValue,v="relative"));var w=g;for(d=0;d<this.kMaxActions&&(null==a[w][d]||a[w][d].reset(this));d++);for(d=0;d<this.kMaxActions&&(null==a[w][d]||a[w][d].describe(n));d++);b>1?n.append(" {0} repeating {1} times, ".format(v,b)):-1==b&&n.append(" {0} repeating forever, ".format(v)),p!=n.length()?(n.append(" {0}  ".format(a[w][0].easingName)),n.setLength(n.length()-2),0==h?n.append(" instantly."):n.append(" over {0} seconds.".format(h*this.kTimeScale))):n.append(" wait for {0} seconds.".format(h*this.kTimeScale)),g+1<s&&n.append(" Once complete then  ")}}describe(e,t){if(null==t||0==t.length)return"do nothing";var n=new StringBuilder;if(t.includes("[")){var a=t.replace("["," ").split("]"),r=0;n.append("Perform a series of animations at the same time.\n");for(var i=0;i<a.length;i++){var o=a[i];o.length>0&&(n.append("Animation #{0} will ".format(r+1)),this.describeOne(e,o,n),n.append("\n"),r++)}}else this.describeOne(e,t,n);return n.length()>0&&(n.insert(0,n.toString().substring(0,1).toUpperCase()),n.delete(1,1)),n.toString()}registerOperation(e,t,n,a){this.InitActions[e]=t,this.PerformActions[e]=n,this.DescribeActions[e]=a}constructor(){this.allEasings=[easeLinear,easeInQuad,easeOutQuad,easeInOutQuad,easeInCubic,easeOutCubic,easeInOutCubic,easeInQuart,easeOutQuart,easeInOutQuart,easeInQuint,easeOutQuint,easeInOutQuint,easeInSine,easeOutSine,easeInOutSine,easeInExpo,easeOutExpo,easeInOutExpo,easeInCirc,easeOutCirc,easeInOutCirc,easeInBounce,easeOutBounce,easeInOutBounce,easeShake],this.allEasingsByName=["ease linear","ease out quad","ease in quad","ease in/out quad","ease in cubic","ease out cubic","ease in/out cubic","ease in quart","ease out quart","ease in/out quart","ease in quint","ease out quint","ease in/out quint","ease in sine","eas out sine","ease in/out sine","ease in expo","ease out expo","ease in out expo","ease in circ","ease out circ","ease in/out circ","ease in bounce","ease out bounce","ease in/out bounce","ease shake"],this.LabaDefaultValue=Number.MIN_VALUE,this.InitActions={},this.PerformActions={},this.DescribeActions={},this.kMaxPipes=40,this.kMaxActions=40,this.kDefaultDuration=.57,this.kTimeScale=1;let e=this.LabaDefaultValue,t=this.kDefaultDuration;this.registerOperation("L",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("l",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("d",(function(n){return n.rawValue==e&&(n.rawValue=t),n.fromValue=n.toValue=n.rawValue,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("D",(function(n){n.rawValue==e&&(n.rawValue=t);for(var a=0,r=n.elem;null!=(r=r.previousSibling);)a++;return n.fromValue=n.toValue=n.rawValue*a,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("x",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move from {0} x pos, ".format(t.rawValue)):e.append("move to {0} x pos, ".format(t.rawValue))})),this.registerOperation("y",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move from {0} y pos, ".format(t.rawValue)):e.append("move to {0} y pos, ".format(t.rawValue))})),this.registerOperation("z",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformZ):(t.fromValue=t.elem.labaTransformZ,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformZ=t}),(function(e,t){t.inverse?e.append("move from {0} z pos, ".format(t.rawValue)):e.append("move to {0} z pos, ".format(t.rawValue))})),this.registerOperation("<",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX+t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX-t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from right {0} units, ".format(t.rawValue)):e.append("move left {0} units, ".format(t.rawValue))})),this.registerOperation(">",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX-t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX+t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from left {0} units, ".format(t.rawValue)):e.append("move right {0} units, ".format(t.rawValue))})),this.registerOperation("^",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY+t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY-t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from below {0} units, ".format(t.rawValue)):e.append("move up {0} units, ".format(t.rawValue))})),this.registerOperation("v",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY-t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY+t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from above {0} units, ".format(t.rawValue)):e.append("move down {0} units, ".format(t.rawValue))})),this.registerOperation("s",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaScale,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaScale=t}),(function(e,t){t.inverse?e.append("scale in from {0}%, ".format(100*t.rawValue)):e.append("scale to {0}%, ".format(100*t.rawValue))})),this.registerOperation("r",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationZ+t.rawValue,t.toValue=t.elem.labaRotationZ):(t.fromValue=t.elem.labaRotationZ,t.toValue=t.elem.labaRotationZ-t.rawValue),t}),(function(e,t,n){e.labaRotationZ=t}),(function(e,t){t.inverse?e.append("rotate in from around z by {0}, ".format(t.rawValue)):e.append("rotate around z by {0}, ".format(t.rawValue))})),this.registerOperation("p",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationX+t.rawValue,t.toValue=t.elem.labaRotationX):(t.fromValue=t.elem.labaRotationX,t.toValue=t.elem.labaRotationX-t.rawValue),t}),(function(e,t,n){e.labaRotationX=t}),(function(e,t){t.inverse?e.append("rotate in from around x by {0}, ".format(t.rawValue)):e.append("rotate around x by {0}, ".format(t.rawValue))})),this.registerOperation("w",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationY+t.rawValue,t.toValue=t.elem.labaRotationY):(t.fromValue=t.elem.labaRotationY,t.toValue=t.elem.labaRotationY-t.rawValue),t}),(function(e,t,n){e.labaRotationY=t}),(function(e,t){t.inverse?e.append("rotate in from around y by {0}, ".format(t.rawValue)):e.append("rotate around y by {0}, ".format(t.rawValue))})),this.registerOperation("f",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaAlpha,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaAlpha=t}),(function(e,t){t.inverse?e.append("fade from {0}% to {1}%, ".format(100*t.fromValue,100*t.toValue)):e.append("fade to {0}%, ".format(100*t.rawValue))}))}}var Laba=new _Laba;class Matrix{constructor(e,t,n,a,r,i,o,l,s,u,m,c,f,h,d,p){this.m00=e,this.m01=t,this.m02=n,this.m03=a,this.m10=r,this.m11=i,this.m12=o,this.m13=l,this.m20=s,this.m21=u,this.m22=m,this.m23=c,this.m30=f,this.m31=h,this.m32=d,this.m33=p}static identity(){return new Matrix(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)}static translate(e,t,n){return new Matrix(1,0,0,e,0,1,0,t,0,0,1,n,0,0,0,1)}static scale(e,t,n){return new Matrix(e,0,0,0,0,t,0,0,0,0,n,0,0,0,0,1)}static rotateX(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(1,0,0,0,0,n,-t,0,0,t,n,0,0,0,0,1)}static rotateY(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,0,t,0,0,1,0,0,-t,0,n,0,0,0,0,1)}static rotateZ(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,-t,0,0,t,n,0,0,0,0,1,0,0,0,0,1)}static ortho(e,t,n,a,r,i){return new Matrix(2/(t-e),0,0,-(t+e)/(t-e),0,2/(a-n),0,-(a+n)/(a-n),0,0,-2/(i-r),-(i+r)/(i-r),0,0,0,1)}static ortho2d(e,t,n,a){return new Matrix.ortho(e,t,n,a,-1,1)}static frustrum(e,t,n,a,r,i){return new Matrix(2*r/(t-e),0,(t+e)/(t-e),0,0,2*r/(a-n),(a+n)/(a-n),0,0,0,-(i+r)/(i-r),-2*i*r/(i-r),0,0,-1,0)}static perspective(e,t,n,a){let r=n*tan(e*Float.pi/360),i=-r;return m4_frustrum(i*t,r*t,i,r,n,a)}static multiply(e,t){var n=Matrix.identity();return n.m00=e.m00*t.m00+e.m01*t.m10+e.m02*t.m20+e.m03*t.m30,n.m10=e.m10*t.m00+e.m11*t.m10+e.m12*t.m20+e.m13*t.m30,n.m20=e.m20*t.m00+e.m21*t.m10+e.m22*t.m20+e.m23*t.m30,n.m30=e.m30*t.m00+e.m31*t.m10+e.m32*t.m20+e.m33*t.m30,n.m01=e.m00*t.m01+e.m01*t.m11+e.m02*t.m21+e.m03*t.m31,n.m11=e.m10*t.m01+e.m11*t.m11+e.m12*t.m21+e.m13*t.m31,n.m21=e.m20*t.m01+e.m21*t.m11+e.m22*t.m21+e.m23*t.m31,n.m31=e.m30*t.m01+e.m31*t.m11+e.m32*t.m21+e.m33*t.m31,n.m02=e.m00*t.m02+e.m01*t.m12+e.m02*t.m22+e.m03*t.m32,n.m12=e.m10*t.m02+e.m11*t.m12+e.m12*t.m22+e.m13*t.m32,n.m22=e.m20*t.m02+e.m21*t.m12+e.m22*t.m22+e.m23*t.m32,n.m32=e.m30*t.m02+e.m31*t.m12+e.m32*t.m22+e.m33*t.m32,n.m03=e.m00*t.m03+e.m01*t.m13+e.m02*t.m23+e.m03*t.m33,n.m13=e.m10*t.m03+e.m11*t.m13+e.m12*t.m23+e.m13*t.m33,n.m23=e.m20*t.m03+e.m21*t.m13+e.m22*t.m23+e.m23*t.m33,n.m33=e.m30*t.m03+e.m31*t.m13+e.m32*t.m23+e.m33*t.m33,n}}function isDarkMode(){return!(!window.matchMedia||!window.matchMedia("(prefers-color-scheme: dark)").matches)}function watchDarkMode(e){window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change",(t=>{e(t.matches)}))}function print(e){console.log(e)}function hide(e){e.style.display="none"}function show(e){e.style.display="flex"}function hashCode(e){return e.split("").reduce((function(e,t){return(e=(e<<5)-e+t.charCodeAt(0))&e}),0)}function onRangeChange(e,t){var n,a,r;e.addEventListener("input",(function(e){n=1,(a=e.target.value)!=r&&t(e),r=a})),e.addEventListener("change",(function(e){n||t(e)}))}function rad2Deg(e){return e*(180/Math.PI)}function deg2Rad(e){return e*(Math.PI/180)}function rand01(){return Math.random()}function randSign(){return Math.random()<.5?-1:1}function randomFromArray(e){return e[Math.floor(Math.random()*e.length)]}function getChild(e,t){return e.getElementById(t)}function insertAt(e,t,n){e.splice(t,0,n)}function removeAt(e,t){return e.splice(t,1),e}function removeOne(e,t){var n=e.indexOf(t);return n>-1&&e.splice(n,1),e}function removeAll(e,t){for(var n=0;n<e.length;)e[n]===t?e.splice(n,1):++n;return e}function removeAllChildren(e){for(;e.firstChild;)e.removeChild(e.firstChild)}function removeFromParent(e){e.parentElement&&e.parentElement.removeChild(e)}function disableDiv(e){e.style.opacity=.5,e.style.pointerEvents="none"}function enableDiv(e){e.style.opacity=1,e.style.pointerEvents="auto"}function replaceHtml(e,t){e.innerHTML=t,runAllScriptsIn(e)}function insertHtml(e,t){let n=e.children.length;e.insertAdjacentHTML("beforeend",t);for(var a=n;a<e.children.length;a++)runAllScriptsIn(e.children[a]);return e.children[n]}function runAllScriptsIn(div){"text/javascript"==div.type&&eval(div.innerHTML);var scripts=Array.from(div.getElementsByTagName("script"));for(let _arr=null!=scripts?scripts:[],_idx=0,child;child=_arr[_idx],_idx<_arr.length;_idx++)null!=child.type&&"text/javascript"!=child.type||eval(child.innerHTML)}function prettyDate(e,t=!0){if(0==t)return new Date(e).toLocaleDateString("en-US");let n=(new Date-new Date(e))/1e3,a=Math.floor(n/86400);return isNaN(a)||a<0||a>=31?new Date(e).toLocaleDateString("en-US"):0==a&&((n<60?"just now":n<120&&"1 minute ago")||n<3600&&Math.floor(n/60)+" minutes ago"||n<7200&&"1 hour ago"||n<86400&&Math.floor(n/3600)+" hours ago")||1==a&&"Yesterday"||a<7&&a+" days ago"||a<31&&Math.ceil(a/7)+" weeks ago"}function lerp(e,t,n){return e*(1-n)+t*n}function clamp(e,t,n){return e<=t?t:e>=n?n:e}function clamp01(e){return e<=0?0:e>=1?1:e}function parseVec(e){if(null==e)return{x:0,y:0};var t=e.split(",");return{x:parseFloat(t[0]),y:parseFloat(t[1])}}function distanceSq(e,t){return(t.x-e.x)*(t.x-e.x)+(t.y-e.y)*(t.y-e.y)}function allElementsFromPoint(e,t){for(var n,a=[],r=[];(n=document.elementFromPoint(e,t))&&n!==document.documentElement;)a.push(n),r.push(n.style.visibility),n.style.visibility="hidden";for(var i=0;i<a.length;i++)a[i].style.visibility=r[i];return a.reverse(),a}function textFieldOnReturn(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function textFieldOnChange(e,t){e.addEventListener("keyup",(function(n){clearTimeout(e.searchTimeout),13===n.keyCode?(n.preventDefault(),t()):e.searchTimeout=setTimeout((function(){t()}),650)}))}function textFieldOnEnter(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function UUID(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function UNIQUEID(){return"bxxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function stripHtml(e){print(e);let t=(new DOMParser).parseFromString(e,"text/html");return print(t.body.textContent),t.body.textContent||""}function unstripHtml(e){return e.replace("&lt;","<")}function clone(e){return JSON.parse(JSON.stringify(e))}function isSmallScreen(){return window.innerWidth<window.innerHeight||window.innerWidth<900}function sendIfModified(e,t,n,a){var r=new XMLHttpRequest;r.onreadystatechange=function(){4==this.readyState&&(503==this.status?window.location.href="./":(200!=this.status&&(null!=this.responseText&&this.responseText.length>0||this.statusText),null!=a&&a(this)))},r.open("POST","./");let i=sessionStorage.getItem("Session-Id");null!=i&&r.setRequestHeader("Session-Id",i),r.setRequestHeader("Flynn-Tag","hotload"),r.setRequestHeader("Pragma","no-cache"),r.setRequestHeader("Expires","-1"),r.setRequestHeader("Cache-Control","no-cache"),null!=t&&r.setRequestHeader("If-Modified-Since",t),e instanceof FormData?r.send(e):(r.setRequestHeader("Content-Type","application/json;charset=UTF-8"),r.send(JSON.stringify(e)))}function send(e,t){return sendIfModified(e,void 0,!1,t)}function endSession(e){send({endUserSession:!0},(function(){e()}))}let globalTimers=[];function initTimers(){setInterval(callTimers,250)}function callTimers(){for(let e,t=null!=globalTimers?globalTimers:[],n=0;e=t[n],n<t.length;n++)e.counter-=250,e.counter<=0&&(e.counter=e.delay,e.callback())}function addTimer(e,t){globalTimers.push({callback:t,delay:e,counter:e})}function clearTimer(e){for(let t,n=null!=globalTimers?globalTimers:[],a=0;t=n[a],a<n.length;a++)t.callback==e&&removeOne(globalTimers,t)}function clearAllTimer(){globalTimers=[]}function InitFigurehead(){initTimers(),function e(){Laba.update(),window.requestAnimationFrame(e)}()}let endeavour={send:function(e,t){send(e,(function(e){let n=e.getResponseHeader("Service-Response");if(null!=n){let a=JSON.parse(n);t(e,a)}else t(e,void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,t){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},t)},leave:function(e,t){endeavour.send({service:"EndeavourService",command:"leave",documentUUID:e},t)},save:function(e,t){endeavour.send({service:"EndeavourService",command:"save",documentUUID:e},t)},revert:function(e,t){endeavour.send({service:"EndeavourService",command:"revert",documentUUID:e},t)}};

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
    
</style> <style>
    :root {
        --end-peer0-dark: #145066;
        --end-peer1-dark: #306638;
        --end-peer2-dark: #664b1a;
        --end-peer3-dark: #665c1e;
        --end-peer4-dark: #662a22;
        --end-peer5-dark: #4e6266;
        --end-peer6-dark: #476644;
        --end-peer7-dark: #0c5c66;
        
        --end-peer0-light: #d5e7ed;
        --end-peer1-light: #d3ebd7;
        --end-peer2-light: #fff6e5;
        --end-peer3-light: #edead5;
        --end-peer4-light: #edd8d5;
        --end-peer5-light: #dce8ea;
        --end-peer6-light: #dbefda;
        --end-peer7-light: #e5fcff;
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --end-peer0-light: #0f3c4d;
            --end-peer1-light: #244d2a;
            --end-peer2-light: #4d3813;
            --end-peer3-light: #4d4516;
            --end-peer4-light: #4d1f19;
            --end-peer5-light: #3a494d;
            --end-peer6-light: #354d33;
            --end-peer7-light: #09454d;
        
            --end-peer0-dark: #8ed5ed;
            --end-peer1-dark: #8deb9c;
            --end-peer2-dark: #ffdb99;
            --end-peer3-dark: #ede18e;
            --end-peer4-dark: #ed998e;
            --end-peer5-dark: #8dddeb;
            --end-peer6-dark: #95f090;
            --end-peer7-dark: #99f3ff;
        }
    }
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
    </style> </head> <body> <noscript> <div style="position:fixed;display:flex;justify-content:center;align-items:center;width:100%;height:100%;padding:0px;margin:0px;overflow:hidden;"> <h1>This app requires Javascript to be enabled.</h1> </div> </noscript> <div style="display:flex;flex-direction:column;min-height:100%;flex: 1 1 auto;align-items:stretch;"><a href="https://github.com/KittyMac/Endeavour" class="github-corner" aria-label="View source on GitHub"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#535457; color:white; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style> <div style="display:flex;flex-direction:row;min-height:5rem;width:100%;margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;"><div style="display:flex;flex-direction:column;flex: 1 1 auto;min-height:5rem;"><div style="display:flex;font-size:2.2rem;font-family:'Roboto';color:var(--fh-fblack);">Endeavour</div> <div style="display:flex;font-size:1.0rem;font-family:'Lato';color:var(--fh-fblack);">Collaborative Swift editor using CodeMirror6</div></div></div> <div style="display:flex;flex-direction:row;justify-content:flex-end;margin-top:0rem;margin-left:0.5rem;margin-bottom:0rem;margin-right:0.5rem;flex: 1 1 auto;align-self:stretch;"><div id="newDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="sharedDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="newDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Shared Document</div></div> <div style="display:flex;flex: 1 1 auto;align-self:stretch;"></div> <div id="newDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="newDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="newDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">New Document</div></div> <div id="joinDocumentButton" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="askJoinDocument()" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="joinDocumentButtonValue" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Join Document</div></div></div> <div id="documents" style="display:flex;flex-direction:column;width:100%;"></div></div> <div id="alertsContainer" style="display:flex;left:0px;top:0px;margin:0px;padding:0px;width:100%;height:100%;position:fixed;position:fixed;background:rgba(0,0,0,0.5);justify-content:center;align-items:center;overflow:hidden;display:none;"></div> <script src="public/endeavour/editor.bundle.js"></script> <script>
        InitFigurehead();
        
        function handleCreateDocument(xhttp, serviceJson) {
            if (xhttp.readyState == 4 && xhttp.status != 200) {
                let error = xhttp.responseText || "An unknown error occured";
                alert(error);
                return;
            }
            
            let documentUUID = serviceJson.documentUUID;
            let documentID = `document${documentUUID}`
            let editorID = `editor${documentUUID}`
            let headerID = `header${documentUUID}`
            let peersID = `peers${documentUUID}`
            let saveID = `save${documentUUID}`
            let revertID = `revert${documentUUID}`
                            
            let html = `<div id="document${documentUUID}" style="display:flex;flex-direction:column;max-height:50rem;box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;border:0.15rem solid var(--fh-item-outline);overflow:hidden;border-radius:0.75rem;background:var(--fh-white);"><div style="display:flex;flex-direction:row;align-items:center;padding-top:0.5rem;padding-left:1rem;padding-bottom:0.5rem;padding-right:1rem;margin-top:0rem;margin-left:0rem;margin-bottom:0rem;margin-right:-0.125rem;"><div style="display:flex;flex-direction:column;justify-content:space-evenly;flex: 1 1 auto;align-self:stretch;"><div id="header${documentUUID}" style="display:flex;font-size:1rem;font-family:'Lato';color:var(--fh-fblack);">Creating new document...</div> <div id="peers${documentUUID}" style="display:flex;flex-direction:row;"></div></div> <div style="display:flex;flex: 1 1 auto;align-self:stretch;"></div> <div id="revert${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="revertDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="revert${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Revert</div></div> <div id="save${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="saveDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="save${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Save</div></div> <div id="leave${documentUUID}" style="display:flex;flex-direction:row;justify-content:center;align-items:center;border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;background:var(--fh-btn-background);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);font-size:1rem;font-family:'Roboto';-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;min-width:4rem;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;" onclick="leaveDocument('${documentUUID}')" onmousedown="this.style.background='var(--fh-btn-highlight)'" onmouseout="this.style.background='var(--fh-btn-background)'" onmouseup="this.style.background='var(--fh-btn-background)'"><div id="leave${documentUUID}Value" style="display:flex;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">Leave</div></div></div> <div style="display:flex;flex-direction:column;flex: 1 1 auto;align-items:stretch;min-height:10rem;background:rgba(255,255,255,1);"><div id="editor${documentUUID}" style="display:flex;border-top:0.1rem solid var(--fh-item-outline);flex: 1 1 auto;width:100%;overflow:hidden;"></div></div></div>`
            insertHtml(documents, html);
            
            let documentHeader = document.getElementById(headerID);
            documentHeader.innerText = `Document ${documentUUID}`;
            
            let documentSave = document.getElementById(saveID);
            let documentRevert = document.getElementById(revertID);
            if (serviceJson.canSave == 1) {
                disableDiv(documentRevert);
                disableDiv(documentSave);
            } else {
                removeFromParent(documentRevert);
                removeFromParent(documentSave);
            }
            
            
            let documentStatusUpdate = function(documentInfo, documentStatus) {
                let ignoreErrors = [
                    "Version mismatch"
                ];
                                                
                let displayText = `Document ${documentStatus.documentUUID}`;
                let isError = false;
                                
                let errorText = documentStatus.error;
                if (errorText != undefined) {
                    for (let _arr = (ignoreErrors != undefined ? ignoreErrors : []), _idx = 0, ignoreError = undefined; ignoreError = _arr[_idx], _idx < _arr.length; _idx++) {
                        if (errorText.includes(ignoreError)) {
                            errorText = undefined;
                            break;
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
                
                let peerHtml = ``;
                if (documentStatus.peers != undefined) {
                    for (let _arr = (documentStatus.peers != undefined ? documentStatus.peers : []), _idx = 0, peer = undefined; peer = _arr[_idx], _idx < _arr.length; _idx++) {
                        peerHtml += `<div style="display:flex;font-size:0.75rem;font-family:'Lato';border-radius:0.5rem;padding-top:0.1rem;padding-left:0.5rem;padding-bottom:0.1rem;padding-right:0.5rem;margin-top:0rem;margin-left:0rem;margin-bottom:0rem;margin-right:0.5rem;color:${peer.colors.color};background:${peer.colors.light};justify-content:center;align-items:center;">${peer.name}</div>`;
                    }
                }
                let peersHeader = document.getElementById(peersID);
                replaceHtml(peersHeader, peerHtml);
                
                // If the version of the document is 0 then there have been
                // no changes and the save button should be disabled
                if (documentSave != undefined && documentRevert != undefined) {
                    if (documentStatus.version == 0) {
                        disableDiv(documentSave);
                        disableDiv(documentRevert);
                    } else {
                        enableDiv(documentSave);
                        enableDiv(documentRevert);
                    }
                }
                
                print(documentStatus);
            }

            let editor = cm.CreateEditor(editorID, [
                cm.swiftSetup,
                cm.endeavourExtension(serviceJson, documentStatusUpdate)
            ], xhttp.responseText, serviceJson.canWrite == 1);
            
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
                if (xhttp.readyState == 4) {
                    if (xhttp.status != 200) {
                        let error = xhttp.responseText || "An unknown error occured";
                        alert(error);
                        return;
                    } else {
                        alert("Save completed")
                    }
                }
            });
        }
        
        function revertDocument(documentUUID) {
            endeavour.revert(documentUUID, function(xhttp, serviceJson) {
                if (xhttp.readyState == 4 && xhttp.status != 200) {
                    let error = xhttp.responseText || "An unknown error occured";
                    alert(error);
                    return;
                }
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

