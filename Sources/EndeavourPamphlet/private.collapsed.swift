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
function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}function initFieldWithCount(e,t,n){e.updateCounter=function(){var a=e.value.length;t.innerText=`${a} of ${n}`,t.style.color=a<=n?"white":"var(--fh-error-red)"},e.oninput=e.updateCounter,e.onchange=e.updateCounter,e.onkeyup=e.updateCounter,e.updateCounter()}var alertsQueue=[];function handleAlertsQueue(){var e=function(){1==alertsContainer.isOpen&&(alertsContainer.isOpen=!1,Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f0",void 0,(function(){alertsContainer.style.display="none"})))},t=function(t){var n=document.getElementById(t);null!=n&&(0==alertsQueue.length&&e(),Laba.animate(n,"!f0",(function(e,t){e.style.height=(1-t)*e.actualHeight+"px",e.style.minHeight=e.style.height}),(function(){removeFromParent(n),handleAlertsQueue()})))};0!=alertsQueue.length?(0==alertsContainer.isOpen&&(alertsContainer.isOpen=!0,alertsContainer.style.display="flex",Laba.cancel(alertsContainer),Laba.animate(alertsContainer,"f1",void 0,(function(){}))),0==alertsContainer.children.length&&function(e){for(var n=e.message,a=e.buttons,r=e.callbacks,i=UNIQUEID(),o="",s=!0,l=a.length-1;l>=0;l-=1){var u=a[l];s?(s=!1,o+=`<div id="${i}Btn${l}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;background:rgba(66,147,247,1.0);" onmousedown="this.style.background='rgba(48,107,179,1)'" onmouseout="this.style.background='rgba(66,147,247,1)'" onmouseup="this.style.background='rgba(66,147,247,1)'"><div id="${i}Btn${l}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${u}</div></div>`):o+=`<div id="${i}Btn${l}" style="display:flex;z-index:2;flex-direction:row;justify-content:center;align-items:center;font-size:1rem;font-family:'Roboto';border-radius:0.35rem;height:2.2rem;min-height:2.2rem;max-height:2.2rem;padding-top:0rem;padding-left:0.5rem;padding-bottom:0rem;padding-right:0.5rem;margin-top:0.4rem;margin-left:0.4rem;margin-bottom:0.4rem;margin-right:0.4rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;color:var(--fh-fwhite);-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;align-self:stretch;flex: 1 1 auto;color:rgba(66,147,247,1.0);" onmousedown="this.style.color='rgba(48,107,179,1)'" onmouseout="this.style.color='rgba(66,147,247,1)'" onmouseup="this.style.color='rgba(66,147,247,1)'"><div id="${i}Btn${l}Value" style="display:flex;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;padding-top:0rem;padding-left:1rem;padding-bottom:0rem;padding-right:1rem;width:100%;height:100%;flex: 1 1 auto;justify-content:center;align-items:center;">${u}</div></div>`}for(insertHtml(alertsContainer,`<div id="${i}" style="display:flex;border-radius:1rem;background:var(--fh-white);box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);flex-direction:column;padding-top:0.5rem;padding-left:2rem;padding-bottom:0rem;padding-right:2rem;max-width:90%;min-width:14rem;min-height:5rem;opacity:0;justify-content:center;align-items:center;overflow:hidden;"><div style="display:flex;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;margin-top:0rem;margin-left:0rem;margin-bottom:0.5rem;margin-right:0rem;"><div style="display:flex;flex-direction:column;text-align:center;flex: 1 1 auto;align-self:stretch;justify-content:center;align-items:center;color:rgba(255,255,255,1);font-size:1rem;font-family:'Lato';margin-top:1rem;margin-left:1rem;margin-bottom:1rem;margin-right:1rem;color:var(--fh-fblack);">${n}</div></div> <div style="display:flex;flex: 1 1 auto;width:100%;flex-direction:column;margin-top:0rem;margin-left:1rem;margin-bottom:0.5rem;margin-right:1rem;max-width:20rem;align-self:center;">${o}</div></div>`),l=r.length-1;l>=0;l-=1){var m=document.getElementById(i+"Btn"+l);m.callback=r[l],m.addEventListener("mouseup",(function(e){null!=e.currentTarget.callback&&e.currentTarget.callback(),t(i)}))}requestAnimationFrame((function(){var e=document.getElementById(i);e.actualHeight=e.offsetHeight,Laba.animate(e,"!f1",(function(e,t){e.style.height=t*e.actualHeight+"px",e.style.minHeight=e.style.height}),(function(e){e.style.height=""}))}))}(alertsQueue.shift())):e()}function alert(e,t,n){null!=e&&0!=e.length&&(null==alertsContainer.isOpen&&(alertsContainer.isOpen=!1),null==t&&(t=["Ok"]),null==n&&(n=[void 0]),alertsQueue.push({message:e,buttons:t,callbacks:n}),handleAlertsQueue())}function initButton(e,t,n){if(null!=e.length)for(let t,a=null!=e?e:[],r=0;t=a[r],r<a.length;r++)t.addEventListener("mouseup",(function(e){null!=n&&n(this)}));else e.addEventListener("mouseup",(function(e){null!=n&&n(this)}))}function StringBuilder(){var e=[];this.length=function(){for(var t=0,n=0;n<e.length;n++)t+=e[n].length;return t},this.setLength=function(t){let n=e.join("").substring(0,t);(e=[])[0]=n},this.insert=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=n,e[2]=a.substring(t)},this.delete=function(t,n){let a=e.join("");(e=[])[0]=a.substring(0,t),e[1]=a.substring(n+1)},this.append=function(n){(n=t(n)).length>0&&(e[e.length]=n)},this.appendLine=function(n){if(n=t(n),this.isEmpty()){if(!(n.length>0))return;e[e.length]=n}else e[e.length]=n.length>0?"\r\n"+n:"\r\n"},this.clear=function(){e=[]},this.isEmpty=function(){return 0==e.length},this.toString=function(){return e.join("")};var t=function(e){return n(e)?a(e)!=a(new String)?String(e):e:""},n=function(e){return null!=e&&void 0!==e},a=function(e){if(!n(e.constructor))throw Error("Unexpected object type");var t=String(e.constructor).match(/function\s+(\w+)/);return n(t)?t[1]:"undefined"}}function easeLinear(e){return 0+1*e}function easeInQuad(e){return 0,1*e*e+0}function easeOutQuad(e){return 0,-1*e*(e-2)+0}function easeInOutQuad(e){return 0,(e/=.5)<1?.5*e*e+0:-.5*(--e*(e-2)-1)+0}function easeInCubic(e){return 0,1*e*e*e+0}function easeOutCubic(e){return 0,1*(--e*e*e+1)+0}function easeInOutCubic(e){return 0,(e/=.5)<1?.5*e*e*e+0:.5*((e-=2)*e*e+2)+0}function easeInQuart(e){return 0,1*e*e*e*e+0}function easeOutQuart(e){return 0,-1*(--e*e*e*e-1)+0}function easeInOutQuart(e){return 0,(e/=.5)<1?.5*e*e*e*e+0:-.5*((e-=2)*e*e*e-2)+0}function easeInQuint(e){return 0,1*e*e*e*e*e+0}function easeOutQuint(e){return 0,1*(--e*e*e*e*e+1)+0}function easeInOutQuint(e){return 0,(e/=.5)<1?.5*e*e*e*e*e+0:.5*((e-=2)*e*e*e*e+2)+0}function easeInSine(e){return 0,-1*Math.cos(e/1*(Math.PI/2))+1+0}function easeOutSine(e){return 0,1*Math.sin(e/1*(Math.PI/2))+0}function easeInOutSine(e){return 0,-.5*(Math.cos(Math.PI*e/1)-1)+0}function easeInExpo(e){return 0,1*Math.pow(2,10*(e/1-1))+0}function easeOutExpo(e){return 0,1*(1-Math.pow(2,-10*e/1))+0}function easeInOutExpo(e){return 0,(e/=.5)<1?.5*Math.pow(2,10*(e-1))+0:(e--,.5*(2-Math.pow(2,-10*e))+0)}function easeInCirc(e){return 0,-1*(Math.sqrt(1-e*e)-1)+0}function easeOutCirc(e){return e--,0,1*Math.sqrt(1-e*e)+0}function easeInOutCirc(e){return 0,(e/=.5)<1?-.5*(Math.sqrt(1-e*e)-1)+0:(e-=2,.5*(Math.sqrt(1-e*e)+1)+0)}function easeOutBounce(e){return e<4/11?121*e*e/16:e<8/11?9.075*e*e-9.9*e+3.4:e<.9?4356/361*e*e-35442/1805*e+16061/1805:10.8*e*e-20.52*e+10.72}function easeInBounce(e){return 1-easeOutBounce(1-e)}function easeInOutBounce(e){return e<.5?.5*easeInBounce(2*e):.5*easeOutBounce(2*e-1)+.5}function easeShake(e){return(Math.sin(3.14*e*6+.785)-.5)*(1-e)}String.prototype.format=function(){for(k in a=this,arguments)a=a.replace("{"+k+"}",arguments[k]);return a},Math.radians=function(e){return e*Math.PI/180},Math.degrees=function(e){return 180*e/Math.PI};var _allLabalTimers=[];class _LabaTimer{update(){var e=(performance.now()-this.startTime)/(this.endTime-this.startTime);if(this.endTime==this.startTime&&(e=1),e>=1&&(e=1),null!=this.onUpdate){var t=this.action.easing;null==t&&(t=easeInOutQuad),this.onUpdate(this.view,t(e))}if(e>=1)return this.action(e,!1),-1==this.loopCount?(this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):this.loopCount>1?(this.loopCount--,this.action(0,!0),this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,void this.view.labaCommitElemVars()):(removeOne(_allLabalTimers,this),null!=this.onComplete&&this.onComplete(this.view),void this.view.labaCommitElemVars());this.action(e,!1),this.view.labaCommitElemVars()}constructor(e,t,n,a,r,i,o,s){this.view=e,this.loopCount=s,this.action=t,this.duration=r,this.onComplete=o,this.onUpdate=i,this.startTime=performance.now(),this.endTime=this.startTime+1e3*this.duration,this.action(0,!0),_allLabalTimers.push(this),this.update(0)}}class _LabaAction{constructor(e,t,n,a,r,i,o){this.operatorChar=t,this.elem=n,this.inverse=a,this.rawValue=r,this.easing=i,this.easingName=o,this.action=e.PerformActions[t],this._describe=e.DescribeActions[t],this._init=e.InitActions[t],0==this.inverse?(this.fromValue=0,this.toValue=1):(this.fromValue=1,this.toValue=0),null!=this._init&&this._init(this)}reset(e){if(null!=this._init){var t=new _LabaAction(e,this.operatorChar,this.elem,this.inverse,this.rawValue,this.easing,this.easingName);return this.fromValue=t.fromValue,this.toValue=t.toValue,!0}return!1}perform(e){return null!=this.action&&(this.action(this.elem,this.fromValue+(this.toValue-this.fromValue)*this.easing(e),this),!0)}describe(e){return null!=this._describe&&(this._describe(e,this),!0)}}class _Laba{isOperator(e){return","==e||"|"==e||"!"==e||"e"==e||e in this.InitActions}isNumber(e){return"+"==e||"-"==e||"0"==e||"1"==e||"2"==e||"3"==e||"4"==e||"5"==e||"6"==e||"7"==e||"8"==e||"9"==e||"."==e}update(){for(var e in _allLabalTimers)_allLabalTimers[e].update()}parseAnimationString(e,t){for(var n=0,a=0,r=0,i=this.allEasings[3],o=this.allEasingsByName[3],s=[],l=0;l<this.kMaxPipes;l++){s[l]=[];for(var u=0;u<this.kMaxActions;u++)s[l][u]=void 0}for(;n<t.length;){for(var m=!1,c=" ";n<t.length;){var f=t[n];if(this.isOperator(f))if("!"==f)m=!0;else if("|"==f)a++,r=0;else{if(","!=f){c=f,n++;break}0!=r&&(a++,r=0),s[a][r]=new _LabaAction(this,"d",e,!1,.26*this.kDefaultDuration,i,o),a++,r=0}n++}for(;n<t.length&&!this.isNumber(t[n])&&!this.isOperator(t[n]);)n++;var h=this.LabaDefaultValue;if(n<t.length&&this.isNumber(t[n])){var d=!1;"+"==t[n]?n++:"-"==t[n]&&(d=!0,n++),h=0;for(var p=!1,g=10;n<t.length;){f=t[n];if(this.isNumber(f)&&(f>="0"&&f<="9"&&(p?(h+=(f-"0")/g,g*=10):h=10*h+(f-"0")),"."==f&&(p=!0)),this.isOperator(f))break;n++}d&&(h*=-1)}if(" "!=c)if(c in this.InitActions)s[a][r]=new _LabaAction(this,c,e,m,h,i,o),r++;else if("e"==c){var b=h;b>=0&&n<this.allEasings.length&&(i=this.allEasings[b],o=this.allEasingsByName[b])}}return s}animateOne(e,t,n,a){for(var r=this,i=this.parseAnimationString(e,t),o=this.PerformActions.d,s=this.PerformActions.D,l=this.PerformActions.L,u=this.PerformActions.l,m=0,c=0,f=1,h=!1,d=0;d<this.kMaxPipes;d++)if(null!=i[d][0]){m++;for(var p=this.kDefaultDuration,g=0;g<this.kMaxActions;g++)null!=i[d][g]&&(i[d][g].action!=o&&i[d][g].action!=s||(p=i[d][g].fromValue),i[d][g].action==l&&(f=i[d][g].fromValue),i[d][g].action==u&&(h=!0,f=i[d][g].fromValue));c+=p}if(1==m)if(h)new _LabaTimer(e,(function(e,t){if(1==t)for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].reset(r));n++);for(var a=0;a<r.kMaxActions&&(null==i[0][a]||i[0][a].perform(e));a++);}),0,1,c,n,a,f);else{for(g=0;g<r.kMaxActions&&(null==i[0][g]||i[0][g].reset(r));g++);new _LabaTimer(e,(function(e,t){for(var n=0;n<r.kMaxActions&&(null==i[0][n]||i[0][n].perform(e));n++);}),0,1,c*r.kTimeScale,n,a,f)}else{for(var b=void 0,v=m-1;v>=0;v--){p=this.kDefaultDuration;var x=1,V=!1;for(g=0;g<this.kMaxActions;g++)null!=i[v][g]&&(i[v][g].action!=o&&i[v][g].action!=s||(p=i[v][g].fromValue),i[v][g].action==l&&(x=i[v][g].fromValue),i[v][g].action==u&&(V=!0,x=i[v][g].fromValue));let t=v;var w=b;null==w&&(w=a),null==w&&(w=function(){});let m=V,c=p,f=x,h=w;b=function(){if(m)new _LabaTimer(e,(function(e,n){if(1==n)for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);for(a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c,n,h,f);else{for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].reset(r));a++);new _LabaTimer(e,(function(e,n){for(var a=0;a<r.kMaxActions&&(null==i[t][a]||i[t][a].perform(e));a++);}),0,1,c*r.kTimeScale,n,h,f)}}}null!=b?b():null!=a&&a(this.view)}}reset(e){if(null==e.labaTransformX){var t=e;t.labaResetElemVars=function(){t.labaTransformX=0,t.labaTransformY=0,t.labaTransformZ=0,t.labaRotationX=0,t.labaRotationY=0,t.labaRotationZ=0,t.labaScale=1,null!=t.style&&(t.labaAlpha=parseFloat(t.style.opacity)),isNaN(t.labaAlpha)&&(t.labaAlpha=1)},t.labaCommitElemVars=function(){if(null!=t.position&&(t.position.set(t.labaTransformX,t.labaTransformY),t.scale.set(t.labaScale,t.labaScale),t.rotation=t.labaRotationZ,t.alpha=t.labaAlpha),null!=t.style){var e=Matrix.identity();e=Matrix.multiply(e,Matrix.translate(t.labaTransformX,t.labaTransformY,t.labaTransformZ)),e=Matrix.multiply(e,Matrix.rotateX(Math.radians(t.labaRotationX))),e=Matrix.multiply(e,Matrix.rotateY(Math.radians(t.labaRotationY))),e=Matrix.multiply(e,Matrix.rotateZ(Math.radians(t.labaRotationZ))),e=Matrix.multiply(e,Matrix.scale(t.labaScale,t.labaScale,t.labaScale));let n="perspective(500px) matrix3d({0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15})".format(e.m00,e.m10,e.m20,e.m30,e.m01,e.m11,e.m21,e.m31,e.m02,e.m12,e.m22,e.m32,e.m03,e.m13,e.m23,e.m33);t.style.webkitTransform=n,t.style.MozTransform=n,t.style.msTransform=n,t.style.OTransform=n,t.style.transform=n,t.style.opacity=t.labaAlpha}}}e.labaResetElemVars(),null==e.style&&null!=e.position&&(e.labaTransformX=e.position.x,e.labaTransformY=e.position.y,e.labaRotationZ=e.rotation,e.labaScale=e.scale.x,e.labaAlpha=e.alpha)}set(e,t,n,a,r,i,o,s,l){this.reset(e),e.labaTransformX=t,e.labaTransformY=n,e.labaTransformZ=a,e.labaRotationX=r,e.labaRotationY=i,e.labaRotationZ=o,e.labaScale=s,e.labaAlpha=l,e.labaCommitElemVars()}animate(e,t,n,a){if(null==e.labaTransformX&&this.reset(e),t.includes("["))for(var r=t.replace("["," ").split("]"),i=0;i<r.length;i++){var o=r[i];o.length>0&&(this.animateOne(e,o,n,a),a=void 0)}else this.animateOne(e,t,n,a),a=void 0}cancel(e){for(var t in _allLabalTimers)_allLabalTimers[t].view==e&&removeOne(_allLabalTimers,_allLabalTimers[t])}describeOne(e,t,n){for(var a=this.parseAnimationString(e,t),r=this.PerformActions.d,i=this.PerformActions.D,o=this.PerformActions.L,s=this.PerformActions.l,l=0,u=0,m=1,c="absolute",f=0;f<this.kMaxPipes;f++)if(null!=a[f][0]){l++;for(var h=this.kDefaultDuration,d=0;d<this.kMaxActions;d++)null!=a[f][d]&&(a[f][d].action!=r&&a[f][d].action!=i||(h=a[f][d].fromValue),a[f][d].action==o&&(m=a[f][d].fromValue),a[f][d].action==s&&(m=a[f][d].fromValue,c="relative"));u+=h}if(1==l){var p=n.length();for(f=0;f<this.kMaxActions&&(null==a[0][f]||a[0][f].describe(n));f++);m>1?n.append(" {0} repeating {1} times, ".format(c,m)):-1==m&&n.append(" {0} repeating forever, ".format(c)),p!=n.length()?(n.append(" {0}  ".format(a[0][0].easingName)),n.setLength(n.length()-2),0==u?n.append(" instantly."):n.append(" over {0} seconds.".format(u*this.kTimeScale))):(n.length()>2&&n.setLength(n.length()-2),n.append(" wait for {0} seconds.".format(u*this.kTimeScale)))}else for(var g=0;g<l;g++){p=n.length(),h=this.kDefaultDuration;var b=1,v="absolute";for(d=0;d<this.kMaxActions;d++)null!=a[g][d]&&(a[g][d].action!=r&&a[g][d].action!=i||(h=a[g][d].fromValue),a[g][d].action==o&&(b=a[g][d].fromValue),a[g][d].action==s&&(b=a[g][d].fromValue,v="relative"));var x=g;for(d=0;d<this.kMaxActions&&(null==a[x][d]||a[x][d].reset(this));d++);for(d=0;d<this.kMaxActions&&(null==a[x][d]||a[x][d].describe(n));d++);b>1?n.append(" {0} repeating {1} times, ".format(v,b)):-1==b&&n.append(" {0} repeating forever, ".format(v)),p!=n.length()?(n.append(" {0}  ".format(a[x][0].easingName)),n.setLength(n.length()-2),0==h?n.append(" instantly."):n.append(" over {0} seconds.".format(h*this.kTimeScale))):n.append(" wait for {0} seconds.".format(h*this.kTimeScale)),g+1<l&&n.append(" Once complete then  ")}}describe(e,t){if(null==t||0==t.length)return"do nothing";var n=new StringBuilder;if(t.includes("[")){var a=t.replace("["," ").split("]"),r=0;n.append("Perform a series of animations at the same time.\n");for(var i=0;i<a.length;i++){var o=a[i];o.length>0&&(n.append("Animation #{0} will ".format(r+1)),this.describeOne(e,o,n),n.append("\n"),r++)}}else this.describeOne(e,t,n);return n.length()>0&&(n.insert(0,n.toString().substring(0,1).toUpperCase()),n.delete(1,1)),n.toString()}registerOperation(e,t,n,a){this.InitActions[e]=t,this.PerformActions[e]=n,this.DescribeActions[e]=a}constructor(){this.allEasings=[easeLinear,easeInQuad,easeOutQuad,easeInOutQuad,easeInCubic,easeOutCubic,easeInOutCubic,easeInQuart,easeOutQuart,easeInOutQuart,easeInQuint,easeOutQuint,easeInOutQuint,easeInSine,easeOutSine,easeInOutSine,easeInExpo,easeOutExpo,easeInOutExpo,easeInCirc,easeOutCirc,easeInOutCirc,easeInBounce,easeOutBounce,easeInOutBounce,easeShake],this.allEasingsByName=["ease linear","ease out quad","ease in quad","ease in/out quad","ease in cubic","ease out cubic","ease in/out cubic","ease in quart","ease out quart","ease in/out quart","ease in quint","ease out quint","ease in/out quint","ease in sine","eas out sine","ease in/out sine","ease in expo","ease out expo","ease in out expo","ease in circ","ease out circ","ease in/out circ","ease in bounce","ease out bounce","ease in/out bounce","ease shake"],this.LabaDefaultValue=Number.MIN_VALUE,this.InitActions={},this.PerformActions={},this.DescribeActions={},this.kMaxPipes=40,this.kMaxActions=40,this.kDefaultDuration=.57,this.kTimeScale=1;let e=this.LabaDefaultValue,t=this.kDefaultDuration;this.registerOperation("L",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("l",(function(t){return t.rawValue==e&&(t.rawValue=-1),t.fromValue=t.toValue=t.rawValue,t}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("d",(function(n){return n.rawValue==e&&(n.rawValue=t),n.fromValue=n.toValue=n.rawValue,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("D",(function(n){n.rawValue==e&&(n.rawValue=t);for(var a=0,r=n.elem;null!=(r=r.previousSibling);)a++;return n.fromValue=n.toValue=n.rawValue*a,n}),(function(e,t,n){}),(function(e,t){})),this.registerOperation("x",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move from {0} x pos, ".format(t.rawValue)):e.append("move to {0} x pos, ".format(t.rawValue))})),this.registerOperation("y",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move from {0} y pos, ".format(t.rawValue)):e.append("move to {0} y pos, ".format(t.rawValue))})),this.registerOperation("z",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.rawValue,t.toValue=t.elem.labaTransformZ):(t.fromValue=t.elem.labaTransformZ,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaTransformZ=t}),(function(e,t){t.inverse?e.append("move from {0} z pos, ".format(t.rawValue)):e.append("move to {0} z pos, ".format(t.rawValue))})),this.registerOperation("<",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX+t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX-t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from right {0} units, ".format(t.rawValue)):e.append("move left {0} units, ".format(t.rawValue))})),this.registerOperation(">",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetWidth),t.inverse?(t.fromValue=t.elem.labaTransformX-t.rawValue,t.toValue=t.elem.labaTransformX):(t.fromValue=t.elem.labaTransformX,t.toValue=t.elem.labaTransformX+t.rawValue),t}),(function(e,t,n){e.labaTransformX=t}),(function(e,t){t.inverse?e.append("move in from left {0} units, ".format(t.rawValue)):e.append("move right {0} units, ".format(t.rawValue))})),this.registerOperation("^",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY+t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY-t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from below {0} units, ".format(t.rawValue)):e.append("move up {0} units, ".format(t.rawValue))})),this.registerOperation("v",(function(t){return t.rawValue==e&&(t.rawValue=t.elem.offsetHeight),t.inverse?(t.fromValue=t.elem.labaTransformY-t.rawValue,t.toValue=t.elem.labaTransformY):(t.fromValue=t.elem.labaTransformY,t.toValue=t.elem.labaTransformY+t.rawValue),t}),(function(e,t,n){e.labaTransformY=t}),(function(e,t){t.inverse?e.append("move in from above {0} units, ".format(t.rawValue)):e.append("move down {0} units, ".format(t.rawValue))})),this.registerOperation("s",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaScale,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaScale=t}),(function(e,t){t.inverse?e.append("scale in from {0}%, ".format(100*t.rawValue)):e.append("scale to {0}%, ".format(100*t.rawValue))})),this.registerOperation("r",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationZ+t.rawValue,t.toValue=t.elem.labaRotationZ):(t.fromValue=t.elem.labaRotationZ,t.toValue=t.elem.labaRotationZ-t.rawValue),t}),(function(e,t,n){e.labaRotationZ=t}),(function(e,t){t.inverse?e.append("rotate in from around z by {0}, ".format(t.rawValue)):e.append("rotate around z by {0}, ".format(t.rawValue))})),this.registerOperation("p",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationX+t.rawValue,t.toValue=t.elem.labaRotationX):(t.fromValue=t.elem.labaRotationX,t.toValue=t.elem.labaRotationX-t.rawValue),t}),(function(e,t,n){e.labaRotationX=t}),(function(e,t){t.inverse?e.append("rotate in from around x by {0}, ".format(t.rawValue)):e.append("rotate around x by {0}, ".format(t.rawValue))})),this.registerOperation("w",(function(t){return t.rawValue==e&&(t.rawValue=0),t.inverse?(t.fromValue=t.elem.labaRotationY+t.rawValue,t.toValue=t.elem.labaRotationY):(t.fromValue=t.elem.labaRotationY,t.toValue=t.elem.labaRotationY-t.rawValue),t}),(function(e,t,n){e.labaRotationY=t}),(function(e,t){t.inverse?e.append("rotate in from around y by {0}, ".format(t.rawValue)):e.append("rotate around y by {0}, ".format(t.rawValue))})),this.registerOperation("f",(function(t){return t.rawValue==e&&(t.rawValue=1),t.inverse?(t.fromValue=t.rawValue>.5?0:1,t.toValue=t.rawValue):(t.fromValue=t.elem.labaAlpha,t.toValue=t.rawValue),t}),(function(e,t,n){e.labaAlpha=t}),(function(e,t){t.inverse?e.append("fade from {0}% to {1}%, ".format(100*t.fromValue,100*t.toValue)):e.append("fade to {0}%, ".format(100*t.rawValue))}))}}var Laba=new _Laba;class Matrix{constructor(e,t,n,a,r,i,o,s,l,u,m,c,f,h,d,p){this.m00=e,this.m01=t,this.m02=n,this.m03=a,this.m10=r,this.m11=i,this.m12=o,this.m13=s,this.m20=l,this.m21=u,this.m22=m,this.m23=c,this.m30=f,this.m31=h,this.m32=d,this.m33=p}static identity(){return new Matrix(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)}static translate(e,t,n){return new Matrix(1,0,0,e,0,1,0,t,0,0,1,n,0,0,0,1)}static scale(e,t,n){return new Matrix(e,0,0,0,0,t,0,0,0,0,n,0,0,0,0,1)}static rotateX(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(1,0,0,0,0,n,-t,0,0,t,n,0,0,0,0,1)}static rotateY(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,0,t,0,0,1,0,0,-t,0,n,0,0,0,0,1)}static rotateZ(e){let t=Math.sin(e),n=Math.cos(e);return new Matrix(n,-t,0,0,t,n,0,0,0,0,1,0,0,0,0,1)}static ortho(e,t,n,a,r,i){return new Matrix(2/(t-e),0,0,-(t+e)/(t-e),0,2/(a-n),0,-(a+n)/(a-n),0,0,-2/(i-r),-(i+r)/(i-r),0,0,0,1)}static ortho2d(e,t,n,a){return new Matrix.ortho(e,t,n,a,-1,1)}static frustrum(e,t,n,a,r,i){return new Matrix(2*r/(t-e),0,(t+e)/(t-e),0,0,2*r/(a-n),(a+n)/(a-n),0,0,0,-(i+r)/(i-r),-2*i*r/(i-r),0,0,-1,0)}static perspective(e,t,n,a){let r=n*tan(e*Float.pi/360),i=-r;return m4_frustrum(i*t,r*t,i,r,n,a)}static multiply(e,t){var n=Matrix.identity();return n.m00=e.m00*t.m00+e.m01*t.m10+e.m02*t.m20+e.m03*t.m30,n.m10=e.m10*t.m00+e.m11*t.m10+e.m12*t.m20+e.m13*t.m30,n.m20=e.m20*t.m00+e.m21*t.m10+e.m22*t.m20+e.m23*t.m30,n.m30=e.m30*t.m00+e.m31*t.m10+e.m32*t.m20+e.m33*t.m30,n.m01=e.m00*t.m01+e.m01*t.m11+e.m02*t.m21+e.m03*t.m31,n.m11=e.m10*t.m01+e.m11*t.m11+e.m12*t.m21+e.m13*t.m31,n.m21=e.m20*t.m01+e.m21*t.m11+e.m22*t.m21+e.m23*t.m31,n.m31=e.m30*t.m01+e.m31*t.m11+e.m32*t.m21+e.m33*t.m31,n.m02=e.m00*t.m02+e.m01*t.m12+e.m02*t.m22+e.m03*t.m32,n.m12=e.m10*t.m02+e.m11*t.m12+e.m12*t.m22+e.m13*t.m32,n.m22=e.m20*t.m02+e.m21*t.m12+e.m22*t.m22+e.m23*t.m32,n.m32=e.m30*t.m02+e.m31*t.m12+e.m32*t.m22+e.m33*t.m32,n.m03=e.m00*t.m03+e.m01*t.m13+e.m02*t.m23+e.m03*t.m33,n.m13=e.m10*t.m03+e.m11*t.m13+e.m12*t.m23+e.m13*t.m33,n.m23=e.m20*t.m03+e.m21*t.m13+e.m22*t.m23+e.m23*t.m33,n.m33=e.m30*t.m03+e.m31*t.m13+e.m32*t.m23+e.m33*t.m33,n}}function print(e){console.log(e)}function hide(e){e.style.display="none"}function show(e){e.style.display="flex"}function hashCode(e){return e.split("").reduce((function(e,t){return(e=(e<<5)-e+t.charCodeAt(0))&e}),0)}function onRangeChange(e,t){var n,a,r;e.addEventListener("input",(function(e){n=1,(a=e.target.value)!=r&&t(e),r=a})),e.addEventListener("change",(function(e){n||t(e)}))}function rad2Deg(e){return e*(180/Math.PI)}function deg2Rad(e){return e*(Math.PI/180)}function rand01(){return Math.random()}function randSign(){return Math.random()<.5?-1:1}function randomFromArray(e){return e[Math.floor(Math.random()*e.length)]}function getChild(e,t){return e.getElementById(t)}function insertAt(e,t,n){e.splice(t,0,n)}function removeAt(e,t){return e.splice(t,1),e}function removeOne(e,t){var n=e.indexOf(t);return n>-1&&e.splice(n,1),e}function removeAll(e,t){for(var n=0;n<e.length;)e[n]===t?e.splice(n,1):++n;return e}function removeAllChildren(e){for(;e.firstChild;)e.removeChild(e.firstChild)}function removeFromParent(e){e.parentElement&&e.parentElement.removeChild(e)}function disableDiv(e){e.style.opacity=.5,e.style.pointerEvents="none"}function enableDiv(e){e.style.opacity=1,e.style.pointerEvents="auto"}function replaceHtml(e,t){e.innerHTML=t,runAllScriptsIn(e)}function insertHtml(e,t){let n=e.children.length;e.insertAdjacentHTML("beforeend",t);for(var a=n;a<e.children.length;a++)runAllScriptsIn(e.children[a]);return e.children[n]}function runAllScriptsIn(div){"text/javascript"==div.type&&eval(div.innerHTML);var scripts=Array.from(div.getElementsByTagName("script"));for(let _arr=null!=scripts?scripts:[],_idx=0,child;child=_arr[_idx],_idx<_arr.length;_idx++)null!=child.type&&"text/javascript"!=child.type||eval(child.innerHTML)}function prettyDate(e){return new Date(e).toLocaleDateString("en-US")}function lerp(e,t,n){return e*(1-n)+t*n}function clamp(e,t,n){return e<=t?t:e>=n?n:e}function clamp01(e){return e<=0?0:e>=1?1:e}function parseVec(e){if(null==e)return{x:0,y:0};var t=e.split(",");return{x:parseFloat(t[0]),y:parseFloat(t[1])}}function distanceSq(e,t){return(t.x-e.x)*(t.x-e.x)+(t.y-e.y)*(t.y-e.y)}function extractTitleFromMarkdown(e){var t=/#+(.*)/,n=e.match(t),a="Untitled";return null!=n&&n.length>=2&&(a=n[1],e=e.replace(t,"")),[a,e]}function isSmallScreen(){return window.innerHeight<24*emToPxValue*2}function allElementsFromPoint(e,t){for(var n,a=[],r=[];(n=document.elementFromPoint(e,t))&&n!==document.documentElement;)a.push(n),r.push(n.style.visibility),n.style.visibility="hidden";for(var i=0;i<a.length;i++)a[i].style.visibility=r[i];return a.reverse(),a}function textFieldOnReturn(e,t){e.addEventListener("keyup",(function(e){13===e.keyCode&&(e.preventDefault(),t())}))}function textFieldOnChange(e,t){e.addEventListener("keyup",(function(n){clearTimeout(e.searchTimeout),13===n.keyCode?(n.preventDefault(),t()):e.searchTimeout=setTimeout((function(){t()}),650)}))}function UUID(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function UNIQUEID(){return"bxxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)}))}function stripHtml(e){print(e);let t=(new DOMParser).parseFromString(e,"text/html");return print(t.body.textContent),t.body.textContent||""}function unstripHtml(e){return e.replace("&lt;","<")}function clone(e){return JSON.parse(JSON.stringify(e))}function isSmallScreen(){return window.innerWidth<window.innerHeight||window.innerWidth<900}function sendIfModified(e,t,n,a){var r=new XMLHttpRequest;r.onreadystatechange=function(){4==this.readyState&&(503==this.status?window.location.href="/":(200!=this.status&&(null!=this.responseText&&this.responseText.length>0||this.statusText),null!=a&&a(this)))},r.open("POST","/");let i=sessionStorage.getItem("Session-Id");null!=i&&r.setRequestHeader("Session-Id",i),r.setRequestHeader("Flynn-Tag","hotload"),r.setRequestHeader("Pragma","no-cache"),r.setRequestHeader("Expires","-1"),r.setRequestHeader("Cache-Control","no-cache"),null!=t&&r.setRequestHeader("If-Modified-Since",t),e instanceof FormData?r.send(e):(r.setRequestHeader("Content-Type","application/json;charset=UTF-8"),r.send(JSON.stringify(e)))}function send(e,t){return sendIfModified(e,void 0,!1,t)}function endSession(e){send({endUserSession:!0},(function(){e()}))}let globalTimers=[];function initTimers(){setInterval(callTimers,250)}function callTimers(){for(let e,t=null!=globalTimers?globalTimers:[],n=0;e=t[n],n<t.length;n++)e()}function addTimer(e){globalTimers.push(e)}function clearTimer(e){removeOne(globalTimers,e)}function clearAllTimer(){globalTimers=[]}function InitFigurehead(){initTimers(),function e(){Laba.update(),window.requestAnimationFrame(e)}()}let endeavour={send:function(e,t){send(e,(function(e){let n=e.getResponseHeader("Service-Response");if(null!=n){let a=JSON.parse(n);t(e,a)}else t(e,void 0)}))},new:function(e){endeavour.send({service:"EndeavourService",command:"new"},e)},join:function(e,t){endeavour.send({service:"EndeavourService",command:"join",documentUUID:e},t)},leave:function(e,t){endeavour.send({service:"EndeavourService",command:"leave",documentUUID:e},t)}};

"""###
private let compressedScriptCombinedJs = Data(base64Encoded:"H4sIAAAAAAACA+09a3fbtpLf91fIvL0uaYE0Sdl5SGZ80iQ9zZ6kSZukN6nqbSkRktjwoZKQbdXWf98ZACTBh2w5aXt7dm9aUyQIDOaNATgEZ6tkysI06YVJyL4OaRT8K2SLJ+kqYToljCTGFbVWy8BnlBfSzJvJJrpxde5nPd+j1rkfragV0WTOFiNmhUlCs7f0knm/fHHlb3rprPfFVbL5hTArZ+uIWtM0SjPPP/GSU+1iETKqDTWApZvmbGHSLEszM6OBoW0ItdIkTJYr5jXQ4HemCz+Z085bH+l6tey4U7vWjc3s/zsDOAkRzVj+3YquqDc+G5U8AehBRB9XdyXJVOWB43mi/ZM0YX4IlFth/mpJk/19vfuGt+eQF/7Et6Z+MqVRs5YhbvpJGAOmzbtEm9kaOU/DoGcTXcGj2ZfgdBDmy8hfe1qSJlTbGIaxIaxCnwmCEi9Ip6uYJsyaU/Ysonj61fp5ABVGySqK9jwkxy5I5cyQ8t7fB7bUUU6ItodYVuiBKqEiCZwWNJwvmKc7JjMOqOVP2cqPvuGFfW15qZGiYhwmotirN90YNcozGqfn9OssjV/7GSCuJwbpEB0nfmTvddBwWpF2Byna5BaezyIK1HyOqJ1OUSMlpAPj6SKMAuBAKZmK/8bVLM10IWtgLM1zf04J2u5kxVia5CSD86kfRRN/+jEnoffu2+ffvXv2/CkIN/U0jeRIcOT5ErjpjKJHnj2KTM8RSrTy/HF0NspP9Rw1PO17v5wE4XkvDDzti6tw8xVLvriKNlqPc8nTJJuGyKXR72aYBPRy6I7w0gzCjHLMh1l6Mfp1lbNwtjanQCnIdzilaLwjPwrniQneI86LohnUMPPwdzp0QCvE5cyPw2g9/PL7dJKy9MvRJM0CCg7GD8JVPrStwTFWFZo1dC0Xr0DzzEaJf9koWfpBECZzk6XLoa0WRHTGAO6xWgZdszSu18s4NFkx9rM5dMqBWUdKiYSmFhXAaoUFNF5mXtDJx5ABuNV0YaJY0xUbog8ob61yYEJOI+CzvPFxweKoozxOf+8qzduFrYLRdJXlaTZcpiGXD3f8w9LVz7jzN/426AqNgpLZMGcZZdMFV8dhz4H//BVLR2gd8wxGj2CYzSe+fu8ecY7uExf+HMs2RlovTeIUAAfpReJpbBHm0itULb0vedOjB8Sxodn9h8QxviwbAuU3t1O7VNrBaHeXZo+6bPMHHMe7DfTvIqKbrc7ZzeZ4tYswYIuhY9v/LIyfnzcEvrvv0R59cbXanBwCXx+J4y/G8D9e8D9e8P+eFxQE3NEBiqD/Tr5PbbKb27uhxX883l/g8TYYZoYJ0MC+AU60Qtq6M+xmfN01ccyVYbc0G2k1k/TSzBc+qNuwh4T3hCvpuZa8QgC9slXOAlndaDpZ0J1VnNT5XfdfnOPubhwv/aXg+kNgNPpTKYOjhn/l3aRLfxqy9dC+gwxg5pPNIiB+EQYBTUZSzbv42pBzh5nv3q3qqFtuustJH7edNJbcgm5bOoxeMpMjVI52fyBZimNzj49J8ecYN46pL3wcURWWOE2WOG2WOC2G8JLm2DCJQPUNbmpJzdR6u8pZsfpult4kS2c3WTp1ZXc5HEUSisNIGyESzCmzrXPKeOvCRNjXwIVr/cgYxeW81ctgBkpiCwzx2TnUfBHmIHCa6ZocK2prEsaVWNqAUWOV4cLBWyCJshLa/v62OzAnZnqIKwqbjP62ojl7zKfwAPbrzI+prjcWyeh2OoxRfQkE0Elns5wycVlfIaC4suLctrLCPn9VhbaAarh6hP/r6vpJvghnTDcMY0jV1URepVhAlFze37eR18XahI7Fn7J2ZhDRkkEl5o21Vx+1s6IMGybeWKyZQKmK6nKVL/QrufQxpEQufAwZKZc9hsmmc+mosU76FW9ZkBfO9EKPBG0GjoERZT1GfE/eOqXD8RnJQLmZ548zOD0pVlJGWb9vsDvqLBCa6Bj3oEhGNMppj34OiIrANyyDQeyrVRgFuEAq1Xd8NuJRlkBZXf8s1pWYZ5ME6EtOypXgBAnre3ScnJW0UrbKkh7bEBG0UfaiARHUGXmHy1S/Qrysa5ph5atJztHSbVD3kY74GGP7zEskHBFxKEBQMAjGV8Ao7fwGSELHDkCDH7d+kxmyhwAiMkY/twe1NOk7BXB/CaodVMABNKgxLmQaknGPbNBsOi5YC7jW274AG6m1R63kECSD8mfxkq1BlfHOnp6UcA1DyGRUg74RKqUWlS1OtZ+yn8D1JkNxIhGZRtSvPR1AXmxq3Xu1VVuuCbZX2o2sy1Khgh2VK05vRkLnVLWWlfD81IfDnufrCb2QGm2cil+4MaRD8GagrV2tC2clfMgeoLcBM1ZrIgPhBOYaCYhyNWVpZhhsAXP03jN8dqFr7xJ6uYRBlga9dPIrnPTYeklBPwTSBSI1CBY4+OlCPyx6+inv6z9d9I1DY1QSxoxTBmo01CAQpjMQeaBtKsulfk5RDyB2qOix+84Brdd5nny38gO1DoE6B7Rv1+u9WrFWRRNr6tR0jWbt50lXfZ0eetaxceKcWseij6EJZxDcSDCm0wHpyWoSTtsIdqLYVZeDx+pON5rtNk08OaaIKCDpuQYv6KIZCMaBro3pNnY2apsVsgfUdLZytdGsjW7F2grjg245fbcKky04b8G6Xb9CejuX2+260O7g9FZuvwHtbrLvpc8WYEg5wAa0+NXr54euYfSdDlpaECSAHNxKC0AXUW0UEPcSCdn8AGB1q/azy2XahcAyvdBd4tgHiAa0NDqQ72irO6bS3IT22HM36q3mNXE0sRA4DOHEJEii2+oI7xst0w2zaUvDBYt/AyV2UG26OINWWW+KHVfyqRp3W3Sz24q2SkBNDIZc5UjXfa7TRgvFr1IoUOVPT44OHefUcbkJHTr3hvTkAZY8tOz7XMfNh9ZDUOeBdQS3rIenR4Pje4eDe7y+OTg+OnIPnQf2MZrRPfuewy9gtmY9EPYLsy0X79nWfbdJdwsbwL2GJ1wbHczqoMI65iapgoVujaEsrBq5wk1Zx3W4bxb+RwWiXhrVwHKOgJJ7fev+g2MDZGEcCLTEIGgts5SlODpaEEjCENgMLT9CxA0xFkYGBCZhfA6VGz5EUhmFKS9gpF1p/Y99baNV98cfz8pR098QjgwuJ/lJ3jXm04PC6oH5snpA5xmlndWhEohaNhGByM8wg8CJWvQ2jGmWY7g8jfw87/2MpbzwSmQelBG1vqQZJxm4aiVgVYYp1zHB2WML45BH5xZEd3jZvDuCMES973n1ChgvwjSa0EeeU5yL4IbXS5N3HB+BDhOFPifVAoGCaEbqNKs2wsuYsgAh0DgP6QVBd29sADPs1SiC/Qo0zJlwAmc6EtsoTZc8F+NUV2vZZM+WnZT0eC1+kRr59dp9hw4OROC+yvjEXDxIL1G1IhDMkzSOQz4d/8HPcgiOh3WsHjkSr7IEfNLfA1FdZD28gtGooXy8t4asof0S5y/7+42CSnbGTv2O2sK8ucVGiXHFjJn4JCMhSUluXJVtPUrqjPZyldEeIzUeeRlpEOKldaX0wj9aLG25NxgvVhgE93llafEwjmwUb/CYg7jayhfJlRTw9eHmkwXMqiT5MAeNvaSY8p5Dn9TzxWXmX/BnGQVnhA0XXBBX3/pxySfJV2q9FmwRWOVjdibu/xzQfJqFE8yueipPW3VwMQTuP4cf5Z4tjVtiKE1olqWxwNAu5nni0gFlbtRw6jXsmjbzXqUi83O5iJHRnDI5P2tWL7wcTgcVIehS61ReV5yu8bnOZZWrTQ6XI0+DKFad18ljxRko1Ua03XM2Ul1bU1NFeuiZFaVsIF721tfV7sz6TeNAQR86k94D1HtTaEA3CqWCFFj8XNVXgKiaf8XX8DinK5ga0WCOfX2tXcvfPflLxS/FAIB3oKjZJsy/XcUTqsLpy3am/LXlryN/Xfk7kL9H8vdY/t6Tv/fl7wP5+1D+Wvi7KUfxYt2L49fwBEbjekzPCmdgbJbgF2m5XlysBeAybpWiZRMf/jL4C6XAo+gZF1E+HpyRtFn41Ro1D29h7EEiXEQ/4XU+vvQvX4dLmo+ift+4ysfRGc9xlF2toOaqqinZO1pBXaw6Xp15YiGEP9gbJSesWMmr0I0x3WvqaT2tfh/vzTw2Ts7KWEVRgJlhQCmX9swAELZYxcSya17m9/t8wRSL0aZBUfag+GrqzUjS748mGfU/buw9L8PVYlHZIPnYPxtnZy1L5wGkFmgEBy1iufeE3n98Smf+KmJPCy+PDphIaBvopkn3/v6epEQqINJnVKUlfbx8ZCCmyIiFEBliJLvk5oecUYF3wBaMDIDJI67jWHgKYIdc0/EK6A8wOw/XW8kCWFZIZomSmXuO3RBcUyiyuxnQoc8eeWA6+/uzEw9UHwqWp/qi7+kzE4qNwzmZHwBAY7iA48GiL8sNwu1jhvUBFaNcdlTlzSWGq8KbAOotDjyYSWCwCJqz501RHaZdxm7cKNMpSDQmCyG4DLhdqhE6kKng3sRbjCaPPHt/PzlpmE71QKJtapPtpjY5A98mvWK+kc9nMBqTY3llHpmYvEjoW62/6Kk+HlsBWHRX+VMw8q7yF2TVWR6RGLzJFP5mMLwuUDEC0JSg6SUC0KFyAA3HwdnYPjOuYuBrpVTdljMHcPO2K5kDQAXaHLVVnsmBa89L9/ebRfn1NWhSUVoNV6Re0fMi1NldKq5Q59BMumobo2nfW6IywtQkRg4sjFLduBMHITWeuonKzFDcNthZplJfPuYKgY1gc9fX8sQS0UoGHaPVlswFtz/yb4LhFzD8M6sKEYyRj1A2Bq6YgElgMDkTz4W4HgrZ3AB2XoCdq6ih7Ea3seGTyFdRT1TUDwAAdvRm6kdU0rEp6RC2LFOiz73YdEbn+MT43DSNqy2Kyd3vJSj9D+hCK27cqKnnpaaetzX1vFNTz9sKeN7S1MtdKqKm/oCa2lXbGPFHi945p+vCm8h5+gU0uvD84kmouKwljfOGsfcDeIElGMEleIGL0UStAxod36z2SaH2ibGbyrJCZfmJolt+ofZ3an+Tyi9qKv+5qN3Ghk/qYyv6TbVHWjabjVDHyelEN4bi3N/f95VJ+6Y17eHP0xDtzE9y7Ox9MfmhI8bvfI8tihm6Kn7WaIgztXrRh3bRj2XR9ynjBve+VfKhVVK14hSDdcqphUg6wDkFv/s4Wi58jw+aX0epD3M9mZUgc6Ug0IDwxf9WrW40WvPHrB2LEw3NLxBYpnlYzK7KC3xSrTf50+KOgW84IT1KdSFR5RwrZZINXoMrcMvnOKvk1FlTrB++9CF2uLTCgCYsxCe7o7IsBu8XLqM1KKosYYhixNfqbqOhJV9g8Q2QOSX0va6useoNfTB2AfHhJhAfdgLx400gfrwFBJfbNpnV5CccaeJpYM05PuYNz6l+bNvLS6MXc2CDQL+yN+TKgT8X/gbwdwR/x/B3D/7uw98D+HuIdXhFrOlgVQfrOljZOd4YmlwV16kV2zaBo8OPLj8O+NF2eDk/uvw44Efb5eX86PLjgB/tAS/nR5cfBwNjVNiVyGwtpY+rTfLOy/T3ruI47yp91VXIOsqkHasKD36Pth2VXoxstHARRdaNYrBN16fctS4JbToz5e5a3q0cFC2tVN4SnopKCy/ACR9Dhd0aG+6M68ucJJJLeoWrJi00WRu3pFn0o+c3cHzvZY2SD17YoiOtoZ/X0I7kVWvVtko4k7OZraOLnLOWtOHrn9NoFdBc18YwMVSmQdUjmzFM5nuY2LOMQqZrZxq4cRhHw5MiFXAU4moFtku9bByejVI1EUZMydQ5V8qxJL6MDUXI2GvXY/V6G/lenvJ+HNtlPYediVVrTBTZvhDfblUtqpXoqJHELTPEbMsMMdwyQ0y3zBDzLTPECAblFfzFHl/P8Sd5Gq0Y1SBYtEez5kxxps4U/fFMzBQjZaa42DJTbEw8i/g7KONvDi3A+FuelcF2BuFPoyiE+HtRNFHD6npFD2N3Pd6lYt5dEXmSURhFwd+DYo9WfW8hZ4yR0NVlmSWli9i2wbhmfOjjbGgG8aE8scol1ATgI4NH8SPnNJFJXrrWg2GlB1ZEAYlk3oMBpsdAt3LSK0eKKYkNY4hP2GJwkdtaQmV6TjO1HQyPyz2FgFO90bqqy9G1z9RFb/DOVTafXkExXf6q6kolIkxy5icsWlsahLVVOeay855yOk2TILfKDldyta4MkTHjVOnlkYu0butf6eLCDxkSv3s3wpMUKi2mjhGfK16p4iaLG2afEzCoc8WguG7sYAXz0grmbSuYd1rBvK3c85YVTHapmHdXREJUKxCz6/kNJCnqfomwUN35iRw0+MMCgxP+SVBqRsOhTO5qNOdkIo1mciejOb+T0Vze0WgWn2c0iy6j2dkWOlqTed85iWoMegXDZ28qn8HCeEsToBhmpeqzICV4YNfX+HSwSJSWT26CtJek0Fsy10ZiJalK25SJyHyxuhFZyO0nbg4r8AlCha8c8no+0JuFNMetKfxiqM17PkMSejnIhquI9VOiVWtzIkLxOyIUvxWhVF2WI3nvH8jnizCKKp3I+k6xVF4PDCCeUf0W4oGL28DZKrBphxJlpmjlGAUyIj9atwFkkV6r19OqHQPuvIPusid+jinvUFXkPOsOcfhl1XKT0TnmmGdidT8skuExUGyu3o/pWfH4uvGomZ4Vz7KbD5jhjl9LHJBgq1V4b1xlu5IqqZUoeauklrNClMxSoqaOknpWKFHyOomatknq6ZhEyaUkaqIkqec/kipzkSg5iKSWUEiq3ECi5PqRWuoeqRLsiJIxR2o5cERN4SK11C3SyP8iZd6WfJzffMbhjTWs0os4l8G0+FW6Yr3fgKHFNUTL9cvDjhpTZK0KoVYg2zTKEEbGGt1WBVVHahlcA9PrjZSCslGtrAdEU3HJm1SXZYt6UY+CPNRO1Gu43VE0BeHUGKBcF/TXinoTLiW1Tb1EtqoX5ihPTQq0+bDRE8/5rJfPv/35h8cv3j0jTWP1rjZdploWNwy1LC9nBd6RTZojd1XWiI086/g+aYwynsNXV2j341LCtkRZcg7a9EraC/XVF1bmMbAqX8YTi43ltYkpTbW0jSpPo0r/qL8sJeZxzTK+UQvZhln0t8UsUDFLqtyPBmbKNcPhoUIsKRGr6pDk8xF72kDsRozUR2oQBSQ8M0ZuZqRnXmYtIZgL01X+JpxE+H7ICDMOqhH0ZnIO/D+CoMs764AtFliKxKqaNlQ6oCgGUt18HjBsNOyoQ7qUy+jWrvZqVpsLFdK0DGpw2aSHePAA9LK3TNWQXOnWGDYasfTWJjexff3vYPuHHdj+4TPY/uHT2L6+O9vXn8j23/8dbP9xB7b/+Bls//HT2P773dn++yey/eTObJc8Eq8h/wvf6L5BDh3Oo/8n+qKO++af66EgFONi42+6c0msIGDaVXj4Fv2tjW4S36O/XHzmXyu+/l8jvp0E0ZTebjK/SXz/83niE2/q30l+H/p/4pjUcd/8c0eqQn4TGqUXdxbgavlZ0jv/66Vn/rXS6/810vMneHVX6eEeUp8lv/zO8nN2CDkeWcen9tDpjhq2yqRIJLhjpCFmxTvynD+aLpkOnPunwjTHtg+2cFu0E4HGTU1u4nX2h4Z3JdvKB9m3urUq02N4K7BbIOzq06qn7DsKSCSqVGbB97SC0G6yRtbfbhay/W7tbpLW8s+V1vudpfX+dmm9vwXCXaX1/vOkdfmJ0rr8dGld/LnS+rCztD7cLq0Pt0C4q7Q+fJ601p8orfWnS2v2Nxp1eJ7P3UcdkR60I+NnflBNbf/JhxGnYxipHiGLa4lSTQYc1E7j0IZv3Y4LxNV7IfKla5HRd3XDm6ckIisSkymZkQUJyFI+X4ptu3gRNbad4rFVbLvFg6rYHhQvXMaOXbxrGTtO8aJl7LjFG5axMyheYo1d24uKU8dbFaeuFxenA28qTwe2NytOHW9RnLpeUJwOvOUmR+OY9qr0z3KZFpghGKA7xJb/dZ4ZBZAqO1TqwDZQVAJgElTSAiWyKLeCoWXvrDxLOjAqskqp2GOJedUmHQZJvGrPj+qRZxfZCTGZ7G17Lx8+rZdE4QMeeU/be/nxU3vpoqCjlzRji1RV8y72u4c6M6kh8NVZn+8xIArglm8mBr/h9xOjvIQCuBeamQF3wn5myItOBNygehDc6t6q42g6SutZtkJbjW+l4CArUa4TACTgPY51kwK7jrrpHoRYt6QDULFLVNSs3pIYlFzmJQfMB7Ed8FR0axkeDu7ZmLloZoXo4qOfS1LCA0Yy+AuBGARSdKDkHpffX2hnc5cPIrhTwiN4QDj2ecovnjvi3MVzV5wP8HyAj/nRPfF04aqVo7RylFaO0srlrVyllau0cpVWrtJqwFsNlFYDpdVAaTVQWoGHrehyFLochS5HocvhdDkKXY5Cl6PQ5Sh08Vauo9DlKHQ5Cl2OQhdvNXAUuhyFLkehy1Ho4q1guKjochW6XIUuV6HL5XS5Cl2uQper0OUqdPFWrqvQ5Sp0uQpdrkIXbzVwFbpchS5XoctV6OKtYOyr6BoodA0UugYKXQNO10Cha6DQNVDoGih08VbuQKFroNA1UOgaKHTxVoOBQtdAoWug0DVQ6IJWygZqy0xuWIWRQxpBJJTiK/FVhQXYp7o1ZuPrKmW9fJFedNbjXwRR4Pn54kka1LbiKZKXNANCy2A1VTcT5Q5D7rBDPZ2enBwbJoXgfbrwMwT0mOm2YexTfK1IwTtNvscP5Tzhn8tR3A762VHXvpH8kzvNXSM9BxwrMJiJzVD5R38MnozIE78zz8eguAuc+E5PE971NbarbT6Z+YH7lM5re/PozgO72G1HqRrQuft9bbc5Wu3eBU1qUJPAdqoQSb4lkgRprDeqvQnnyZaKuEeS6QydeoM0xg/PPM4yf62iMuZNZ1EKsWcNykG5S+hZBQjY+QS/3aIKGDSh9S0edRtSTOh6rHykCdUGlIVHISpRPDtdVGwoGa+NOwQ1a8uEsmJsohb/KsGrGX4NqBiWHpkO7o8r4SSdcB5HUdcrouX+oAbuDOp5HjutARr2+0nRTxfMJ/IzN0XWPmjwLMxywUIAaomakqPKvRZblG8GcWtd8nPJcySvVlCHq6pimPuTiD4Nz1WjL95ssY7LrXflBwC4deQtr0GTG6A424DgHs+aShjPheSbr8u9gfnnuL55+/IFTGiyVQIcfDPNwiXLnyc1MpRt23nLYhvWxmeFRlSmEz4OfvVxY2cErWsTiumxMInTSC35Ihn5J20Y+PJjC5ey1tiv9u9SShPFZJqNg/DcuNJwd/DDX/1zP+c3NM+Dcgu3FwNpgsPCahU/RPKyqJp73Ib5JJXXqowv/2r91ucJu7hQyuEagkLk0M9+lsldfiWkU/mLO/7+HAaX+N49V01+9LDBGMvF3RO8LtiCBWX+N68ukW9Rpt6+vua0iYKKOnVgo4ytn/IZXi2qlkUwFX+R4swNr2WSp0YT890bTYES0WzZmNqhd4Ygu88OkqoeTMLjVsUTsHI2pI+85DQZ0kZlcM7qZnSefWpjVefUUavyF2N+oNP6y64yifjqcmiT9dAuNoYtx1GiFaoEVdQXSfF1FWhRK3JwVwfVrhm+H/Tmt9rIy6xLk1qXxkF51oezNZyteZk4U+z6EibYU/Y2ZBH3OC/97CM+2dDLzdcO/9HXrQPjkPCPc/F9YBm+pKS9w9lARANtVNuAB7duLrKNPRdfEPASwJ3g22lFMjQjGm7LMfYJVcwmzN/EPrcbMNVqoLsAD59eSN3hD61O3KMDGr9NX1+KfCdX3dw7KiyDO9A0TFjDzwPufLvr8dlIVz4uR0WzeisDiNnzqkrFiexjZPhiYy2Yy2XyTHrC8zAPJ2GErwGTdpmniU8iaDclcGPmdrslf+Os2D/Q4kn/mBNN/IoJaI/8e4mvku9lQCa8bTv64Z8ibAQ/EBXjq3RwC8M2/uYi5qNBO5nZyLeYN+rRkdKnGsrt1CeYIt+gGRMt0xW+UJrD1XQhrw3CMUoKjPA9hk6Eho2GXk5ZAVPd9Z7hB/fIvWO7TsK7d/hFuWLLpkv5z+SHIzysi8vin1Zq9OH4cn12OK8zUhiQc++gFmVd21J8mGMHjAbXM9hn1w+MKondudfArPzeXYHdREUDkVtf1v/9Vahhkv5SjMvGVTFJkdtA8B2un756+RrdWGaItwfRwMoXB8XQgd+lKT2hnOkwa5IGawvvPxGfxsBl6GbZ9bWmxBerpIZNOUiX72DsR2wETvdEHTmmUVrbNfe/37z6VmCq81PxFkI4W/PtI+/irHh6y0nbfV1ft2s9tJWdY3OIVJ7PXqZBOAupsmolXlVFpr5/+eIbxpbfiw88jDIrTTLqB2tcxaHyy6OKwh/JXe94nTdYB6z6GObM5c6CbJWfSqwiGG35a8eLjM487VAb6q5t76lV5ftOewXUfAmTUopfVa3euC2LyldPYE5VgcA7xe4B5b4R/BOgGW55Bxr4+tWbtyCsQ02oUwjWnOf8rdM08+d8BvKc0VjX3ohy83mgFV8EDff3M3x7STLoG6AbPY9Sk4TosttVvo7WSWJCTAVdL1IGY2+gddd8DVjEPlRLUnPqTxd0S71nl8sQ+AEVTWdLlSfY3ESdztKoDlHyuZue5zOz0BLzTchT7XE3f/k+1pSms97XaRZD5OSfYvsE5wZDvRMFYVDmW9wMnmj+Euc8XA8Of83TZISzeGjlvXv7tflAkgHg2iZi1PW4NrdrKbbcLWfPIeoEEmpJSaFdcihXcHgHTkSWD/fsTe2zo+IbqhtUlHmU1ja7rX0eQxTrCJU9x6kKD07BkOVr0e6xOjmvbshN9Xj6P2EyplZ7OlUvMLrG+STlm5kRZYMz3E+o/jWSIJCbuBhXKggRTdCao5JDpNxYsJgNq61Iq8FjSYFeB4+fPygrPuffV56vMroAbcAdRxROkUoscId/8aXYLpBIj9H9nRlARRcSAdlR/zxdZR4X5rC+ZiS1pDY8FdO7OeqpcCWVDWfnMBs3i3KN7zYsY8/isxeKE0+MEcZyfvHafal1XGEIeNNh7csyBa5CvwE73t1Qe1bckAhoZJrGMQycQw1g4OegARp+AqJB3qcARDAaKYJNjEtgroEmQkCk5/QP6IHD6exiM/qv/wUo+iLZenwAAA==")!

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
        --fh-fclear: rgba(255,255,255,0);
        --fh-fwhite: rgba(255,255,255,1);
        --fh-fdarkgrey: rgba(100,100,100,1);
        --fh-fgrey: rgba(200,200,200,1);
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
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --fh-fclear: rgba(0,0,0,0);
            --fh-fwhite: rgba(0,0,0,1);
            --fh-fdarkgrey: rgba(155,155,155,1);
            --fh-fgrey: rgba(55,55,55,1);
            --fh-fblack: rgba(172,171,168,1);
            --fh-fred: rgba(255, 0, 0, 1);
            --fh-fgreen: rgba(0, 255, 0, 1);
            --fh-fblue: rgba(0, 0, 255, 1);
            --fh-fcyan: rgba(0, 255, 255, 1);
            --fh-fyellow: rgba(255, 255, 0, 1);
        
            --fh-clear: rgba(0,0,0,0);
            --fh-white: rgba(0,0,0,1);
            --fh-darkgrey: rgba(155,155,155,1);
            --fh-grey: rgba(55,55,55,1);
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
            --fh-dblack: rgba(172,171,168,1);
            --fh-dred: rgba(255, 0, 0, 0.4);
            --fh-dgreen: rgba(0, 255, 0, 0.4);
            --fh-dblue: rgba(0, 0, 255, 0.4);
            --fh-dcyan: rgba(0, 255, 255, 0.4);
            --fh-dyellow: rgba(255, 255, 0, 0.4);
        
            --fh-error-red: rgba(208,116,112,1);
            
            --fh-main-background: rgba(4,2,1,1);
            
            --fh-std-shadow: rgba(255,255,255,0.3);
            
            --fh-btn-background: rgba(66,147,247,1);
            --fh-btn-highlight: rgba(48,107,179,1);
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
            background:var(--fh-main-background);
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
                            
            let html = `<div id="document${documentUUID}" style="display:flex;flex-direction:column;"><div style="display:flex;flex-direction:row;justify-content:space-between;margin-top:1rem;margin-left:1rem;margin-bottom:0rem;margin-right:1rem;"><div id="header${documentUUID}" style="display:flex;font-size:1rem;font-family:'Lato';color:var(--fh-fblack);justify-content:flex-start;align-items:flex-end;">Creating new document...</div> <div style="display:flex;justify-content:space-around;align-items:flex-end;width:2rem;height:2rem;min-width:2rem;min-height:2rem;max-width:2rem;max-height:2rem;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;;cursor:pointer;" onclick="leaveDocument('${documentUUID}')" ><img style="display:flex;width:1rem;height:1rem;min-width:1rem;min-height:1rem;max-width:1rem;max-height:1rem;" draggable="false" src="public/close.svg" /></div></div> <div style="display:flex;flex-direction:column;flex: 1 1 auto;align-items:stretch;min-height:10rem;box-shadow: 0rem 0.5rem 2.0rem 0.1rem var(--fh-std-shadow);margin-top:0.5rem;margin-left:1rem;margin-bottom:1rem;margin-right:1rem;background:rgba(255,255,255,1);"><div id="editor${documentUUID}" style="display:flex;flex: 1 1 auto;width:100%;overflow:hidden;"></div></div></div>`
            insertHtml(documents, html);
            
            let documentHeader = document.getElementById(headerID);
            documentHeader.innerText = `Document ${documentUUID}`;
            
            let documentStatus = function(status, isError) {
                let ignoreStatuses = [
                    //"Version mismatch"
                ];
                
                if (isError) {
                    for (let _arr = (ignoreStatuses != undefined ? ignoreStatuses : []), _idx = 0, ignoreStatus = undefined; ignoreStatus = _arr[_idx], _idx < _arr.length; _idx++) {
                        if (status.includes(ignoreStatus)) {
                            status = undefined;
                        }
                    }
                }
                
                if (status != undefined && documentHeader.innerText != status) {
                    print(status);
                    documentHeader.innerText = status;
                    
                    if (isError) {
                        documentHeader.style.color = `rgba(214,62,87,1)`;
                    } else {
                        documentHeader.style.color = `rgba(83,84,87,1)`;
                    }
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
            ask("What document would you like to join?",
                "enter document uuid here",
                ["Cancel", "Join"],
                [undefined, function(uuid) {
                    joinDocument(uuid);
                }]);
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
private let compressedShellHtml = Data(base64Encoded:"H4sIAAAAAAACA+08a3PjtrXf91cgvE1XakiKpN6S5TRx1s3mJr2dOklnut0mEAlJiPlQ+bDk7Pi/33NAUgIp0Ka8O502s/ZKBIGDg4PzxsN78YkXuen9lpFNGviX5KJ8MOrBI2ApJe6GxglLF1qWroyJVlaHNGALjW63PjOCaMnhsWNLAyoMl27p0mcacaMwZSF0vWdJreMdZ7ttFKcSUJaw2Ehc6mPnRRjpO+6lm4XH7rgLyPFF5yFPOfUFGFvYpqWXiIwVTxdudMfi2khu5EeId8MCmSSPxrfE5+tNivApT312+Rfu0jiKwu9ZsPVpyi56eT258Hl4S2LmL7SAhnzFEiB8E7PVQutts6XP3V5Zb/6SRKFW6ZIzKY0yd2NwIEAjCf+VJQvNnjp7+NRRIQxUm9tw3RLR0Hb28FEhgupTRFv4jqhXwhfgK+BN0oOJR+YuWq0AHQXcWKsRVJK83Cva3DhKkijmax62xh1Hy+g52JP0HsTwgsDPHxHKWFGXkXeiAn+KuoD79zPy8luYwct5tVFgmJEwigPq19p2DNVgRgaWVWvxeAKKADiTHd0e25LYnZEs9jsNjOtCbxgn7bwUry+7x65ZCELxmBHTcA30/PCZBT+GZV1f6/hi9+38OXQM+OqLF+fLLw34uspfrkb586sviqeodxCNY42u85fxIH9+kTfajpM/p3bxFJgdaCieQ3xev8rJuL6+/ion+aEtz/8qJPscrg/fj+uySv2W+H7Ry5X+adNiocfoXZTFBS+CKIx+Al0WPPlwVqaSN/kOxjoIvVnkTWbWLO66sB+dZFXuR7H/twld/zC8X0a+p+T88INxfvgb47xkbpIVzCAZSCWXZxirjbFyfUbjGYnXS9pxhkO9/FiSu8khdxueMgWkfQKJ2cg6ZvcFsG1Z+uFzAiwBAj/08nMKuPSpe1tATvr6ZKBPxgqwmHkSkcQS/5TDsrAABIASVjVsxo5wJegpnHtP6/gaIO+Z70c7mUjV6NVOrcXUWkrnCKmtjNqJqJ2E2gqopXxai+c50vEaxWMOTvjeJCEV7CNCUoE3yEkFqhSVClAprYbBVQJTD66SmQqySWwq2GbJVaGr3Vgcw4pKmqU10W17BB9Hb5Z4QHloLIGF6zjKwiOHbBBlHz6DR/omqWckG+odaAUJ4a/Z3GWZKkYbAZGDse4MFDaGHTYQJ/08Vgr4AUzMAtjx9ACfZ8R5oA6YxynpQFq2YnFiyCvNGUFF7ErBox5M1AGlmJhEnDqc5HC2Eq5uAujLyo+ygwQMMPk/NaRsA/YYxD22dXs0aYB+0m2dFVzOCTDnBZlnBxplsHlEhC0leK4AW8vvLPG1l945wjtDdmeJ7rmS81qKzmsru3OF57WWnneW+NqEoTND0Xnh6NyQ9B5h6ezQpO6tDlEDHfq26H0SpKqpSv9JBOeErHPD1jF0PbxoEbwENoheZbiTlkduzLfp5QFpr0f+yv6VceA5Wd6TcguVwAJ1E0W3JNuShMV3uLXLPUaom0Yx2fF0Q3C/F8GQ6yl8SJLSFCFwUwI3akPmpjwKk8NYfEU6CUsSqLwBNHTNzDVLX6cs6Gg3eb3x2tO6ZLGAFajHVjxkXrcWc32WkgLJDz+8/oosiBe5WcDC1HSBYM5MWM+6m07v5tXNzev/+/NPCLXovPnC+LtlTP9hvP1Dd/55ryYKiTKB9BOJAPL738sDmj4L1zD9S3BMNdLE8rs6v0QxP11G98Z+W6PloSZwkF0us1J4uMRfaHkZ5hwskUrzl0S7lEGPy2D82dg1WvMNB/4rmzkxC+byDsXpZuCRpI3TiMc2h2dh6jdjOgfPMvLua5gkI7yjcUflG2o8x3OHFfgs434GHIx8f36o2c823PNYOK8Z744tb3lqpGyfU21Q75csSXHrLGQqQv8wW4GiJjVaoyz1QX7qbkez7RVHOjhbeITRQdAevyMCaqFto4Sjxc1WfM+8ebk9tPLZfo608dW9URygzFz4YvGcgqcIDYiMQVJWiZOaGSy4Pp1v8o0nUd5Sz+PhemZt9/OAxmseimLJp5JLeFCxsS+/3/CE0O2WxLlzScg39I4W+gtOY8kIC/GgyDNhbjbOECaCD/XUKnPBL8MDrMK/zMD1ZUE4D0DAMsEINSM2/NIsjSozTdKYgY8AYi9osRm7SdNtMuv11uDasiWaVe9/eZref0fd3qtyC00jrk+TZKHlUMDMOGRQS2NODZ8ucZP3R852JAFglxHwo3/i6dfZEgZK7tYkPxHTJpZGckrzMp6BfRntF5pFLAiV4qOVM19x35/9z7A/HAzHcyLc/EzkMnNykDehywSYgHVptJ0Raw5mEXssFsU4Dy3WvCA0l9RCS+OMAWFbCt7MW2jfQU5EvrVtyF7sIRT6VlEYQPwcOORboEpH6kTBIn9Hf4OdJRS2MzH7ELympkWubLtvTvTp1BwT24YafTI1R3LxynYcLDsI4VjmUB9PEOJYvEJoRx8DGFT3zYE+Hpl9uQg4xjDkxDKnUD2EjpOxgDgUxShTfTpG1H3LhIBs2QjdHwAS2+qbjkaQywvNzeIYjOAKmXwQQBrTMMFtUiPfaZ8hlu2e2NYI9P+gEhFERoPGgYor9tAUzMy5MgBq8AVU056YY0xwzKHgy0TUD5D5fWwAOpEH/RHSD4yAkadYnAAMiAQ4M8251EdOTyaCS2Nk3kBAYO1wIkYdTKB62Mfq4QCoGdqIbgjCwSJCjCDH0QdThBgBT3ToDQwb28CkAazUAeJYtoH3tg4UAN0gKBhlBOiu7EkfqodCiMB7Rx/Z5oTYUxCOPsKJXdnTAdAxQv2wQSJjfQxDEccCpPoYJXTlCK0BeUI1MAY3akBYUhEgQGH0KQwFHQVrRoDOsWAALCIOKEPKZzkwpAMCxv2jsaBEqKeNdAOxNgoCNBZ0YSQaHDGh4VgIZSDmDC9TISEAgklCgyNUbeiIMhIEFoIn2SgmRNsXcuyPUamhAfM/oW7wPRHlCZiOUuFkTUJHf1SlHngP+KaXRVw3Kw5otkEvTMxSBd/RkEMShJ4Bq1yaGjt6x8hwZAUJYTRhBvhKiDwPf7xl96uYBuCfZch31qe44/bpu4Puz+IIs7uO1X1woHGkajOcocfW3YcBAExUALYl2h/K3DWg+/xewGxogUV137WeFgbLhyr0c6b/cAywLWNNHO3kQCMyHilg5oHRQCcskpji3WertFIB2UwaBTNLqsq9tAACuZ8X+mqhrk7gY/iOaaDZnAjmUeeQS+XbSF3Ae4iMZfh+ehwwlZNx8hP/xlHAPCC4QkKdchDjzY6vUgIahCuRLIGchFxFHvuO49pxlBMif58l23qaJEBY6MmSteqStfLM9ynZFmDKvCRh/kpOS5BkDrEjZLuviuXNlxngDbXnzqQ54ctTBSOmHs8SoLIvyCwUqFALSaXKGjDeak2RIR55VFbITCrrZC6VdRU2yQw3B6csHyhYXqkssYk61ZKgul7vzg8pvbig41LfBx8hXM2hKb/jxHzgc9Fwi1euFPVB9KuqNjmtPKmYQ1RIwBK2ERfyqduFyP668zbrpf+UKT2uGnY7xch9IyTVrs/dW1gBb2jMvNI8Ol1sCiIY24t2mN7CEsQUxmIepbx4WRH/Yeel+/LQGzjUrrOkO8fe2fYZnR+x9x+pD1m60ugbFmo1/9LeD2iXN4KjpKSgvRd90p9JOD66tY9u7aNba3Zrkm189Gnv79P+zHaPODSk7xdQyI/e6KM3+uiNFN6IJrffSPbx2/BIpxb/b3VJyFClT6p7pvJkK9HO2AyQ6NUa8FKfxWlyFYlzOxarsecuYLufC32q7vrLhwFN5wXVw4jD62GrWvIWlTtBw+4ZzKwfP5QzEAZxzDvlg7OTe7H5VoK5BEpAl+rnaLXz0tchT6/5OosZnsh0VKfZqywUAiEbihivYkZTdjCgPZ406OJQlbvsmyQKVSecpeSLI04J2pSb5o0dRbefy7ffvZN7Pfx80i3nQd4pLz/ZBefPii55+dEu9Z9TfOAQEdeJ9tfQnmML7XfSVNE82VKXGUuW7hio1gfd28P5KZmmPbV9dt7mmXI/K0lpnFas6bDNpV0KdcVNNUjbjkfrpvnUMlDNPCoMXD1W7jgcOQ8qsyCpSU6KypRIbpYyJHz/T80vpJDqg985+oOXNQV4CRH28oIH68eCkcQzu8ozu8Yzu8ozu8azItx7MV2vxd/taSvqJxgJJVfp+lHCzORurZHe87ZW1fvUqiPZyimuSCqj/eFaDlaQPHUljlm84RTIQfGPt3i61ex22MJmbbXN1iNV7Za5ZNJK16m12TaRoujpkfppjlD1rTwE9Uu/BiXuHFIGXTjUxy4tyeHia+GL5Ms0a5a+8pnIkO5fe53S29cQVvubPIR04nu2T9GRlypO6nGhJU03KU2zBDCVAbWTiBqd8OQVbvar7t8gAtCqKGZ5d4YI3igjUa+n/chivIhDAp6IW0PaCeDb+YtHI1d5e+gRkvLLLTHpIG0/0RjZ3KnRWLlw9Hl9BjPy5m1XJz9xbw99Lb3STqSu83oLDvcG+70tul+IquIS01zUffZZE9WHq1ECHUjX9TOPJRXiu491FjeiTqlshH940a72oZ1QiqHrt7kalRYA8y5Nc9rG4M0LtF31NB6xiLyfutuLJt4/oViKIfM1kUgI0Axzl2UP9JGT/3HKz2oKHggDz/9+w0h/AtM0yhOyLK43nuamMIYbmHky/UrUdMqkVVcYOMAmeFB4w9Jsq6uaDwuAV3tIWBLhX45ptl5zQ90KCrAmkcebMUu2EXhflLBO8EbNUx43uD/4xWZve8zia+i+pUtq5ufbrHNEpRPtkwvHsj5ZaV3F1bPTpcnJsr4md2jvaH/b0KM3Jrso8z1yH2XE57cML3HhMvpz7ZS5mlibHXtmGfdguRAzBewb7YqGLvM1mAJSpL1VwBysVz/GAkTaZBTy+j4HPFXGh7fdeStWVdM1OZLVhz9olCn6VGAlyp9eAb7HYu7DqFmJZRVHwdciGwMsR5QmZLLCEWDLac9mJf3n0FpZmsQLTP70tEmO2Fr4mU1Jhc/ibedIl25h98+Itt1rCiFLQzUNAhkeZFzXgPEvFC/jSBSr1KZ+W7elFtUPKxtVB3W3o4lLDjc02PpgNMqNhJbjVk4TGgcFqM57DFKxt3YWIqZZNZAnCahfh+4Vt2F74r89+X8ycCNDDUUAAA==")!

