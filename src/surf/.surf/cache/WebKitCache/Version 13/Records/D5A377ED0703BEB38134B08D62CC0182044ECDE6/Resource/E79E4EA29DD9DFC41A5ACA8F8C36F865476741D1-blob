(function(){var k;function aa(a){var b=0;return function(){return b<a.length?{done:!1,value:a[b++]}:{done:!0}}}
function ba(a){var b="undefined"!=typeof Symbol&&Symbol.iterator&&a[Symbol.iterator];return b?b.call(a):{next:aa(a)}}
var ca="function"==typeof Object.create?Object.create:function(a){function b(){}
b.prototype=a;return new b},da;
if("function"==typeof Object.setPrototypeOf)da=Object.setPrototypeOf;else{var fa;a:{var ha={na:!0},ia={};try{ia.__proto__=ha;fa=ia.na;break a}catch(a){}fa=!1}da=fa?function(a,b){a.__proto__=b;if(a.__proto__!==b)throw new TypeError(a+" is not extensible");return a}:null}var ja=da;
function n(a,b){a.prototype=ca(b.prototype);a.prototype.constructor=a;if(ja)ja(a,b);else for(var c in b)if("prototype"!=c)if(Object.defineProperties){var d=Object.getOwnPropertyDescriptor(b,c);d&&Object.defineProperty(a,c,d)}else a[c]=b[c];a.w=b.prototype}
var ka="function"==typeof Object.defineProperties?Object.defineProperty:function(a,b,c){a!=Array.prototype&&a!=Object.prototype&&(a[b]=c.value)},la="undefined"!=typeof window&&window===this?this:"undefined"!=typeof global&&null!=global?global:this;
function ma(a,b){if(b){for(var c=la,d=a.split("."),e=0;e<d.length-1;e++){var f=d[e];f in c||(c[f]={});c=c[f]}d=d[d.length-1];e=c[d];f=b(e);f!=e&&null!=f&&ka(c,d,{configurable:!0,writable:!0,value:f})}}
function na(a,b,c){if(null==a)throw new TypeError("The 'this' value for String.prototype."+c+" must not be null or undefined");if(b instanceof RegExp)throw new TypeError("First argument to String.prototype."+c+" must not be a regular expression");return a+""}
ma("String.prototype.startsWith",function(a){return a?a:function(a,c){var b=na(this,a,"startsWith");a+="";for(var e=b.length,f=a.length,g=Math.max(0,Math.min(c|0,b.length)),h=0;h<f&&g<e;)if(b[g++]!=a[h++])return!1;return h>=f}});
ma("String.prototype.endsWith",function(a){return a?a:function(a,c){var b=na(this,a,"endsWith");a+="";void 0===c&&(c=b.length);for(var e=Math.max(0,Math.min(c|0,b.length)),f=a.length;0<f&&0<e;)if(b[--e]!=a[--f])return!1;return 0>=f}});
function oa(){oa=function(){};
la.Symbol||(la.Symbol=pa)}
var pa=function(){var a=0;return function(b){return"jscomp_symbol_"+(b||"")+a++}}();
function qa(){oa();var a=la.Symbol.iterator;a||(a=la.Symbol.iterator=la.Symbol("iterator"));"function"!=typeof Array.prototype[a]&&ka(Array.prototype,a,{configurable:!0,writable:!0,value:function(){return ra(aa(this))}});
qa=function(){}}
function ra(a){qa();a={next:a};a[la.Symbol.iterator]=function(){return this};
return a}
function p(a,b){return Object.prototype.hasOwnProperty.call(a,b)}
var sa="function"==typeof Object.assign?Object.assign:function(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(d)for(var e in d)p(d,e)&&(a[e]=d[e])}return a};
ma("Object.assign",function(a){return a||sa});
ma("WeakMap",function(a){function b(a){this.b=(g+=Math.random()+1).toString();if(a){a=ba(a);for(var b;!(b=a.next()).done;)b=b.value,this.set(b[0],b[1])}}
function c(){}
function d(a){p(a,f)||ka(a,f,{value:new c})}
function e(a){var b=Object[a];b&&(Object[a]=function(a){if(a instanceof c)return a;d(a);return b(a)})}
if(function(){if(!a||!Object.seal)return!1;try{var b=Object.seal({}),c=Object.seal({}),d=new a([[b,2],[c,3]]);if(2!=d.get(b)||3!=d.get(c))return!1;d["delete"](b);d.set(c,4);return!d.has(b)&&4==d.get(c)}catch(u){return!1}}())return a;
var f="$jscomp_hidden_"+Math.random();e("freeze");e("preventExtensions");e("seal");var g=0;b.prototype.set=function(a,b){d(a);if(!p(a,f))throw Error("WeakMap key fail: "+a);a[f][this.b]=b;return this};
b.prototype.get=function(a){return p(a,f)?a[f][this.b]:void 0};
b.prototype.has=function(a){return p(a,f)&&p(a[f],this.b)};
b.prototype["delete"]=function(a){return p(a,f)&&p(a[f],this.b)?delete a[f][this.b]:!1};
return b});
ma("Map",function(a){function b(){var a={};return a.previous=a.next=a.head=a}
function c(a,b){var c=a.b;return ra(function(){if(c){for(;c.head!=a.b;)c=c.previous;for(;c.next!=c.head;)return c=c.next,{done:!1,value:b(c)};c=null}return{done:!0,value:void 0}})}
function d(a,b){var c=b&&typeof b;"object"==c||"function"==c?f.has(b)?c=f.get(b):(c=""+ ++g,f.set(b,c)):c="p_"+b;var d=a.c[c];if(d&&p(a.c,c))for(var e=0;e<d.length;e++){var h=d[e];if(b!==b&&h.key!==h.key||b===h.key)return{id:c,list:d,index:e,m:h}}return{id:c,list:d,index:-1,m:void 0}}
function e(a){this.c={};this.b=b();this.size=0;if(a){a=ba(a);for(var c;!(c=a.next()).done;)c=c.value,this.set(c[0],c[1])}}
if(function(){if(!a||"function"!=typeof a||!a.prototype.entries||"function"!=typeof Object.seal)return!1;try{var b=Object.seal({x:4}),c=new a(ba([[b,"s"]]));if("s"!=c.get(b)||1!=c.size||c.get({x:4})||c.set({x:4},"t")!=c||2!=c.size)return!1;var d=c.entries(),e=d.next();if(e.done||e.value[0]!=b||"s"!=e.value[1])return!1;e=d.next();return e.done||4!=e.value[0].x||"t"!=e.value[1]||!d.next().done?!1:!0}catch(ea){return!1}}())return a;
qa();var f=new WeakMap;e.prototype.set=function(a,b){a=0===a?0:a;var c=d(this,a);c.list||(c.list=this.c[c.id]=[]);c.m?c.m.value=b:(c.m={next:this.b,previous:this.b.previous,head:this.b,key:a,value:b},c.list.push(c.m),this.b.previous.next=c.m,this.b.previous=c.m,this.size++);return this};
e.prototype["delete"]=function(a){a=d(this,a);return a.m&&a.list?(a.list.splice(a.index,1),a.list.length||delete this.c[a.id],a.m.previous.next=a.m.next,a.m.next.previous=a.m.previous,a.m.head=null,this.size--,!0):!1};
e.prototype.clear=function(){this.c={};this.b=this.b.previous=b();this.size=0};
e.prototype.has=function(a){return!!d(this,a).m};
e.prototype.get=function(a){return(a=d(this,a).m)&&a.value};
e.prototype.entries=function(){return c(this,function(a){return[a.key,a.value]})};
e.prototype.keys=function(){return c(this,function(a){return a.key})};
e.prototype.values=function(){return c(this,function(a){return a.value})};
e.prototype.forEach=function(a,b){for(var c=this.entries(),d;!(d=c.next()).done;)d=d.value,a.call(b,d[1],d[0],this)};
e.prototype[Symbol.iterator]=e.prototype.entries;var g=0;return e});
ma("Set",function(a){function b(a){this.b=new Map;if(a){a=ba(a);for(var b;!(b=a.next()).done;)this.add(b.value)}this.size=this.b.size}
if(function(){if(!a||"function"!=typeof a||!a.prototype.entries||"function"!=typeof Object.seal)return!1;try{var b=Object.seal({x:4}),d=new a(ba([b]));if(!d.has(b)||1!=d.size||d.add(b)!=d||1!=d.size||d.add({x:4})!=d||2!=d.size)return!1;var e=d.entries(),f=e.next();if(f.done||f.value[0]!=b||f.value[1]!=b)return!1;f=e.next();return f.done||f.value[0]==b||4!=f.value[0].x||f.value[1]!=f.value[0]?!1:e.next().done}catch(g){return!1}}())return a;
qa();b.prototype.add=function(a){a=0===a?0:a;this.b.set(a,a);this.size=this.b.size;return this};
b.prototype["delete"]=function(a){a=this.b["delete"](a);this.size=this.b.size;return a};
b.prototype.clear=function(){this.b.clear();this.size=0};
b.prototype.has=function(a){return this.b.has(a)};
b.prototype.entries=function(){return this.b.entries()};
b.prototype.values=function(){return this.b.values()};
b.prototype.keys=b.prototype.values;b.prototype[Symbol.iterator]=b.prototype.values;b.prototype.forEach=function(a,b){var c=this;this.b.forEach(function(d){return a.call(b,d,d,c)})};
return b});
ma("Object.is",function(a){return a?a:function(a,c){return a===c?0!==a||1/a===1/c:a!==a&&c!==c}});
ma("String.prototype.includes",function(a){return a?a:function(a,c){return-1!==na(this,a,"includes").indexOf(a,c||0)}});
(function(){function a(){function a(){}
Reflect.construct(a,[],function(){});
return new a instanceof a}
if("undefined"!=typeof Reflect&&Reflect.construct){if(a())return Reflect.construct;var b=Reflect.construct;return function(a,d,e){a=b(a,d);e&&Reflect.setPrototypeOf(a,e.prototype);return a}}return function(a,b,e){void 0===e&&(e=a);
e=ca(e.prototype||Object.prototype);return Function.prototype.apply.call(a,e,b)||e}})();
var q=this;function r(a){return void 0!==a}
function t(a){return"string"==typeof a}
function v(a,b,c){a=a.split(".");c=c||q;a[0]in c||"undefined"==typeof c.execScript||c.execScript("var "+a[0]);for(var d;a.length&&(d=a.shift());)!a.length&&r(b)?c[d]=b:c[d]&&c[d]!==Object.prototype[d]?c=c[d]:c=c[d]={}}
var ta=/^[\w+/_-]+[=]{0,2}$/,ua=null;function w(a,b){for(var c=a.split("."),d=b||q,e=0;e<c.length;e++)if(d=d[c[e]],null==d)return null;return d}
function va(){}
function wa(a){a.ba=void 0;a.getInstance=function(){return a.ba?a.ba:a.ba=new a}}
function xa(a){var b=typeof a;if("object"==b)if(a){if(a instanceof Array)return"array";if(a instanceof Object)return b;var c=Object.prototype.toString.call(a);if("[object Window]"==c)return"object";if("[object Array]"==c||"number"==typeof a.length&&"undefined"!=typeof a.splice&&"undefined"!=typeof a.propertyIsEnumerable&&!a.propertyIsEnumerable("splice"))return"array";if("[object Function]"==c||"undefined"!=typeof a.call&&"undefined"!=typeof a.propertyIsEnumerable&&!a.propertyIsEnumerable("call"))return"function"}else return"null";
else if("function"==b&&"undefined"==typeof a.call)return"object";return b}
function x(a){return"array"==xa(a)}
function ya(a){var b=xa(a);return"array"==b||"object"==b&&"number"==typeof a.length}
function y(a){return"function"==xa(a)}
function z(a){var b=typeof a;return"object"==b&&null!=a||"function"==b}
var za="closure_uid_"+(1E9*Math.random()>>>0),Aa=0;function Ba(a,b,c){return a.call.apply(a.bind,arguments)}
function Ca(a,b,c){if(!a)throw Error();if(2<arguments.length){var d=Array.prototype.slice.call(arguments,2);return function(){var c=Array.prototype.slice.call(arguments);Array.prototype.unshift.apply(c,d);return a.apply(b,c)}}return function(){return a.apply(b,arguments)}}
function A(a,b,c){Function.prototype.bind&&-1!=Function.prototype.bind.toString().indexOf("native code")?A=Ba:A=Ca;return A.apply(null,arguments)}
function Da(a,b){var c=Array.prototype.slice.call(arguments,1);return function(){var b=c.slice();b.push.apply(b,arguments);return a.apply(this,b)}}
var B=Date.now||function(){return+new Date};
function Ea(a,b){v(a,b,void 0)}
function C(a,b){function c(){}
c.prototype=b.prototype;a.w=b.prototype;a.prototype=new c;a.prototype.constructor=a;a.jb=function(a,c,f){for(var d=Array(arguments.length-2),e=2;e<arguments.length;e++)d[e-2]=arguments[e];return b.prototype[c].apply(a,d)}}
;var Fa=document,D=window;function E(a){if(Error.captureStackTrace)Error.captureStackTrace(this,E);else{var b=Error().stack;b&&(this.stack=b)}a&&(this.message=String(a))}
C(E,Error);E.prototype.name="CustomError";var Ga=Array.prototype.indexOf?function(a,b){return Array.prototype.indexOf.call(a,b,void 0)}:function(a,b){if(t(a))return t(b)&&1==b.length?a.indexOf(b,0):-1;
for(var c=0;c<a.length;c++)if(c in a&&a[c]===b)return c;return-1},F=Array.prototype.forEach?function(a,b,c){Array.prototype.forEach.call(a,b,c)}:function(a,b,c){for(var d=a.length,e=t(a)?a.split(""):a,f=0;f<d;f++)f in e&&b.call(c,e[f],f,a)},Ha=Array.prototype.filter?function(a,b){return Array.prototype.filter.call(a,b,void 0)}:function(a,b){for(var c=a.length,d=[],e=0,f=t(a)?a.split(""):a,g=0;g<c;g++)if(g in f){var h=f[g];
b.call(void 0,h,g,a)&&(d[e++]=h)}return d},Ia=Array.prototype.map?function(a,b){return Array.prototype.map.call(a,b,void 0)}:function(a,b){for(var c=a.length,d=Array(c),e=t(a)?a.split(""):a,f=0;f<c;f++)f in e&&(d[f]=b.call(void 0,e[f],f,a));
return d},Ja=Array.prototype.reduce?function(a,b,c){return Array.prototype.reduce.call(a,b,c)}:function(a,b,c){var d=c;
F(a,function(c,f){d=b.call(void 0,d,c,f,a)});
return d};
function Ka(a,b){a:{var c=a.length;for(var d=t(a)?a.split(""):a,e=0;e<c;e++)if(e in d&&b.call(void 0,d[e],e,a)){c=e;break a}c=-1}return 0>c?null:t(a)?a.charAt(c):a[c]}
function La(a,b){var c=Ga(a,b);0<=c&&Array.prototype.splice.call(a,c,1)}
function Ma(a){var b=a.length;if(0<b){for(var c=Array(b),d=0;d<b;d++)c[d]=a[d];return c}return[]}
function Na(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(ya(d)){var e=a.length||0,f=d.length||0;a.length=e+f;for(var g=0;g<f;g++)a[e+g]=d[g]}else a.push(d)}}
;var Oa=String.prototype.trim?function(a){return a.trim()}:function(a){return/^[\s\xa0]*([\s\S]*?)[\s\xa0]*$/.exec(a)[1]};
function Pa(a,b){if(b)a=a.replace(Qa,"&amp;").replace(Ra,"&lt;").replace(Sa,"&gt;").replace(Ta,"&quot;").replace(Ua,"&#39;").replace(Va,"&#0;");else{if(!Wa.test(a))return a;-1!=a.indexOf("&")&&(a=a.replace(Qa,"&amp;"));-1!=a.indexOf("<")&&(a=a.replace(Ra,"&lt;"));-1!=a.indexOf(">")&&(a=a.replace(Sa,"&gt;"));-1!=a.indexOf('"')&&(a=a.replace(Ta,"&quot;"));-1!=a.indexOf("'")&&(a=a.replace(Ua,"&#39;"));-1!=a.indexOf("\x00")&&(a=a.replace(Va,"&#0;"))}return a}
var Qa=/&/g,Ra=/</g,Sa=/>/g,Ta=/"/g,Ua=/'/g,Va=/\x00/g,Wa=/[\x00&<>"']/;function Xa(a){return a=Pa(a,void 0)}
function Ya(a){for(var b=0,c=0;c<a.length;++c)b=31*b+a.charCodeAt(c)>>>0;return b}
;var Za;a:{var $a=q.navigator;if($a){var ab=$a.userAgent;if(ab){Za=ab;break a}}Za=""}function G(a){return-1!=Za.indexOf(a)}
;function bb(a,b){for(var c in a)b.call(void 0,a[c],c,a)}
function cb(a,b){var c=ya(b),d=c?b:arguments;for(c=c?0:1;c<d.length;c++){if(null==a)return;a=a[d[c]]}return a}
function db(a){var b=eb,c;for(c in b)if(a.call(void 0,b[c],c,b))return c}
function fb(a){for(var b in a)return!1;return!0}
function gb(a,b){if(null!==a&&b in a)throw Error('The object already contains the key "'+b+'"');a[b]=!0}
function hb(a,b){for(var c in a)if(!(c in b)||a[c]!==b[c])return!1;for(c in b)if(!(c in a))return!1;return!0}
function ib(a){var b={},c;for(c in a)b[c]=a[c];return b}
function jb(a){var b=xa(a);if("object"==b||"array"==b){if(y(a.clone))return a.clone();b="array"==b?[]:{};for(var c in a)b[c]=jb(a[c]);return b}return a}
var kb="constructor hasOwnProperty isPrototypeOf propertyIsEnumerable toLocaleString toString valueOf".split(" ");function lb(a,b){for(var c,d,e=1;e<arguments.length;e++){d=arguments[e];for(c in d)a[c]=d[c];for(var f=0;f<kb.length;f++)c=kb[f],Object.prototype.hasOwnProperty.call(d,c)&&(a[c]=d[c])}}
;function mb(a){mb[" "](a);return a}
mb[" "]=va;var nb=G("Opera"),ob=G("Trident")||G("MSIE"),pb=G("Edge"),qb=G("Gecko")&&!(-1!=Za.toLowerCase().indexOf("webkit")&&!G("Edge"))&&!(G("Trident")||G("MSIE"))&&!G("Edge"),rb=-1!=Za.toLowerCase().indexOf("webkit")&&!G("Edge");function sb(){var a=q.document;return a?a.documentMode:void 0}
var tb;a:{var ub="",vb=function(){var a=Za;if(qb)return/rv:([^\);]+)(\)|;)/.exec(a);if(pb)return/Edge\/([\d\.]+)/.exec(a);if(ob)return/\b(?:MSIE|rv)[: ]([^\);]+)(\)|;)/.exec(a);if(rb)return/WebKit\/(\S+)/.exec(a);if(nb)return/(?:Version)[ \/]?(\S+)/.exec(a)}();
vb&&(ub=vb?vb[1]:"");if(ob){var wb=sb();if(null!=wb&&wb>parseFloat(ub)){tb=String(wb);break a}}tb=ub}var xb=tb,yb;var zb=q.document;yb=zb&&ob?sb()||("CSS1Compat"==zb.compatMode?parseInt(xb,10):5):void 0;var Ab=null,Bb=null;function Cb(a){this.b=a||{cookie:""}}
k=Cb.prototype;k.isEnabled=function(){return navigator.cookieEnabled};
k.set=function(a,b,c,d,e,f){if(/[;=\s]/.test(a))throw Error('Invalid cookie name "'+a+'"');if(/[;\r\n]/.test(b))throw Error('Invalid cookie value "'+b+'"');r(c)||(c=-1);e=e?";domain="+e:"";d=d?";path="+d:"";f=f?";secure":"";c=0>c?"":0==c?";expires="+(new Date(1970,1,1)).toUTCString():";expires="+(new Date(B()+1E3*c)).toUTCString();this.b.cookie=a+"="+b+e+d+c+f};
k.get=function(a,b){for(var c=a+"=",d=(this.b.cookie||"").split(";"),e=0,f;e<d.length;e++){f=Oa(d[e]);if(0==f.lastIndexOf(c,0))return f.substr(c.length);if(f==a)return""}return b};
k.remove=function(a,b,c){var d=r(this.get(a));this.set(a,"",0,b,c);return d};
k.isEmpty=function(){return!this.b.cookie};
k.clear=function(){for(var a=(this.b.cookie||"").split(";"),b=[],c=[],d,e,f=0;f<a.length;f++)e=Oa(a[f]),d=e.indexOf("="),-1==d?(b.push(""),c.push(e)):(b.push(e.substring(0,d)),c.push(e.substring(d+1)));for(a=b.length-1;0<=a;a--)this.remove(b[a])};
var Db=new Cb("undefined"==typeof document?null:document);function Eb(a){var b=w("window.location.href");null==a&&(a='Unknown Error of type "null/undefined"');if(t(a))return{message:a,name:"Unknown error",lineNumber:"Not available",fileName:b,stack:"Not available"};var c=!1;try{var d=a.lineNumber||a.line||"Not available"}catch(f){d="Not available",c=!0}try{var e=a.fileName||a.filename||a.sourceURL||q.$googDebugFname||b}catch(f){e="Not available",c=!0}return!c&&a.lineNumber&&a.fileName&&a.stack&&a.message&&a.name?a:(b=a.message,null==b&&(a.constructor&&a.constructor instanceof
Function?(a.constructor.name?b=a.constructor.name:(b=a.constructor,Fb[b]?b=Fb[b]:(b=String(b),Fb[b]||(c=/function\s+([^\(]+)/m.exec(b),Fb[b]=c?c[1]:"[Anonymous]"),b=Fb[b])),b='Unknown Error of type "'+b+'"'):b="Unknown Error of unknown type"),{message:b,name:a.name||"UnknownError",lineNumber:d,fileName:e,stack:a.stack||"Not available"})}
var Fb={};function Gb(a){var b=!1,c;return function(){b||(c=a(),b=!0);return c}}
;var Hb=!ob||9<=Number(yb);function Ib(){this.b="";this.c=Jb}
Ib.prototype.I=!0;Ib.prototype.H=function(){return this.b};
Ib.prototype.aa=!0;Ib.prototype.X=function(){return 1};
function Kb(a){if(a instanceof Ib&&a.constructor===Ib&&a.c===Jb)return a.b;xa(a);return"type_error:TrustedResourceUrl"}
var Jb={};function H(){this.b="";this.c=Lb}
H.prototype.I=!0;H.prototype.H=function(){return this.b};
H.prototype.aa=!0;H.prototype.X=function(){return 1};
function Mb(a){if(a instanceof H&&a.constructor===H&&a.c===Lb)return a.b;xa(a);return"type_error:SafeUrl"}
var Nb=/^(?:(?:https?|mailto|ftp):|[^:/?#]*(?:[/?#]|$))/i;function Ob(a){if(a instanceof H)return a;a="object"==typeof a&&a.I?a.H():String(a);Nb.test(a)||(a="about:invalid#zClosurez");return Pb(a)}
var Lb={};function Pb(a){var b=new H;b.b=a;return b}
Pb("about:blank");function Qb(){this.b="";this.f=Rb;this.c=null}
Qb.prototype.aa=!0;Qb.prototype.X=function(){return this.c};
Qb.prototype.I=!0;Qb.prototype.H=function(){return this.b};
var Rb={};function Sb(a,b){var c=new Qb;c.b=a;c.c=b;return c}
Sb("<!DOCTYPE html>",0);Sb("",0);Sb("<br>",0);function Tb(a,b){var c=b instanceof H?b:Ob(b);a.href=Mb(c)}
function Ub(a,b){a.src=Kb(b);if(null===ua)b:{var c=q.document;if((c=c.querySelector&&c.querySelector("script[nonce]"))&&(c=c.nonce||c.getAttribute("nonce"))&&ta.test(c)){ua=c;break b}ua=""}c=ua;c&&a.setAttribute("nonce",c)}
;function Vb(a,b){this.x=r(a)?a:0;this.y=r(b)?b:0}
k=Vb.prototype;k.clone=function(){return new Vb(this.x,this.y)};
k.equals=function(a){return a instanceof Vb&&(this==a?!0:this&&a?this.x==a.x&&this.y==a.y:!1)};
k.ceil=function(){this.x=Math.ceil(this.x);this.y=Math.ceil(this.y);return this};
k.floor=function(){this.x=Math.floor(this.x);this.y=Math.floor(this.y);return this};
k.round=function(){this.x=Math.round(this.x);this.y=Math.round(this.y);return this};function Wb(a,b){this.width=a;this.height=b}
k=Wb.prototype;k.clone=function(){return new Wb(this.width,this.height)};
k.aspectRatio=function(){return this.width/this.height};
k.isEmpty=function(){return!(this.width*this.height)};
k.ceil=function(){this.width=Math.ceil(this.width);this.height=Math.ceil(this.height);return this};
k.floor=function(){this.width=Math.floor(this.width);this.height=Math.floor(this.height);return this};
k.round=function(){this.width=Math.round(this.width);this.height=Math.round(this.height);return this};function Xb(a){var b=document;return t(a)?b.getElementById(a):a}
function Yb(a,b){bb(b,function(b,d){b&&"object"==typeof b&&b.I&&(b=b.H());"style"==d?a.style.cssText=b:"class"==d?a.className=b:"for"==d?a.htmlFor=b:Zb.hasOwnProperty(d)?a.setAttribute(Zb[d],b):0==d.lastIndexOf("aria-",0)||0==d.lastIndexOf("data-",0)?a.setAttribute(d,b):a[d]=b})}
var Zb={cellpadding:"cellPadding",cellspacing:"cellSpacing",colspan:"colSpan",frameborder:"frameBorder",height:"height",maxlength:"maxLength",nonce:"nonce",role:"role",rowspan:"rowSpan",type:"type",usemap:"useMap",valign:"vAlign",width:"width"};
function $b(a,b,c){var d=arguments,e=document,f=String(d[0]),g=d[1];if(!Hb&&g&&(g.name||g.type)){f=["<",f];g.name&&f.push(' name="',Xa(g.name),'"');if(g.type){f.push(' type="',Xa(g.type),'"');var h={};lb(h,g);delete h.type;g=h}f.push(">");f=f.join("")}f=e.createElement(f);g&&(t(g)?f.className=g:x(g)?f.className=g.join(" "):Yb(f,g));2<d.length&&ac(e,f,d);return f}
function ac(a,b,c){function d(c){c&&b.appendChild(t(c)?a.createTextNode(c):c)}
for(var e=2;e<c.length;e++){var f=c[e];!ya(f)||z(f)&&0<f.nodeType?d(f):F(bc(f)?Ma(f):f,d)}}
function bc(a){if(a&&"number"==typeof a.length){if(z(a))return"function"==typeof a.item||"string"==typeof a.item;if(y(a))return"function"==typeof a.item}return!1}
function cc(a,b){for(var c=0;a;){if(b(a))return a;a=a.parentNode;c++}return null}
;function dc(a){ec();var b=new Ib;b.b=a;return b}
var ec=va;function fc(){var a=gc;try{var b;if(b=!!a&&null!=a.location.href)a:{try{mb(a.foo);b=!0;break a}catch(c){}b=!1}return b}catch(c){return!1}}
function hc(a){var b=ic;if(b)for(var c in b)Object.prototype.hasOwnProperty.call(b,c)&&a.call(void 0,b[c],c,b)}
function jc(){var a=[];hc(function(b){a.push(b)});
return a}
var ic={Va:"allow-forms",Wa:"allow-modals",Xa:"allow-orientation-lock",Ya:"allow-pointer-lock",Za:"allow-popups",ab:"allow-popups-to-escape-sandbox",bb:"allow-presentation",cb:"allow-same-origin",eb:"allow-scripts",fb:"allow-top-navigation",gb:"allow-top-navigation-by-user-activation"},kc=Gb(function(){return jc()});
function lc(){var a=document.createElement("IFRAME").sandbox,b=a&&a.supports;if(!b)return{};var c={};F(kc(),function(d){b.call(a,d)&&(c[d]=!0)});
return c}
;function mc(a){"number"==typeof a&&(a=Math.round(a)+"px");return a}
;var nc=!!window.google_async_iframe_id,gc=nc&&window.parent||window;var oc=/^(?:([^:/?#.]+):)?(?:\/\/(?:([^/?#]*)@)?([^/#?]*?)(?::([0-9]+))?(?=[/#?]|$))?([^?#]+)?(?:\?([^#]*))?(?:#([\s\S]*))?$/;function I(a){return a?decodeURI(a):a}
function J(a,b){return b.match(oc)[a]||null}
function pc(a,b,c){if(x(b))for(var d=0;d<b.length;d++)pc(a,String(b[d]),c);else null!=b&&c.push(a+(""===b?"":"="+encodeURIComponent(String(b))))}
function qc(a){var b=[],c;for(c in a)pc(c,a[c],b);return b.join("&")}
function rc(a,b){var c=qc(b);if(c){var d=a.indexOf("#");0>d&&(d=a.length);var e=a.indexOf("?");if(0>e||e>d){e=d;var f=""}else f=a.substring(e+1,d);d=[a.substr(0,e),f,a.substr(d)];e=d[1];d[1]=c?e?e+"&"+c:c:e;c=d[0]+(d[1]?"?"+d[1]:"")+d[2]}else c=a;return c}
var sc=/#|$/;function tc(a,b){var c=a.search(sc);a:{var d=0;for(var e=b.length;0<=(d=a.indexOf(b,d))&&d<c;){var f=a.charCodeAt(d-1);if(38==f||63==f)if(f=a.charCodeAt(d+e),!f||61==f||38==f||35==f)break a;d+=e+1}d=-1}if(0>d)return null;e=a.indexOf("&",d);if(0>e||e>c)e=c;d+=b.length+1;return decodeURIComponent(a.substr(d,e-d).replace(/\+/g," "))}
;var uc=null;function vc(){var a=q.performance;return a&&a.now&&a.timing?Math.floor(a.now()+a.timing.navigationStart):B()}
function wc(){var a=void 0===a?q:a;return(a=a.performance)&&a.now?a.now():null}
;function xc(a,b,c){this.label=a;this.type=b;this.value=c;this.duration=0;this.uniqueId=this.label+"_"+this.type+"_"+Math.random();this.slotId=void 0}
;var K=q.performance,yc=!!(K&&K.mark&&K.measure&&K.clearMarks),zc=Gb(function(){var a;if(a=yc){var b;if(null===uc){uc="";try{a="";try{a=q.top.location.hash}catch(c){a=q.location.hash}a&&(uc=(b=a.match(/\bdeid=([\d,]+)/))?b[1]:"")}catch(c){}}b=uc;a=!!b.indexOf&&0<=b.indexOf("1337")}return a});
function Ac(){var a=Bc;this.events=[];this.c=a||q;var b=null;a&&(a.google_js_reporting_queue=a.google_js_reporting_queue||[],this.events=a.google_js_reporting_queue,b=a.google_measure_js_timing);this.b=zc()||(null!=b?b:1>Math.random())}
Ac.prototype.disable=function(){this.b=!1;this.events!=this.c.google_js_reporting_queue&&(zc()&&F(this.events,Cc),this.events.length=0)};
function Cc(a){a&&K&&zc()&&(K.clearMarks("goog_"+a.uniqueId+"_start"),K.clearMarks("goog_"+a.uniqueId+"_end"))}
Ac.prototype.start=function(a,b){if(!this.b)return null;var c=wc()||vc();c=new xc(a,b,c);var d="goog_"+c.uniqueId+"_start";K&&zc()&&K.mark(d);return c};
Ac.prototype.end=function(a){if(this.b&&"number"==typeof a.value){var b=wc()||vc();a.duration=b-a.value;b="goog_"+a.uniqueId+"_end";K&&zc()&&K.mark(b);this.b&&this.events.push(a)}};if(nc&&!fc()){var Dc="."+Fa.domain;try{for(;2<Dc.split(".").length&&!fc();)Fa.domain=Dc=Dc.substr(Dc.indexOf(".")+1),gc=window.parent}catch(a){}fc()||(gc=window)}var Bc=gc,Ec=new Ac;if("complete"==Bc.document.readyState)Bc.google_measure_js_timing||Ec.disable();else if(Ec.b){var Fc=function(){Bc.google_measure_js_timing||Ec.disable()},Gc=Bc;
Gc.addEventListener&&Gc.addEventListener("load",Fc,!1)};var Hc=(new Date).getTime();function Ic(a){if(!a)return"";a=a.split("#")[0].split("?")[0];a=a.toLowerCase();0==a.indexOf("//")&&(a=window.location.protocol+a);/^[\w\-]*:\/\//.test(a)||(a=window.location.href);var b=a.substring(a.indexOf("://")+3),c=b.indexOf("/");-1!=c&&(b=b.substring(0,c));a=a.substring(0,a.indexOf("://"));if("http"!==a&&"https"!==a&&"chrome-extension"!==a&&"file"!==a&&"android-app"!==a&&"chrome-search"!==a&&"app"!==a)throw Error("Invalid URI scheme in origin: "+a);c="";var d=b.indexOf(":");if(-1!=d){var e=
b.substring(d+1);b=b.substring(0,d);if("http"===a&&"80"!==e||"https"===a&&"443"!==e)c=":"+e}return a+"://"+b+c}
;function Jc(){function a(){e[0]=1732584193;e[1]=4023233417;e[2]=2562383102;e[3]=271733878;e[4]=3285377520;u=l=0}
function b(a){for(var b=g,c=0;64>c;c+=4)b[c/4]=a[c]<<24|a[c+1]<<16|a[c+2]<<8|a[c+3];for(c=16;80>c;c++)a=b[c-3]^b[c-8]^b[c-14]^b[c-16],b[c]=(a<<1|a>>>31)&4294967295;a=e[0];var d=e[1],f=e[2],h=e[3],m=e[4];for(c=0;80>c;c++){if(40>c)if(20>c){var l=h^d&(f^h);var u=1518500249}else l=d^f^h,u=1859775393;else 60>c?(l=d&f|h&(d|f),u=2400959708):(l=d^f^h,u=3395469782);l=((a<<5|a>>>27)&4294967295)+l+m+u+b[c]&4294967295;m=h;h=f;f=(d<<30|d>>>2)&4294967295;d=a;a=l}e[0]=e[0]+a&4294967295;e[1]=e[1]+d&4294967295;e[2]=
e[2]+f&4294967295;e[3]=e[3]+h&4294967295;e[4]=e[4]+m&4294967295}
function c(a,c){if("string"===typeof a){a=unescape(encodeURIComponent(a));for(var d=[],e=0,g=a.length;e<g;++e)d.push(a.charCodeAt(e));a=d}c||(c=a.length);d=0;if(0==l)for(;d+64<c;)b(a.slice(d,d+64)),d+=64,u+=64;for(;d<c;)if(f[l++]=a[d++],u++,64==l)for(l=0,b(f);d+64<c;)b(a.slice(d,d+64)),d+=64,u+=64}
function d(){var a=[],d=8*u;56>l?c(h,56-l):c(h,64-(l-56));for(var g=63;56<=g;g--)f[g]=d&255,d>>>=8;b(f);for(g=d=0;5>g;g++)for(var m=24;0<=m;m-=8)a[d++]=e[g]>>m&255;return a}
for(var e=[],f=[],g=[],h=[128],m=1;64>m;++m)h[m]=0;var l,u;a();return{reset:a,update:c,digest:d,qa:function(){for(var a=d(),b="",c=0;c<a.length;c++)b+="0123456789ABCDEF".charAt(Math.floor(a[c]/16))+"0123456789ABCDEF".charAt(a[c]%16);return b}}}
;function Kc(a,b,c){var d=[],e=[];if(1==(x(c)?2:1))return e=[b,a],F(d,function(a){e.push(a)}),Lc(e.join(" "));
var f=[],g=[];F(c,function(a){g.push(a.key);f.push(a.value)});
c=Math.floor((new Date).getTime()/1E3);e=0==f.length?[c,b,a]:[f.join(":"),c,b,a];F(d,function(a){e.push(a)});
a=Lc(e.join(" "));a=[c,a];0==g.length||a.push(g.join(""));return a.join("_")}
function Lc(a){var b=Jc();b.update(a);return b.qa().toLowerCase()}
;function Mc(a){var b=Ic(String(q.location.href)),c=q.__OVERRIDE_SID;null==c&&(c=(new Cb(document)).get("SID"));if(c&&(b=(c=0==b.indexOf("https:")||0==b.indexOf("chrome-extension:"))?q.__SAPISID:q.__APISID,null==b&&(b=(new Cb(document)).get(c?"SAPISID":"APISID")),b)){c=c?"SAPISIDHASH":"APISIDHASH";var d=String(q.location.href);return d&&b&&c?[c,Kc(Ic(d),b,a||null)].join(" "):null}return null}
;function Nc(a,b){this.f=a;this.g=b;this.c=0;this.b=null}
Nc.prototype.get=function(){if(0<this.c){this.c--;var a=this.b;this.b=a.next;a.next=null}else a=this.f();return a};
function Oc(a,b){a.g(b);100>a.c&&(a.c++,b.next=a.b,a.b=b)}
;function Pc(a){q.setTimeout(function(){throw a;},0)}
var Qc;
function Rc(){var a=q.MessageChannel;"undefined"===typeof a&&"undefined"!==typeof window&&window.postMessage&&window.addEventListener&&!G("Presto")&&(a=function(){var a=document.createElement("IFRAME");a.style.display="none";a.src="";document.documentElement.appendChild(a);var b=a.contentWindow;a=b.document;a.open();a.write("");a.close();var c="callImmediate"+Math.random(),d="file:"==b.location.protocol?"*":b.location.protocol+"//"+b.location.host;a=A(function(a){if(("*"==d||a.origin==d)&&a.data==
c)this.port1.onmessage()},this);
b.addEventListener("message",a,!1);this.port1={};this.port2={postMessage:function(){b.postMessage(c,d)}}});
if("undefined"!==typeof a&&!G("Trident")&&!G("MSIE")){var b=new a,c={},d=c;b.port1.onmessage=function(){if(r(c.next)){c=c.next;var a=c.ea;c.ea=null;a()}};
return function(a){d.next={ea:a};d=d.next;b.port2.postMessage(0)}}return"undefined"!==typeof document&&"onreadystatechange"in document.createElement("SCRIPT")?function(a){var b=document.createElement("SCRIPT");
b.onreadystatechange=function(){b.onreadystatechange=null;b.parentNode.removeChild(b);b=null;a();a=null};
document.documentElement.appendChild(b)}:function(a){q.setTimeout(a,0)}}
;function Sc(){this.c=this.b=null}
var Uc=new Nc(function(){return new Tc},function(a){a.reset()});
Sc.prototype.add=function(a,b){var c=Uc.get();c.set(a,b);this.c?this.c.next=c:this.b=c;this.c=c};
Sc.prototype.remove=function(){var a=null;this.b&&(a=this.b,this.b=this.b.next,this.b||(this.c=null),a.next=null);return a};
function Tc(){this.next=this.scope=this.b=null}
Tc.prototype.set=function(a,b){this.b=a;this.scope=b;this.next=null};
Tc.prototype.reset=function(){this.next=this.scope=this.b=null};function Vc(a,b){Wc||Xc();Yc||(Wc(),Yc=!0);Zc.add(a,b)}
var Wc;function Xc(){if(q.Promise&&q.Promise.resolve){var a=q.Promise.resolve(void 0);Wc=function(){a.then($c)}}else Wc=function(){var a=$c;
!y(q.setImmediate)||q.Window&&q.Window.prototype&&!G("Edge")&&q.Window.prototype.setImmediate==q.setImmediate?(Qc||(Qc=Rc()),Qc(a)):q.setImmediate(a)}}
var Yc=!1,Zc=new Sc;function $c(){for(var a;a=Zc.remove();){try{a.b.call(a.scope)}catch(b){Pc(b)}Oc(Uc,a)}Yc=!1}
;function ad(){this.c=-1}
;function bd(){this.c=64;this.b=[];this.i=[];this.o=[];this.g=[];this.g[0]=128;for(var a=1;a<this.c;++a)this.g[a]=0;this.h=this.f=0;this.reset()}
C(bd,ad);bd.prototype.reset=function(){this.b[0]=1732584193;this.b[1]=4023233417;this.b[2]=2562383102;this.b[3]=271733878;this.b[4]=3285377520;this.h=this.f=0};
function cd(a,b,c){c||(c=0);var d=a.o;if(t(b))for(var e=0;16>e;e++)d[e]=b.charCodeAt(c)<<24|b.charCodeAt(c+1)<<16|b.charCodeAt(c+2)<<8|b.charCodeAt(c+3),c+=4;else for(e=0;16>e;e++)d[e]=b[c]<<24|b[c+1]<<16|b[c+2]<<8|b[c+3],c+=4;for(e=16;80>e;e++){var f=d[e-3]^d[e-8]^d[e-14]^d[e-16];d[e]=(f<<1|f>>>31)&4294967295}b=a.b[0];c=a.b[1];var g=a.b[2],h=a.b[3],m=a.b[4];for(e=0;80>e;e++){if(40>e)if(20>e){f=h^c&(g^h);var l=1518500249}else f=c^g^h,l=1859775393;else 60>e?(f=c&g|h&(c|g),l=2400959708):(f=c^g^h,l=
3395469782);f=(b<<5|b>>>27)+f+m+l+d[e]&4294967295;m=h;h=g;g=(c<<30|c>>>2)&4294967295;c=b;b=f}a.b[0]=a.b[0]+b&4294967295;a.b[1]=a.b[1]+c&4294967295;a.b[2]=a.b[2]+g&4294967295;a.b[3]=a.b[3]+h&4294967295;a.b[4]=a.b[4]+m&4294967295}
bd.prototype.update=function(a,b){if(null!=a){r(b)||(b=a.length);for(var c=b-this.c,d=0,e=this.i,f=this.f;d<b;){if(0==f)for(;d<=c;)cd(this,a,d),d+=this.c;if(t(a))for(;d<b;){if(e[f]=a.charCodeAt(d),++f,++d,f==this.c){cd(this,e);f=0;break}}else for(;d<b;)if(e[f]=a[d],++f,++d,f==this.c){cd(this,e);f=0;break}}this.f=f;this.h+=b}};
bd.prototype.digest=function(){var a=[],b=8*this.h;56>this.f?this.update(this.g,56-this.f):this.update(this.g,this.c-(this.f-56));for(var c=this.c-1;56<=c;c--)this.i[c]=b&255,b/=256;cd(this,this.i);for(c=b=0;5>c;c++)for(var d=24;0<=d;d-=8)a[b]=this.b[c]>>d&255,++b;return a};function L(){this.c=this.c;this.o=this.o}
L.prototype.c=!1;L.prototype.dispose=function(){this.c||(this.c=!0,this.j())};
function dd(a,b){a.c?r(void 0)?b.call(void 0):b():(a.o||(a.o=[]),a.o.push(r(void 0)?A(b,void 0):b))}
L.prototype.j=function(){if(this.o)for(;this.o.length;)this.o.shift()()};
function ed(a){a&&"function"==typeof a.dispose&&a.dispose()}
function fd(a){for(var b=0,c=arguments.length;b<c;++b){var d=arguments[b];ya(d)?fd.apply(null,d):ed(d)}}
;function gd(a){if(a.classList)return a.classList;a=a.className;return t(a)&&a.match(/\S+/g)||[]}
function hd(a,b){if(a.classList)var c=a.classList.contains(b);else c=gd(a),c=0<=Ga(c,b);return c}
function id(){var a=document.body;a.classList?a.classList.remove("inverted-hdpi"):hd(a,"inverted-hdpi")&&(a.className=Ha(gd(a),function(a){return"inverted-hdpi"!=a}).join(" "))}
;var jd="StopIteration"in q?q.StopIteration:{message:"StopIteration",stack:""};function kd(){}
kd.prototype.next=function(){throw jd;};
kd.prototype.D=function(){return this};
function ld(a){if(a instanceof kd)return a;if("function"==typeof a.D)return a.D(!1);if(ya(a)){var b=0,c=new kd;c.next=function(){for(;;){if(b>=a.length)throw jd;if(b in a)return a[b++];b++}};
return c}throw Error("Not implemented");}
function md(a,b){if(ya(a))try{F(a,b,void 0)}catch(c){if(c!==jd)throw c;}else{a=ld(a);try{for(;;)b.call(void 0,a.next(),void 0,a)}catch(c){if(c!==jd)throw c;}}}
function nd(a){if(ya(a))return Ma(a);a=ld(a);var b=[];md(a,function(a){b.push(a)});
return b}
;function od(a,b){this.f={};this.b=[];this.g=this.c=0;var c=arguments.length;if(1<c){if(c%2)throw Error("Uneven number of arguments");for(var d=0;d<c;d+=2)this.set(arguments[d],arguments[d+1])}else if(a)if(a instanceof od)for(c=pd(a),d=0;d<c.length;d++)this.set(c[d],a.get(c[d]));else for(d in a)this.set(d,a[d])}
function pd(a){qd(a);return a.b.concat()}
k=od.prototype;k.equals=function(a,b){if(this===a)return!0;if(this.c!=a.c)return!1;var c=b||rd;qd(this);for(var d,e=0;d=this.b[e];e++)if(!c(this.get(d),a.get(d)))return!1;return!0};
function rd(a,b){return a===b}
k.isEmpty=function(){return 0==this.c};
k.clear=function(){this.f={};this.g=this.c=this.b.length=0};
k.remove=function(a){return Object.prototype.hasOwnProperty.call(this.f,a)?(delete this.f[a],this.c--,this.g++,this.b.length>2*this.c&&qd(this),!0):!1};
function qd(a){if(a.c!=a.b.length){for(var b=0,c=0;b<a.b.length;){var d=a.b[b];Object.prototype.hasOwnProperty.call(a.f,d)&&(a.b[c++]=d);b++}a.b.length=c}if(a.c!=a.b.length){var e={};for(c=b=0;b<a.b.length;)d=a.b[b],Object.prototype.hasOwnProperty.call(e,d)||(a.b[c++]=d,e[d]=1),b++;a.b.length=c}}
k.get=function(a,b){return Object.prototype.hasOwnProperty.call(this.f,a)?this.f[a]:b};
k.set=function(a,b){Object.prototype.hasOwnProperty.call(this.f,a)||(this.c++,this.b.push(a),this.g++);this.f[a]=b};
k.forEach=function(a,b){for(var c=pd(this),d=0;d<c.length;d++){var e=c[d],f=this.get(e);a.call(b,f,e,this)}};
k.clone=function(){return new od(this)};
k.D=function(a){qd(this);var b=0,c=this.g,d=this,e=new kd;e.next=function(){if(c!=d.g)throw Error("The map has changed since the iterator was created");if(b>=d.b.length)throw jd;var e=d.b[b++];return a?e:d.f[e]};
return e};function sd(a){var b=[];td(new ud,a,b);return b.join("")}
function ud(){}
function td(a,b,c){if(null==b)c.push("null");else{if("object"==typeof b){if(x(b)){var d=b;b=d.length;c.push("[");for(var e="",f=0;f<b;f++)c.push(e),td(a,d[f],c),e=",";c.push("]");return}if(b instanceof String||b instanceof Number||b instanceof Boolean)b=b.valueOf();else{c.push("{");e="";for(d in b)Object.prototype.hasOwnProperty.call(b,d)&&(f=b[d],"function"!=typeof f&&(c.push(e),vd(d,c),c.push(":"),td(a,f,c),e=","));c.push("}");return}}switch(typeof b){case "string":vd(b,c);break;case "number":c.push(isFinite(b)&&
!isNaN(b)?String(b):"null");break;case "boolean":c.push(String(b));break;case "function":c.push("null");break;default:throw Error("Unknown type: "+typeof b);}}}
var wd={'"':'\\"',"\\":"\\\\","/":"\\/","\b":"\\b","\f":"\\f","\n":"\\n","\r":"\\r","\t":"\\t","\x0B":"\\u000b"},xd=/\uffff/.test("\uffff")?/[\\"\x00-\x1f\x7f-\uffff]/g:/[\\"\x00-\x1f\x7f-\xff]/g;function vd(a,b){b.push('"',a.replace(xd,function(a){var b=wd[a];b||(b="\\u"+(a.charCodeAt(0)|65536).toString(16).substr(1),wd[a]=b);return b}),'"')}
;function yd(a){if(!a)return!1;try{return!!a.$goog_Thenable}catch(b){return!1}}
;function M(a){this.b=0;this.o=void 0;this.g=this.c=this.f=null;this.h=this.i=!1;if(a!=va)try{var b=this;a.call(void 0,function(a){zd(b,2,a)},function(a){zd(b,3,a)})}catch(c){zd(this,3,c)}}
function Ad(){this.next=this.context=this.onRejected=this.c=this.b=null;this.f=!1}
Ad.prototype.reset=function(){this.context=this.onRejected=this.c=this.b=null;this.f=!1};
var Bd=new Nc(function(){return new Ad},function(a){a.reset()});
function Dd(a,b,c){var d=Bd.get();d.c=a;d.onRejected=b;d.context=c;return d}
function Ed(a){return new M(function(b,c){c(a)})}
M.prototype.then=function(a,b,c){return Fd(this,y(a)?a:null,y(b)?b:null,c)};
M.prototype.$goog_Thenable=!0;function Gd(a,b){return Fd(a,null,b,void 0)}
M.prototype.cancel=function(a){0==this.b&&Vc(function(){var b=new Hd(a);Id(this,b)},this)};
function Id(a,b){if(0==a.b)if(a.f){var c=a.f;if(c.c){for(var d=0,e=null,f=null,g=c.c;g&&(g.f||(d++,g.b==a&&(e=g),!(e&&1<d)));g=g.next)e||(f=g);e&&(0==c.b&&1==d?Id(c,b):(f?(d=f,d.next==c.g&&(c.g=d),d.next=d.next.next):Jd(c),Kd(c,e,3,b)))}a.f=null}else zd(a,3,b)}
function Ld(a,b){a.c||2!=a.b&&3!=a.b||Md(a);a.g?a.g.next=b:a.c=b;a.g=b}
function Fd(a,b,c,d){var e=Dd(null,null,null);e.b=new M(function(a,g){e.c=b?function(c){try{var e=b.call(d,c);a(e)}catch(l){g(l)}}:a;
e.onRejected=c?function(b){try{var e=c.call(d,b);!r(e)&&b instanceof Hd?g(b):a(e)}catch(l){g(l)}}:g});
e.b.f=a;Ld(a,e);return e.b}
M.prototype.u=function(a){this.b=0;zd(this,2,a)};
M.prototype.A=function(a){this.b=0;zd(this,3,a)};
function zd(a,b,c){if(0==a.b){a===c&&(b=3,c=new TypeError("Promise cannot resolve to itself"));a.b=1;a:{var d=c,e=a.u,f=a.A;if(d instanceof M){Ld(d,Dd(e||va,f||null,a));var g=!0}else if(yd(d))d.then(e,f,a),g=!0;else{if(z(d))try{var h=d.then;if(y(h)){Nd(d,h,e,f,a);g=!0;break a}}catch(m){f.call(a,m);g=!0;break a}g=!1}}g||(a.o=c,a.b=b,a.f=null,Md(a),3!=b||c instanceof Hd||Od(a,c))}}
function Nd(a,b,c,d,e){function f(a){h||(h=!0,d.call(e,a))}
function g(a){h||(h=!0,c.call(e,a))}
var h=!1;try{b.call(a,g,f)}catch(m){f(m)}}
function Md(a){a.i||(a.i=!0,Vc(a.l,a))}
function Jd(a){var b=null;a.c&&(b=a.c,a.c=b.next,b.next=null);a.c||(a.g=null);return b}
M.prototype.l=function(){for(var a;a=Jd(this);)Kd(this,a,this.b,this.o);this.i=!1};
function Kd(a,b,c,d){if(3==c&&b.onRejected&&!b.f)for(;a&&a.h;a=a.f)a.h=!1;if(b.b)b.b.f=null,Pd(b,c,d);else try{b.f?b.c.call(b.context):Pd(b,c,d)}catch(e){Qd.call(null,e)}Oc(Bd,b)}
function Pd(a,b,c){2==b?a.c.call(a.context,c):a.onRejected&&a.onRejected.call(a.context,c)}
function Od(a,b){a.h=!0;Vc(function(){a.h&&Qd.call(null,b)})}
var Qd=Pc;function Hd(a){E.call(this,a)}
C(Hd,E);Hd.prototype.name="cancel";function N(a){L.call(this);this.i=1;this.g=[];this.h=0;this.b=[];this.f={};this.l=!!a}
C(N,L);k=N.prototype;k.subscribe=function(a,b,c){var d=this.f[a];d||(d=this.f[a]=[]);var e=this.i;this.b[e]=a;this.b[e+1]=b;this.b[e+2]=c;this.i=e+3;d.push(e);return e};
function Rd(a,b,c,d){if(b=a.f[b]){var e=a.b;(b=Ka(b,function(a){return e[a+1]==c&&e[a+2]==d}))&&a.K(b)}}
k.K=function(a){var b=this.b[a];if(b){var c=this.f[b];0!=this.h?(this.g.push(a),this.b[a+1]=va):(c&&La(c,a),delete this.b[a],delete this.b[a+1],delete this.b[a+2])}return!!b};
k.J=function(a,b){var c=this.f[a];if(c){for(var d=Array(arguments.length-1),e=1,f=arguments.length;e<f;e++)d[e-1]=arguments[e];if(this.l)for(e=0;e<c.length;e++){var g=c[e];Sd(this.b[g+1],this.b[g+2],d)}else{this.h++;try{for(e=0,f=c.length;e<f;e++)g=c[e],this.b[g+1].apply(this.b[g+2],d)}finally{if(this.h--,0<this.g.length&&0==this.h)for(;c=this.g.pop();)this.K(c)}}return 0!=e}return!1};
function Sd(a,b,c){Vc(function(){a.apply(b,c)})}
k.clear=function(a){if(a){var b=this.f[a];b&&(F(b,this.K,this),delete this.f[a])}else this.b.length=0,this.f={}};
k.j=function(){N.w.j.call(this);this.clear();this.g.length=0};function Td(a){this.b=a}
Td.prototype.set=function(a,b){r(b)?this.b.set(a,sd(b)):this.b.remove(a)};
Td.prototype.get=function(a){try{var b=this.b.get(a)}catch(c){return}if(null!==b)try{return JSON.parse(b)}catch(c){throw"Storage: Invalid value was encountered";}};
Td.prototype.remove=function(a){this.b.remove(a)};function Ud(a){this.b=a}
C(Ud,Td);function Vd(a){this.data=a}
function Wd(a){return!r(a)||a instanceof Vd?a:new Vd(a)}
Ud.prototype.set=function(a,b){Ud.w.set.call(this,a,Wd(b))};
Ud.prototype.c=function(a){a=Ud.w.get.call(this,a);if(!r(a)||a instanceof Object)return a;throw"Storage: Invalid value was encountered";};
Ud.prototype.get=function(a){if(a=this.c(a)){if(a=a.data,!r(a))throw"Storage: Invalid value was encountered";}else a=void 0;return a};function Xd(a){this.b=a}
C(Xd,Ud);Xd.prototype.set=function(a,b,c){if(b=Wd(b)){if(c){if(c<B()){Xd.prototype.remove.call(this,a);return}b.expiration=c}b.creation=B()}Xd.w.set.call(this,a,b)};
Xd.prototype.c=function(a){var b=Xd.w.c.call(this,a);if(b){var c=b.creation,d=b.expiration;if(d&&d<B()||c&&c>B())Xd.prototype.remove.call(this,a);else return b}};function Yd(){}
;function Zd(){}
C(Zd,Yd);Zd.prototype.clear=function(){var a=nd(this.D(!0)),b=this;F(a,function(a){b.remove(a)})};function $d(a){this.b=a}
C($d,Zd);k=$d.prototype;k.isAvailable=function(){if(!this.b)return!1;try{return this.b.setItem("__sak","1"),this.b.removeItem("__sak"),!0}catch(a){return!1}};
k.set=function(a,b){try{this.b.setItem(a,b)}catch(c){if(0==this.b.length)throw"Storage mechanism: Storage disabled";throw"Storage mechanism: Quota exceeded";}};
k.get=function(a){a=this.b.getItem(a);if(!t(a)&&null!==a)throw"Storage mechanism: Invalid value was encountered";return a};
k.remove=function(a){this.b.removeItem(a)};
k.D=function(a){var b=0,c=this.b,d=new kd;d.next=function(){if(b>=c.length)throw jd;var d=c.key(b++);if(a)return d;d=c.getItem(d);if(!t(d))throw"Storage mechanism: Invalid value was encountered";return d};
return d};
k.clear=function(){this.b.clear()};
k.key=function(a){return this.b.key(a)};function ae(){var a=null;try{a=window.localStorage||null}catch(b){}this.b=a}
C(ae,$d);function be(a,b){this.c=a;this.b=null;if(ob&&!(9<=Number(yb))){ce||(ce=new od);this.b=ce.get(a);this.b||(b?this.b=document.getElementById(b):(this.b=document.createElement("userdata"),this.b.addBehavior("#default#userData"),document.body.appendChild(this.b)),ce.set(a,this.b));try{this.b.load(this.c)}catch(c){this.b=null}}}
C(be,Zd);var de={".":".2E","!":".21","~":".7E","*":".2A","'":".27","(":".28",")":".29","%":"."},ce=null;function ee(a){return"_"+encodeURIComponent(a).replace(/[.!~*'()%]/g,function(a){return de[a]})}
k=be.prototype;k.isAvailable=function(){return!!this.b};
k.set=function(a,b){this.b.setAttribute(ee(a),b);fe(this)};
k.get=function(a){a=this.b.getAttribute(ee(a));if(!t(a)&&null!==a)throw"Storage mechanism: Invalid value was encountered";return a};
k.remove=function(a){this.b.removeAttribute(ee(a));fe(this)};
k.D=function(a){var b=0,c=this.b.XMLDocument.documentElement.attributes,d=new kd;d.next=function(){if(b>=c.length)throw jd;var d=c[b++];if(a)return decodeURIComponent(d.nodeName.replace(/\./g,"%")).substr(1);d=d.nodeValue;if(!t(d))throw"Storage mechanism: Invalid value was encountered";return d};
return d};
k.clear=function(){for(var a=this.b.XMLDocument.documentElement,b=a.attributes.length;0<b;b--)a.removeAttribute(a.attributes[b-1].nodeName);fe(this)};
function fe(a){try{a.b.save(a.c)}catch(b){throw"Storage mechanism: Quota exceeded";}}
;function ge(a,b){this.c=a;this.b=b+"::"}
C(ge,Zd);ge.prototype.set=function(a,b){this.c.set(this.b+a,b)};
ge.prototype.get=function(a){return this.c.get(this.b+a)};
ge.prototype.remove=function(a){this.c.remove(this.b+a)};
ge.prototype.D=function(a){var b=this.c.D(!0),c=this,d=new kd;d.next=function(){for(var d=b.next();d.substr(0,c.b.length)!=c.b;)d=b.next();return a?d.substr(c.b.length):c.c.get(d)};
return d};function he(){this.c=[];this.b=-1}
he.prototype.set=function(a,b){b=void 0===b?!0:b;0<=a&&52>a&&0===a%1&&this.c[a]!=b&&(this.c[a]=b,this.b=-1)};
he.prototype.get=function(a){return!!this.c[a]};
function ie(a){-1==a.b&&(a.b=Ja(a.c,function(a,c,d){return c?a+Math.pow(2,d):a},0));
return a.b}
;function je(a,b){if(1<b.length)a[b[0]]=b[1];else{var c=b[0],d;for(d in c)a[d]=c[d]}}
var O=window.performance&&window.performance.timing&&window.performance.now?function(){return window.performance.timing.navigationStart+window.performance.now()}:function(){return(new Date).getTime()};var ke=window.yt&&window.yt.config_||window.ytcfg&&window.ytcfg.data_||{};v("yt.config_",ke,void 0);function P(a){je(ke,arguments)}
function Q(a,b){return a in ke?ke[a]:b}
function le(a){return Q(a,void 0)}
function me(){return Q("PLAYER_CONFIG",{})}
;function ne(){var a=oe;w("yt.ads.biscotti.getId_")||v("yt.ads.biscotti.getId_",a,void 0)}
function pe(a){v("yt.ads.biscotti.lastId_",a,void 0)}
;function qe(a){var b=re;a=void 0===a?w("yt.ads.biscotti.lastId_")||"":a;b=Object.assign(se(b),te(b));b.ca_type="image";a&&(b.bid=a);return b}
function se(a){var b={};b.dt=Hc;b.flash="0";a:{try{var c=a.b.top.location.href}catch(f){a=2;break a}a=c?c===a.c.location.href?0:1:2}b=(b.frm=a,b);b.u_tz=-(new Date).getTimezoneOffset();var d=void 0===d?D:d;try{var e=d.history.length}catch(f){e=0}b.u_his=e;b.u_java=!!D.navigator&&"unknown"!==typeof D.navigator.javaEnabled&&!!D.navigator.javaEnabled&&D.navigator.javaEnabled();D.screen&&(b.u_h=D.screen.height,b.u_w=D.screen.width,b.u_ah=D.screen.availHeight,b.u_aw=D.screen.availWidth,b.u_cd=D.screen.colorDepth);
D.navigator&&D.navigator.plugins&&(b.u_nplug=D.navigator.plugins.length);D.navigator&&D.navigator.mimeTypes&&(b.u_nmime=D.navigator.mimeTypes.length);return b}
function te(a){var b=a.b;try{var c=b.screenX;var d=b.screenY}catch(ea){}try{var e=b.outerWidth;var f=b.outerHeight}catch(ea){}try{var g=b.innerWidth;var h=b.innerHeight}catch(ea){}b=[b.screenLeft,b.screenTop,c,d,b.screen?b.screen.availWidth:void 0,b.screen?b.screen.availTop:void 0,e,f,g,h];c=a.b.top;try{var m=(c||window).document,l="CSS1Compat"==m.compatMode?m.documentElement:m.body;var u=(new Wb(l.clientWidth,l.clientHeight)).round()}catch(ea){u=new Wb(-12245933,-12245933)}m=u;u={};l=new he;q.SVGElement&&
q.document.createElementNS&&l.set(0);c=lc();c["allow-top-navigation-by-user-activation"]&&l.set(1);c["allow-popups-to-escape-sandbox"]&&l.set(2);q.crypto&&q.crypto.subtle&&l.set(3);l=ie(l);u.bc=l;u.bih=m.height;u.biw=m.width;u.brdim=b.join();a=a.c;return u.vis={visible:1,hidden:2,prerender:3,preview:4,unloaded:5}[a.visibilityState||a.webkitVisibilityState||a.mozVisibilityState||""]||0,u.wgl=!!D.WebGLRenderingContext,u}
var re=new function(){var a=window.document;this.b=window;this.c=a};B();function ue(a){return a&&window.yterr?function(){try{return a.apply(this,arguments)}catch(b){R(b)}}:a}
function R(a,b,c,d,e){var f=w("yt.logging.errors.log");f?f(a,b,c,d,e):(f=Q("ERRORS",[]),f.push([a,b,c,d,e]),P("ERRORS",f))}
function ve(a){R(a,"WARNING",void 0,void 0,void 0)}
;function S(a){return Q("EXPERIMENT_FLAGS",{})[a]}
;var we=r(XMLHttpRequest)?function(){return new XMLHttpRequest}:r(ActiveXObject)?function(){return new ActiveXObject("Microsoft.XMLHTTP")}:null;
function xe(){if(!we)return null;var a=we();return"open"in a?a:null}
function ye(a){switch(a&&"status"in a?a.status:-1){case 200:case 201:case 202:case 203:case 204:case 205:case 206:case 304:return!0;default:return!1}}
;function T(a,b){y(a)&&(a=ue(a));return window.setTimeout(a,b)}
function U(a){window.clearTimeout(a)}
;function ze(a){var b=[];bb(a,function(a,d){var c=encodeURIComponent(String(d)),f;x(a)?f=a:f=[a];F(f,function(a){""==a?b.push(c):b.push(c+"="+encodeURIComponent(String(a)))})});
return b.join("&")}
function Ae(a){"?"==a.charAt(0)&&(a=a.substr(1));a=a.split("&");for(var b={},c=0,d=a.length;c<d;c++){var e=a[c].split("=");if(1==e.length&&e[0]||2==e.length)try{var f=decodeURIComponent((e[0]||"").replace(/\+/g," ")),g=decodeURIComponent((e[1]||"").replace(/\+/g," "));f in b?x(b[f])?Na(b[f],g):b[f]=[b[f],g]:b[f]=g}catch(m){if(S("catch_invalid_url_components")){var h=Error("Error decoding URL component.");h.params="key: "+e[0]+", value: "+e[1];R(h)}else throw m;}}return b}
function Be(a,b,c){var d=a.split("#",2);a=d[0];d=1<d.length?"#"+d[1]:"";var e=a.split("?",2);a=e[0];e=Ae(e[1]||"");for(var f in b)!c&&null!==e&&f in e||(e[f]=b[f]);return rc(a,e)+d}
;var Ce={Authorization:"AUTHORIZATION","X-Goog-Visitor-Id":"SANDBOXED_VISITOR_ID","X-YouTube-Client-Name":"INNERTUBE_CONTEXT_CLIENT_NAME","X-YouTube-Client-Version":"INNERTUBE_CONTEXT_CLIENT_VERSION","X-Youtube-Identity-Token":"ID_TOKEN","X-YouTube-Page-CL":"PAGE_CL","X-YouTube-Page-Label":"PAGE_BUILD_LABEL","X-YouTube-Variants-Checksum":"VARIANTS_CHECKSUM"},De="app debugcss debugjs expflag force_ad_params force_viral_ad_response_params forced_experiments internalcountrycode internalipoverride absolute_experiments conditional_experiments sbb sr_bns_address".split(" "),
Ee=!1;
function Fe(a,b){b=void 0===b?{}:b;if(!c)var c=window.location.href;var d=J(1,a),e=I(J(3,a));d&&e?(d=c,c=a.match(oc),d=d.match(oc),c=c[3]==d[3]&&c[1]==d[1]&&c[4]==d[4]):c=e?I(J(3,c))==e&&(Number(J(4,c))||null)==(Number(J(4,a))||null):!0;d=!!S("web_ajax_ignore_global_headers_if_set");for(var f in Ce)e=Q(Ce[f]),!e||!c&&!Ge(a,f)||d&&void 0!==b[f]||(b[f]=e);if(c||Ge(a,"X-YouTube-Utc-Offset"))b["X-YouTube-Utc-Offset"]=-(new Date).getTimezoneOffset();S("pass_biscotti_id_in_header_ajax")&&(c||Ge(a,"X-YouTube-Ad-Signals"))&&
(f=qe(void 0),b["X-YouTube-Ad-Signals"]=ze(f));return b}
function He(a){var b=window.location.search,c=I(J(3,a)),d=I(J(5,a));d=(c=c&&c.endsWith("youtube.com"))&&d&&d.startsWith("/api/");if(!c||d)return a;var e=Ae(b),f={};F(De,function(a){e[a]&&(f[a]=e[a])});
return Be(a,f||{},!1)}
function Ge(a,b){var c=Q("CORS_HEADER_WHITELIST")||{},d=I(J(3,a));return d?(c=c[d])?0<=Ga(c,b):!1:!0}
function Ie(a,b){if(window.fetch&&"XML"!=b.format){var c={method:b.method||"GET",credentials:"same-origin"};b.headers&&(c.headers=b.headers);a=Je(a,b);var d=Ke(a,b);d&&(c.body=d);b.withCredentials&&(c.credentials="include");var e=!1,f;fetch(a,c).then(function(a){if(!e){e=!0;f&&U(f);var c=a.ok,d=function(d){d=d||{};var e=b.context||q;c?b.onSuccess&&b.onSuccess.call(e,d,a):b.onError&&b.onError.call(e,d,a);b.ca&&b.ca.call(e,d,a)};
"JSON"==(b.format||"JSON")&&(c||400<=a.status&&500>a.status)?a.json().then(d,function(){d(null)}):d(null)}});
b.ga&&0<b.timeout&&(f=T(function(){e||(e=!0,U(f),b.ga.call(b.context||q))},b.timeout))}else Le(a,b)}
function Le(a,b){var c=b.format||"JSON";a=Je(a,b);var d=Ke(a,b),e=!1,f,g=Me(a,function(a){if(!e){e=!0;f&&U(f);var d=ye(a),g=null,h=400<=a.status&&500>a.status,ea=500<=a.status&&600>a.status;if(d||h||ea)g=Ne(c,a,b.lb);if(d)a:if(a&&204==a.status)d=!0;else{switch(c){case "XML":d=0==parseInt(g&&g.return_code,10);break a;case "RAW":d=!0;break a}d=!!g}g=g||{};h=b.context||q;d?b.onSuccess&&b.onSuccess.call(h,a,g):b.onError&&b.onError.call(h,a,g);b.ca&&b.ca.call(h,a,g)}},b.method,d,b.headers,b.responseType,
b.withCredentials);
b.L&&0<b.timeout&&(f=T(function(){e||(e=!0,g.abort(),U(f),b.L.call(b.context||q,g))},b.timeout));
return g}
function Je(a,b){b.va&&(a=document.location.protocol+"//"+document.location.hostname+(document.location.port?":"+document.location.port:"")+a);var c=Q("XSRF_FIELD_NAME",void 0),d=b.Ua;d&&(d[c]&&delete d[c],a=Be(a,d||{},!0));return a}
function Ke(a,b){var c=Q("XSRF_FIELD_NAME",void 0),d=Q("XSRF_TOKEN",void 0),e=b.postBody||"",f=b.B,g=le("XSRF_FIELD_NAME"),h;b.headers&&(h=b.headers["Content-Type"]);b.mb||I(J(3,a))&&!b.withCredentials&&I(J(3,a))!=document.location.hostname||"POST"!=b.method||h&&"application/x-www-form-urlencoded"!=h||b.B&&b.B[g]||(f||(f={}),f[c]=d);f&&t(e)&&(e=Ae(e),lb(e,f),e=b.ha&&"JSON"==b.ha?JSON.stringify(e):qc(e));f=e||f&&!fb(f);!Ee&&f&&"POST"!=b.method&&(Ee=!0,R(Error("AJAX request with postData should use POST")));
return e}
function Ne(a,b,c){var d=null;switch(a){case "JSON":a=b.responseText;b=b.getResponseHeader("Content-Type")||"";a&&0<=b.indexOf("json")&&(d=JSON.parse(a));break;case "XML":if(b=(b=b.responseXML)?Oe(b):null)d={},F(b.getElementsByTagName("*"),function(a){d[a.tagName]=Pe(a)})}c&&Qe(d);
return d}
function Qe(a){if(z(a))for(var b in a){var c;(c="html_content"==b)||(c=b.length-5,c=0<=c&&b.indexOf("_html",c)==c);if(c){c=b;var d=Sb(a[b],null);a[c]=d}else Qe(a[b])}}
function Oe(a){return a?(a=("responseXML"in a?a.responseXML:a).getElementsByTagName("root"))&&0<a.length?a[0]:null:null}
function Pe(a){var b="";F(a.childNodes,function(a){b+=a.nodeValue});
return b}
function Re(a,b){b.method="POST";b.B||(b.B={});Le(a,b)}
function Me(a,b,c,d,e,f,g){function h(){4==(m&&"readyState"in m?m.readyState:0)&&b&&ue(b)(m)}
c=void 0===c?"GET":c;d=void 0===d?"":d;var m=xe();if(!m)return null;"onloadend"in m?m.addEventListener("loadend",h,!1):m.onreadystatechange=h;S("debug_forward_web_query_parameters")&&(a=He(a));m.open(c,a,!0);f&&(m.responseType=f);g&&(m.withCredentials=!0);c="POST"==c&&(void 0===window.FormData||!(d instanceof FormData));if(e=Fe(a,e))for(var l in e)m.setRequestHeader(l,e[l]),"content-type"==l.toLowerCase()&&(c=!1);c&&m.setRequestHeader("Content-Type","application/x-www-form-urlencoded");m.send(d);
return m}
;var Se={},Te=0;
function Ue(a,b,c,d,e){e=void 0===e?"":e;a&&(c&&(c=Za,c=!(c&&0<=c.toLowerCase().indexOf("cobalt"))),c?a&&(a instanceof H||(a="object"==typeof a&&a.I?a.H():String(a),Nb.test(a)||(a="about:invalid#zClosurez"),a=Pb(a)),b=Mb(a),"about:invalid#zClosurez"===b?a="":(b instanceof Qb?a=b:(d="object"==typeof b,a=null,d&&b.aa&&(a=b.X()),b=Pa(d&&b.I?b.H():String(b)),a=Sb(b,a)),a instanceof Qb&&a.constructor===Qb&&a.f===Rb?a=a.b:(xa(a),a="type_error:SafeHtml"),a=encodeURIComponent(String(sd(a)))),/^[\s\xa0]*$/.test(a)||
(a=$b("IFRAME",{src:'javascript:"<body><img src=\\""+'+a+'+"\\"></body>"',style:"display:none"}),(9==a.nodeType?a:a.ownerDocument||a.document).body.appendChild(a))):e?Me(a,b,"POST",e,d):Q("USE_NET_AJAX_FOR_PING_TRANSPORT",!1)||d?Me(a,b,"GET","",d):((d=ke.EXPERIMENT_FLAGS)&&d.web_use_beacon_api_for_ad_click_server_pings&&-1!=I(J(5,a)).indexOf("/aclk")&&"1"===tc(a,"ae")&&"1"===tc(a,"act")?Ve(a)?(b&&b(),d=!0):d=!1:d=!1,d||We(a,b)))}
function Ve(a,b){try{if(window.navigator&&window.navigator.sendBeacon&&window.navigator.sendBeacon(a,void 0===b?"":b))return!0}catch(c){}return!1}
function We(a,b){var c=new Image,d=""+Te++;Se[d]=c;c.onload=c.onerror=function(){b&&Se[d]&&b();delete Se[d]};
c.src=a}
;var Xe={},Ye=0;
function Ze(a,b,c,d,e,f){f=f||{};f.name=c||Q("INNERTUBE_CONTEXT_CLIENT_NAME",1);f.version=d||Q("INNERTUBE_CONTEXT_CLIENT_VERSION",void 0);b=void 0===b?"ERROR":b;e=void 0===e?!1:e;b=void 0===b?"ERROR":b;e=window&&window.yterr||(void 0===e?!1:e)||!1;if(!(!a||!e||5<=Ye||(e=a.stacktrace,c=a.columnNumber,a.hasOwnProperty("params")&&(d=String(JSON.stringify(a.params)),f.params=d.substr(0,500)),a=Eb(a),e=e||a.stack,d=a.lineNumber.toString(),isNaN(d)||isNaN(c)||(d=d+":"+c),window.yterr&&y(window.yterr)&&window.yterr(a),
Xe[a.message]||0<=e.indexOf("/YouTubeCenter.js")||0<=e.indexOf("/mytube.js")))){b={Ua:{a:"logerror",t:"jserror",type:a.name,msg:a.message.substr(0,250),line:d,level:b,"client.name":f.name},B:{url:Q("PAGE_NAME",window.location.href),file:a.fileName},method:"POST"};f.version&&(b["client.version"]=f.version);e&&(b.B.stack=e);for(var g in f)b.B["client."+g]=f[g];if(g=Q("LATEST_ECATCHER_SERVICE_TRACKING_PARAMS",void 0))for(var h in g)b.B[h]=g[h];Le(Q("ECATCHER_REPORT_HOST","")+"/error_204",b);Xe[a.message]=
!0;Ye++}}
;var $e=window.yt&&window.yt.msgs_||window.ytcfg&&window.ytcfg.msgs||{};v("yt.msgs_",$e,void 0);function af(a){je($e,arguments)}
;function bf(a){a&&(a.dataset?a.dataset[cf("loaded")]="true":a.setAttribute("data-loaded","true"))}
function df(a,b){return a?a.dataset?a.dataset[cf(b)]:a.getAttribute("data-"+b):null}
var ef={};function cf(a){return ef[a]||(ef[a]=String(a).replace(/\-([a-z])/g,function(a,c){return c.toUpperCase()}))}
;var ff=w("ytPubsubPubsubInstance")||new N;N.prototype.subscribe=N.prototype.subscribe;N.prototype.unsubscribeByKey=N.prototype.K;N.prototype.publish=N.prototype.J;N.prototype.clear=N.prototype.clear;v("ytPubsubPubsubInstance",ff,void 0);var gf=w("ytPubsubPubsubSubscribedKeys")||{};v("ytPubsubPubsubSubscribedKeys",gf,void 0);var hf=w("ytPubsubPubsubTopicToKeys")||{};v("ytPubsubPubsubTopicToKeys",hf,void 0);var jf=w("ytPubsubPubsubIsSynchronous")||{};v("ytPubsubPubsubIsSynchronous",jf,void 0);
function kf(a,b){var c=lf();if(c){var d=c.subscribe(a,function(){var c=arguments;var f=function(){gf[d]&&b.apply(window,c)};
try{jf[a]?f():T(f,0)}catch(g){R(g)}},void 0);
gf[d]=!0;hf[a]||(hf[a]=[]);hf[a].push(d);return d}return 0}
function mf(a){var b=lf();b&&("number"==typeof a?a=[a]:t(a)&&(a=[parseInt(a,10)]),F(a,function(a){b.unsubscribeByKey(a);delete gf[a]}))}
function nf(a,b){var c=lf();c&&c.publish.apply(c,arguments)}
function of(a){var b=lf();if(b)if(b.clear(a),a)pf(a);else for(var c in hf)pf(c)}
function lf(){return w("ytPubsubPubsubInstance")}
function pf(a){hf[a]&&(a=hf[a],F(a,function(a){gf[a]&&delete gf[a]}),a.length=0)}
;var qf=/\.vflset|-vfl[a-zA-Z0-9_+=-]+/,rf=/-[a-zA-Z]{2,3}_[a-zA-Z]{2,3}(?=(\/|$))/;function sf(a,b,c){c=void 0===c?null:c;if(window.spf){c="";if(a){var d=a.indexOf("jsbin/"),e=a.lastIndexOf(".js"),f=d+6;-1<d&&-1<e&&e>f&&(c=a.substring(f,e),c=c.replace(qf,""),c=c.replace(rf,""),c=c.replace("debug-",""),c=c.replace("tracing-",""))}spf.script.load(a,c,b)}else tf(a,b,c)}
function tf(a,b,c){c=void 0===c?null:c;var d=uf(a),e=document.getElementById(d),f=e&&df(e,"loaded"),g=e&&!f;f?b&&b():(b&&(f=kf(d,b),b=""+(b[za]||(b[za]=++Aa)),vf[b]=f),g||(e=wf(a,d,function(){df(e,"loaded")||(bf(e),nf(d),T(Da(of,d),0))},c)))}
function wf(a,b,c,d){d=void 0===d?null:d;var e=document.createElement("SCRIPT");e.id=b;e.onload=function(){c&&setTimeout(c,0)};
e.onreadystatechange=function(){switch(e.readyState){case "loaded":case "complete":e.onload()}};
d&&e.setAttribute("nonce",d);Ub(e,dc(a));a=document.getElementsByTagName("head")[0]||document.body;a.insertBefore(e,a.firstChild);return e}
function xf(a){a=uf(a);var b=document.getElementById(a);b&&(of(a),b.parentNode.removeChild(b))}
function yf(a,b){if(a&&b){var c=""+(b[za]||(b[za]=++Aa));(c=vf[c])&&mf(c)}}
function uf(a){var b=document.createElement("a");Tb(b,a);a=b.href.replace(/^[a-zA-Z]+:\/\//,"//");return"js-"+Ya(a)}
var vf={};function zf(){}
function Af(a,b){return Bf(a,1,b)}
;function Cf(){}
n(Cf,zf);function Bf(a,b,c){isNaN(c)&&(c=void 0);var d=w("yt.scheduler.instance.addJob");return d?d(a,b,c):void 0===c?(a(),NaN):T(a,c||0)}
function Df(a){if(!isNaN(a)){var b=w("yt.scheduler.instance.cancelJob");b?b(a):U(a)}}
Cf.prototype.start=function(){var a=w("yt.scheduler.instance.start");a&&a()};
Cf.prototype.pause=function(){var a=w("yt.scheduler.instance.pause");a&&a()};
wa(Cf);Cf.getInstance();var Ef=[],Ff=!1;function Gf(){if("1"!=cb(me(),"args","privembed")){var a=function(){Ff=!0;"google_ad_status"in window?P("DCLKSTAT",1):P("DCLKSTAT",2)};
sf("//static.doubleclick.net/instream/ad_status.js",a);Ef.push(Af(function(){Ff||"google_ad_status"in window||(yf("//static.doubleclick.net/instream/ad_status.js",a),Ff=!0,P("DCLKSTAT",3))},5E3))}}
function Hf(){return parseInt(Q("DCLKSTAT",0),10)}
;function If(){this.c=!1;this.b=null}
If.prototype.initialize=function(a,b,c,d,e){var f=this;b?(this.c=!0,sf(b,function(){f.c=!1;if(window.botguard)Jf(f,c,d);else{xf(b);var a=Error("Unable to load Botguard");a.params="from "+b;ve(a)}},e)):a&&(eval(a),window.botguard?Jf(this,c,d):ve(Error("Unable to load Botguard from JS")))};
function Jf(a,b,c){try{a.b=new botguard.bg(b)}catch(d){ve(d)}c&&c(b)}
If.prototype.dispose=function(){this.b=null};var Kf=new If,Lf=!1,Mf=0,Nf="";function Of(a){S("botguard_periodic_refresh")?Mf=O():S("botguard_always_refresh")&&(Nf=a)}
function Pf(a){if(a){if(Kf.c)return!1;if(S("botguard_periodic_refresh"))return 72E5<O()-Mf;if(S("botguard_always_refresh"))return Nf!=a}else return!1;return!Lf}
function Qf(){return!!Kf.b}
function Rf(a){a=void 0===a?{}:a;a=void 0===a?{}:a;return Kf.b?Kf.b.invoke(void 0,void 0,a):null}
;var Sf=0;v("ytDomDomGetNextId",w("ytDomDomGetNextId")||function(){return++Sf},void 0);var Tf={stopImmediatePropagation:1,stopPropagation:1,preventMouseEvent:1,preventManipulation:1,preventDefault:1,layerX:1,layerY:1,screenX:1,screenY:1,scale:1,rotation:1,webkitMovementX:1,webkitMovementY:1};
function Uf(a){this.type="";this.state=this.source=this.data=this.currentTarget=this.relatedTarget=this.target=null;this.charCode=this.keyCode=0;this.metaKey=this.shiftKey=this.ctrlKey=this.altKey=!1;this.clientY=this.clientX=0;this.changedTouches=this.touches=null;if(a=a||window.event){this.event=a;for(var b in a)b in Tf||(this[b]=a[b]);(b=a.target||a.srcElement)&&3==b.nodeType&&(b=b.parentNode);this.target=b;if(b=a.relatedTarget)try{b=b.nodeName?b:null}catch(c){b=null}else"mouseover"==this.type?
b=a.fromElement:"mouseout"==this.type&&(b=a.toElement);this.relatedTarget=b;this.clientX=void 0!=a.clientX?a.clientX:a.pageX;this.clientY=void 0!=a.clientY?a.clientY:a.pageY;this.keyCode=a.keyCode?a.keyCode:a.which;this.charCode=a.charCode||("keypress"==this.type?this.keyCode:0);this.altKey=a.altKey;this.ctrlKey=a.ctrlKey;this.shiftKey=a.shiftKey;this.metaKey=a.metaKey;this.b=a.pageX;this.c=a.pageY}}
function Vf(a){if(document.body&&document.documentElement){var b=document.body.scrollTop+document.documentElement.scrollTop;a.b=a.clientX+(document.body.scrollLeft+document.documentElement.scrollLeft);a.c=a.clientY+b}}
Uf.prototype.preventDefault=function(){this.event&&(this.event.returnValue=!1,this.event.preventDefault&&this.event.preventDefault())};
Uf.prototype.stopPropagation=function(){this.event&&(this.event.cancelBubble=!0,this.event.stopPropagation&&this.event.stopPropagation())};
Uf.prototype.stopImmediatePropagation=function(){this.event&&(this.event.cancelBubble=!0,this.event.stopImmediatePropagation&&this.event.stopImmediatePropagation())};var eb=w("ytEventsEventsListeners")||{};v("ytEventsEventsListeners",eb,void 0);var Wf=w("ytEventsEventsCounter")||{count:0};v("ytEventsEventsCounter",Wf,void 0);
function Xf(a,b,c,d){d=void 0===d?{}:d;a.addEventListener&&("mouseenter"!=b||"onmouseenter"in document?"mouseleave"!=b||"onmouseenter"in document?"mousewheel"==b&&"MozBoxSizing"in document.documentElement.style&&(b="MozMousePixelScroll"):b="mouseout":b="mouseover");return db(function(e){var f="boolean"==typeof e[4]&&e[4]==!!d,g=z(e[4])&&z(d)&&hb(e[4],d);return!!e.length&&e[0]==a&&e[1]==b&&e[2]==c&&(f||g)})}
var Yf=Gb(function(){var a=!1;try{var b=Object.defineProperty({},"capture",{get:function(){a=!0}});
window.addEventListener("test",null,b)}catch(c){}return a});
function V(a,b,c,d){d=void 0===d?{}:d;if(!a||!a.addEventListener&&!a.attachEvent)return"";var e=Xf(a,b,c,d);if(e)return e;e=++Wf.count+"";var f=!("mouseenter"!=b&&"mouseleave"!=b||!a.addEventListener||"onmouseenter"in document);var g=f?function(d){d=new Uf(d);if(!cc(d.relatedTarget,function(b){return b==a}))return d.currentTarget=a,d.type=b,c.call(a,d)}:function(b){b=new Uf(b);
b.currentTarget=a;return c.call(a,b)};
g=ue(g);a.addEventListener?("mouseenter"==b&&f?b="mouseover":"mouseleave"==b&&f?b="mouseout":"mousewheel"==b&&"MozBoxSizing"in document.documentElement.style&&(b="MozMousePixelScroll"),Yf()||"boolean"==typeof d?a.addEventListener(b,g,d):a.addEventListener(b,g,!!d.capture)):a.attachEvent("on"+b,g);eb[e]=[a,b,c,g,d];return e}
function Zf(a){a&&("string"==typeof a&&(a=[a]),F(a,function(a){if(a in eb){var b=eb[a],d=b[0],e=b[1],f=b[3];b=b[4];d.removeEventListener?Yf()||"boolean"==typeof b?d.removeEventListener(e,f,b):d.removeEventListener(e,f,!!b.capture):d.detachEvent&&d.detachEvent("on"+e,f);delete eb[a]}}))}
;function $f(a){this.u=a;this.b=null;this.h=0;this.l=null;this.i=0;this.f=[];for(a=0;4>a;a++)this.f.push(0);this.g=0;this.C=V(window,"mousemove",A(this.F,this));a=A(this.A,this);y(a)&&(a=ue(a));this.G=window.setInterval(a,25)}
C($f,L);$f.prototype.F=function(a){r(a.b)||Vf(a);var b=a.b;r(a.c)||Vf(a);this.b=new Vb(b,a.c)};
$f.prototype.A=function(){if(this.b){var a=O();if(0!=this.h){var b=this.l,c=this.b,d=b.x-c.x;b=b.y-c.y;d=Math.sqrt(d*d+b*b)/(a-this.h);this.f[this.g]=.5<Math.abs((d-this.i)/this.i)?1:0;for(c=b=0;4>c;c++)b+=this.f[c]||0;3<=b&&this.u();this.i=d}this.h=a;this.l=this.b;this.g=(this.g+1)%4}};
$f.prototype.j=function(){window.clearInterval(this.G);Zf(this.C)};var ag={};
function bg(a){var b=void 0===a?{}:a;a=void 0===b.wa?!0:b.wa;b=void 0===b.Ja?!1:b.Ja;if(null==w("_lact",window)){var c=parseInt(Q("LACT"),10);c=isFinite(c)?B()-Math.max(c,0):-1;v("_lact",c,window);v("_fact",c,window);-1==c&&cg();V(document,"keydown",cg);V(document,"keyup",cg);V(document,"mousedown",cg);V(document,"mouseup",cg);a&&(b?V(window,"touchmove",function(){dg("touchmove",200)},{passive:!0}):(V(window,"resize",function(){dg("resize",200)}),V(window,"scroll",function(){dg("scroll",200)})));
new $f(function(){dg("mouse",100)});
V(document,"touchstart",cg,{passive:!0});V(document,"touchend",cg,{passive:!0})}}
function dg(a,b){ag[a]||(ag[a]=!0,Af(function(){cg();ag[a]=!1},b))}
function cg(){null==w("_lact",window)&&bg();var a=B();v("_lact",a,window);-1==w("_fact",window)&&v("_fact",a,window);(a=w("ytglobal.ytUtilActivityCallback_"))&&a()}
function eg(){var a=w("_lact",window);return null==a?-1:Math.max(B()-a,0)}
;var fg=Math.pow(2,16)-1,gg=null,hg=0,ig={log_event:"events",log_interaction:"interactions"},jg=Object.create(null);jg.log_event="GENERIC_EVENT_LOGGING";jg.log_interaction="INTERACTION_LOGGING";var kg=new Set(["log_event"]),lg={},mg=0,ng=0,W=w("ytLoggingTransportLogPayloadsQueue_")||{};v("ytLoggingTransportLogPayloadsQueue_",W,void 0);var og=w("ytLoggingTransportTokensToCttTargetIds_")||{};v("ytLoggingTransportTokensToCttTargetIds_",og,void 0);var pg=w("ytLoggingTransportDispatchedStats_")||{};
v("ytLoggingTransportDispatchedStats_",pg,void 0);v("ytytLoggingTransportCapturedTime_",w("ytLoggingTransportCapturedTime_")||{},void 0);function qg(){U(mg);U(ng);ng=0;if(!fb(W)){for(var a in W){var b=lg[a];b&&(rg(a,b),delete W[a])}fb(W)||sg()}}
function sg(){S("web_gel_timeout_cap")&&!ng&&(ng=T(qg,3E4));U(mg);mg=T(qg,Q("LOGGING_BATCH_TIMEOUT",1E4))}
function tg(a,b){b=void 0===b?"":b;W[a]=W[a]||{};W[a][b]=W[a][b]||[];return W[a][b]}
function rg(a,b){var c=ig[a],d=pg[a]||{};pg[a]=d;var e=Math.round(O());for(l in W[a]){var f=jb,g=b.b;g={client:{hl:g.Ca,gl:g.Ba,clientName:g.za,clientVersion:g.Aa}};var h=window.devicePixelRatio;h&&1!=h&&(g.client.screenDensityFloat=String(h));Q("DELEGATED_SESSION_ID")&&!S("pageid_as_header_web")&&(g.user={onBehalfOfUser:Q("DELEGATED_SESSION_ID")});f=f({context:g});f[c]=tg(a,l);d.dispatchedEventCount=d.dispatchedEventCount||0;d.dispatchedEventCount+=f[c].length;if(g=og[l])a:{var m=l;if(g.videoId)h=
"VIDEO";else if(g.playlistId)h="PLAYLIST";else break a;f.credentialTransferTokenTargetId=g;f.context=f.context||{};f.context.user=f.context.user||{};f.context.user.credentialTransferTokens=[{token:m,scope:h}]}delete og[l];f.requestTimeMs=e;if(g=le("EVENT_ID"))h=(Q("BATCH_CLIENT_COUNTER",void 0)||0)+1,h>fg&&(h=1),P("BATCH_CLIENT_COUNTER",h),g={serializedEventId:g,clientCounter:h},f.serializedClientEventId=g,gg&&hg&&S("log_gel_rtt_web")&&(f.previousBatchInfo={serializedClientEventId:gg,roundtripMs:hg}),
gg=g,hg=0;ug(b,a,f,{retry:kg.has(a),onSuccess:A(vg,this,O())})}if(d.previousDispatchMs){c=e-d.previousDispatchMs;var l=d.diffCount||0;d.averageTimeBetweenDispatchesMs=l?(d.averageTimeBetweenDispatchesMs*l+c)/(l+1):c;d.diffCount=l+1}d.previousDispatchMs=e}
function vg(a){hg=Math.round(O()-a)}
;function wg(a,b,c,d,e){var f={};f.eventTimeMs=Math.round(d||O());f[a]=b;f.context={lastActivityMs:String(d?-1:eg())};e?(a={},e.videoId?a.videoId=e.videoId:e.playlistId&&(a.playlistId=e.playlistId),og[e.token]=a,e=tg("log_event",e.token)):e=tg("log_event");e.push(f);c&&(lg.log_event=new c);e.length>=(Number(S("web_logging_max_batch")||0)||20)?qg():sg()}
;function xg(a,b,c){c=void 0===c?{}:c;var d={"X-Goog-Visitor-Id":c.visitorData||Q("VISITOR_DATA","")};if(b&&b.includes("www.youtube-nocookie.com"))return d;(b=c.ib||Q("AUTHORIZATION"))||(a?b="Bearer "+w("gapi.auth.getToken")().hb:b=Mc([]));b&&(d.Authorization=b,d["X-Goog-AuthUser"]=Q("SESSION_INDEX",0),S("pageid_as_header_web")&&(d["X-Goog-PageId"]=Q("DELEGATED_SESSION_ID")));return d}
function yg(a){a=Object.assign({},a);delete a.Authorization;var b=Mc();if(b){var c=new bd;c.update(Q("INNERTUBE_API_KEY",void 0));c.update(b);b=c.digest();ya(b);if(!Ab)for(Ab={},Bb={},c=0;65>c;c++)Ab[c]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(c),Bb[c]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.".charAt(c);c=Bb;for(var d=[],e=0;e<b.length;e+=3){var f=b[e],g=e+1<b.length,h=g?b[e+1]:0,m=e+2<b.length,l=m?b[e+2]:0,u=f>>2;f=(f&3)<<4|h>>4;h=(h&15)<<
2|l>>6;l&=63;m||(l=64,g||(h=64));d.push(c[u],c[f],c[h],c[l])}a.hash=d.join("")}return a}
;function zg(a,b,c,d){Db.set(""+a,b,c,"/",void 0===d?"youtube.com":d,!1)}
;function Ag(){var a=new ae;(a=a.isAvailable()?new ge(a,"yt.innertube"):null)||(a=new be("yt.innertube"),a=a.isAvailable()?a:null);this.b=a?new Xd(a):null;this.c=document.domain||window.location.hostname}
Ag.prototype.set=function(a,b,c,d){c=c||31104E3;this.remove(a);if(this.b)try{this.b.set(a,b,B()+1E3*c);return}catch(f){}var e="";if(d)try{e=escape(sd(b))}catch(f){return}else e=escape(b);zg(a,e,c,this.c)};
Ag.prototype.get=function(a,b){var c=void 0,d=!this.b;if(!d)try{c=this.b.get(a)}catch(e){d=!0}if(d&&(c=Db.get(""+a,void 0))&&(c=unescape(c),b))try{c=JSON.parse(c)}catch(e){this.remove(a),c=void 0}return c};
Ag.prototype.remove=function(a){this.b&&this.b.remove(a);var b=this.c;Db.remove(""+a,"/",void 0===b?"youtube.com":b)};var Bg=new Ag;function Cg(a,b,c,d){if(d)return null;d=Bg.get("nextId",!0)||1;var e=Bg.get("requests",!0)||{};e[d]={method:a,request:b,authState:yg(c),requestTime:Math.round(O())};Bg.set("nextId",d+1,86400,!0);Bg.set("requests",e,86400,!0);return d}
function Dg(a){var b=Bg.get("requests",!0)||{};delete b[a];Bg.set("requests",b,86400,!0)}
function Eg(a){var b=Bg.get("requests",!0);if(b){for(var c in b){var d=b[c];if(!(6E4>Math.round(O())-d.requestTime)){var e=d.authState,f=yg(xg(!1));hb(e,f)&&(e=d.request,"requestTimeMs"in e&&(e.requestTimeMs=Math.round(O())),ug(a,d.method,e,{}));delete b[c]}}Bg.set("requests",b,86400,!0)}}
;function Fg(a){var b=this;this.b=a||{xa:le("INNERTUBE_API_KEY"),ya:le("INNERTUBE_API_VERSION"),za:Q("INNERTUBE_CONTEXT_CLIENT_NAME","WEB"),Aa:le("INNERTUBE_CONTEXT_CLIENT_VERSION"),Ca:le("INNERTUBE_CONTEXT_HL"),Ba:le("INNERTUBE_CONTEXT_GL"),Da:le("INNERTUBE_HOST_OVERRIDE")||"",Ea:!!Q("INNERTUBE_USE_THIRD_PARTY_AUTH",!1)};Bf(function(){Eg(b)},0,5E3)}
function ug(a,b,c,d){!Q("VISITOR_DATA")&&.01>Math.random()&&R(Error("Missing VISITOR_DATA when sending innertube request."),"WARNING");var e={headers:{"Content-Type":"application/json"},method:"POST",B:c,ha:"JSON",L:function(){d.L()},
ga:d.L,onSuccess:function(a,b){if(d.onSuccess)d.onSuccess(b)},
fa:function(a){if(d.onSuccess)d.onSuccess(a)},
onError:function(a,b){if(d.onError)d.onError(b)},
nb:function(a){if(d.onError)d.onError(a)},
timeout:d.timeout,withCredentials:!0},f="",g=a.b.Da;g&&(f=g);g=a.b.Ea||!1;var h=xg(g,f,d);Object.assign(e.headers,h);e.headers.Authorization&&!f&&(e.headers["x-origin"]=window.location.origin);var m=""+f+("/youtubei/"+a.b.ya+"/"+b)+"?alt=json&key="+a.b.xa,l;if(d.retry&&S("retry_web_logging_batches")&&"www.youtube-nocookie.com"!=f&&(l=Cg(b,c,h,g))){var u=e.onSuccess,ea=e.fa;e.onSuccess=function(a,b){Dg(l);u(a,b)};
c.fa=function(a,b){Dg(l);ea(a,b)}}try{S("use_fetch_for_op_xhr")?Ie(m,e):Re(m,e)}catch(Cd){if("InvalidAccessError"==Cd)l&&(Dg(l),l=0),R(Error("An extension is blocking network request."),"WARNING");
else throw Cd;}l&&Bf(function(){Eg(a)},0,5E3)}
;var Gg=B().toString();
function Hg(){a:{if(window.crypto&&window.crypto.getRandomValues)try{var a=Array(16),b=new Uint8Array(16);window.crypto.getRandomValues(b);for(var c=0;c<a.length;c++)a[c]=b[c];var d=a;break a}catch(e){}d=Array(16);for(a=0;16>a;a++){b=B();for(c=0;c<b%23;c++)d[a]=Math.random();d[a]=Math.floor(256*Math.random())}if(Gg)for(a=1,b=0;b<Gg.length;b++)d[a%16]=d[a%16]^d[(a-1)%16]/4^Gg.charCodeAt(b),a++}a=[];for(b=0;b<d.length;b++)a.push("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_".charAt(d[b]&63));
return a.join("")}
;var Ig=w("ytLoggingTimeDocumentNonce_")||Hg();v("ytLoggingTimeDocumentNonce_",Ig,void 0);function Jg(a){this.b=a}
function Kg(a){var b={};void 0!==a.b.trackingParams?b.trackingParams=a.b.trackingParams:(b.veType=a.b.veType,null!=a.b.veCounter&&(b.veCounter=a.b.veCounter),null!=a.b.elementIndex&&(b.elementIndex=a.b.elementIndex));void 0!==a.b.dataElement&&(b.dataElement=Kg(a.b.dataElement));void 0!==a.b.youtubeData&&(b.youtubeData=a.b.youtubeData);return b}
Jg.prototype.toString=function(){return JSON.stringify(Kg(this))};
var Lg=1;function Mg(a){a=void 0===a?0:a;return 0==a?"client-screen-nonce":"client-screen-nonce."+a}
function Ng(a){a=void 0===a?0:a;return 0==a?"ROOT_VE_TYPE":"ROOT_VE_TYPE."+a}
function Og(a){return Q(Ng(void 0===a?0:a),void 0)}
v("yt_logging_screen.getRootVeType",Og,void 0);function Pg(){var a=Og(0),b;a?b=new Jg({veType:a,youtubeData:void 0}):b=null;return b}
function Qg(a){a=void 0===a?0:a;var b=Q(Mg(a));b||0!=a||(b=Q("EVENT_ID"));return b?b:null}
v("yt_logging_screen.getCurrentCsn",Qg,void 0);function Rg(a,b,c){c=void 0===c?0:c;if(a!==Q(Mg(c))||b!==Q(Ng(c)))P(Mg(c),a),P(Ng(c),b),0==c&&(b=function(){setTimeout(function(){a&&wg("foregroundHeartbeatScreenAssociated",{clientDocumentNonce:Ig,clientScreenNonce:a},Fg)},0)},"requestAnimationFrame"in window?window.requestAnimationFrame(b):b())}
v("yt_logging_screen.setCurrentScreen",Rg,void 0);function Sg(a,b,c){b=void 0===b?{}:b;c=void 0===c?!1:c;var d=Q("EVENT_ID");d&&(b.ei||(b.ei=d));if(b){d=a;var e=Q("VALID_SESSION_TEMPDATA_DOMAINS",[]),f=I(J(3,window.location.href));f&&e.push(f);f=I(J(3,d));if(0<=Ga(e,f)||!f&&0==d.lastIndexOf("/",0))if(S("autoescape_tempdata_url")&&(e=document.createElement("a"),Tb(e,d),d=e.href),d){f=d.match(oc);d=f[5];e=f[6];f=f[7];var g="";d&&(g+=d);e&&(g+="?"+e);f&&(g+="#"+f);d=g;e=d.indexOf("#");if(d=0>e?d:d.substr(0,e)){if(b.itct||b.ved)b.csn=b.csn||Qg();if(h){var h=
parseInt(h,10);isFinite(h)&&0<h&&(d="ST-"+Ya(d).toString(36),b=b?qc(b):"",zg(d,b,h||5))}else h="ST-"+Ya(d).toString(36),b=b?qc(b):"",zg(h,b,5)}}}if(c)return!1;if((window.ytspf||{}).enabled)spf.navigate(a);else{var m=void 0===m?{}:m;var l=void 0===l?"":l;var u=void 0===u?window:u;c=u.location;a=rc(a,m)+l;a=a instanceof H?a:Ob(a);c.href=Mb(a)}return!0}
;function Tg(a,b,c){a={csn:a,parentVe:Kg(b),childVes:Ia(c,function(a){return Kg(a)})};
wg("visualElementAttached",a,Fg,void 0,void 0)}
;function Ug(a){a=a||{};var b={enablejsapi:1},c={};this.url=a.url||"";this.args=a.args||ib(b);this.assets=a.assets||{};this.attrs=a.attrs||ib(c);this.fallback=a.fallback||null;this.fallbackMessage=a.fallbackMessage||null;this.html5=!!a.html5;this.disable=a.disable||{};this.loaded=!!a.loaded;this.messages=a.messages||{}}
Ug.prototype.clone=function(){var a=new Ug,b;for(b in this)if(this.hasOwnProperty(b)){var c=this[b];"object"==xa(c)?a[b]=ib(c):a[b]=c}return a};function Vg(){L.call(this);this.b=[]}
n(Vg,L);Vg.prototype.j=function(){for(;this.b.length;){var a=this.b.pop();a.target.removeEventListener(a.name,a.kb)}L.prototype.j.call(this)};var Wg=/cssbin\/(?:debug-)?([a-zA-Z0-9_-]+?)(?:-2x|-web|-rtl|-vfl|.css)/;function Xg(a){a=a||"";if(window.spf){var b=a.match(Wg);spf.style.load(a,b?b[1]:"",void 0)}else Yg(a)}
function Yg(a){var b=Zg(a),c=document.getElementById(b),d=c&&df(c,"loaded");d||c&&!d||(c=$g(a,b,function(){df(c,"loaded")||(bf(c),nf(b),T(Da(of,b),0))}))}
function $g(a,b,c){var d=document.createElement("link");d.id=b;d.onload=function(){c&&setTimeout(c,0)};
a=dc(a);d.rel="stylesheet";d.href=Kb(a);(document.getElementsByTagName("head")[0]||document.body).appendChild(d);return d}
function Zg(a){var b=document.createElement("A");a=Pb(a);Tb(b,a);b=b.href.replace(/^[a-zA-Z]+:\/\//,"//");return"css-"+Ya(b)}
;function ah(a,b){L.call(this);this.i=this.R=a;this.C=b;this.l=!1;this.api={};this.O=this.A=null;this.F=new N;dd(this,Da(ed,this.F));this.g={};this.M=this.P=this.f=this.W=this.b=null;this.G=!1;this.h=this.u=null;this.T={};this.la=["onReady"];this.V=null;this.da=NaN;this.N={};bh(this);this.U("WATCH_LATER_VIDEO_ADDED",this.Ga.bind(this));this.U("WATCH_LATER_VIDEO_REMOVED",this.Ha.bind(this));this.U("onAdAnnounce",this.oa.bind(this));this.ma=new Vg(this);dd(this,Da(ed,this.ma))}
n(ah,L);k=ah.prototype;
k.loadNewVideoConfig=function(a){if(!this.c){a instanceof Ug||(a=new Ug(a));this.W=a;this.b=a.clone();this.f=this.b.attrs.id||this.f;"video-player"==this.f&&(this.f=this.C,this.b.attrs.id=this.C);this.i.id==this.f&&(this.f+="-player",this.b.attrs.id=this.f);this.b.args.enablejsapi="1";this.b.args.playerapiid=this.C;this.P||(this.P=ch(this,this.b.args.jsapicallback||"onYouTubePlayerReady"));this.b.args.jsapicallback=null;if(a=this.b.attrs.width)this.i.style.width=mc(Number(a)||a);if(a=this.b.attrs.height)this.i.style.height=
mc(Number(a)||a);dh(this);this.l&&eh(this)}};
k.sa=function(){return this.W};
function eh(a){a.b.loaded||(a.b.loaded=!0,"0"!=a.b.args.autoplay?a.api.loadVideoByPlayerVars(a.b.args):a.api.cueVideoByPlayerVars(a.b.args))}
function fh(a){var b=!0,c=gh(a);c&&a.b&&(a=a.b,b=df(c,"version")==a.assets.js);return b&&!!w("yt.player.Application.create")}
function dh(a){if(!a.c&&!a.G){var b=fh(a);if(b&&"html5"==(gh(a)?"html5":null))a.M="html5",a.l||hh(a);else if(ih(a),a.M="html5",b&&a.h)a.R.appendChild(a.h),hh(a);else{a.b.loaded=!0;var c=!1;a.u=function(){c=!0;var b=a.b.clone();w("yt.player.Application.create")(a.R,b);hh(a)};
a.G=!0;b?a.u():(sf(a.b.assets.js,a.u),Xg(a.b.assets.css),jh(a)&&!c&&v("yt.player.Application.create",null,void 0))}}}
function gh(a){var b=Xb(a.f);!b&&a.i&&a.i.querySelector&&(b=a.i.querySelector("#"+a.f));return b}
function hh(a){if(!a.c){var b=gh(a),c=!1;b&&b.getApiInterface&&b.getApiInterface()&&(c=!0);c?(a.G=!1,b.isNotServable&&b.isNotServable(a.b.args.video_id)||kh(a)):a.da=T(function(){hh(a)},50)}}
function kh(a){bh(a);a.l=!0;var b=gh(a);b.addEventListener&&(a.A=lh(a,b,"addEventListener"));b.removeEventListener&&(a.O=lh(a,b,"removeEventListener"));var c=b.getApiInterface();c=c.concat(b.getInternalApiInterface());for(var d=0;d<c.length;d++){var e=c[d];a.api[e]||(a.api[e]=lh(a,b,e))}for(var f in a.g)a.A(f,a.g[f]);eh(a);a.P&&a.P(a.api);a.F.J("onReady",a.api)}
function lh(a,b,c){var d=b[c];return function(){try{return a.V=null,d.apply(b,arguments)}catch(e){"sendAbandonmentPing"!=c&&(e.message+=" ("+c+")",a.V=e,ve(e))}}}
function bh(a){a.l=!1;if(a.O)for(var b in a.g)a.O(b,a.g[b]);for(var c in a.N)U(parseInt(c,10));a.N={};a.A=null;a.O=null;for(var d in a.api)a.api[d]=null;a.api.addEventListener=a.U.bind(a);a.api.removeEventListener=a.La.bind(a);a.api.destroy=a.dispose.bind(a);a.api.getLastError=a.ta.bind(a);a.api.getPlayerType=a.ua.bind(a);a.api.getCurrentVideoConfig=a.sa.bind(a);a.api.loadNewVideoConfig=a.loadNewVideoConfig.bind(a);a.api.isReady=a.Fa.bind(a)}
k.Fa=function(){return this.l};
k.U=function(a,b){var c=this,d=ch(this,b);if(d){if(!(0<=Ga(this.la,a)||this.g[a])){var e=mh(this,a);this.A&&this.A(a,e)}this.F.subscribe(a,d);"onReady"==a&&this.l&&T(function(){d(c.api)},0)}};
k.La=function(a,b){if(!this.c){var c=ch(this,b);c&&Rd(this.F,a,c)}};
function ch(a,b){var c=b;if("string"==typeof b){if(a.T[b])return a.T[b];c=function(){var a=w(b);a&&a.apply(q,arguments)};
a.T[b]=c}return c?c:null}
function mh(a,b){var c="ytPlayer"+b+a.C;a.g[b]=c;q[c]=function(c){var d=T(function(){if(!a.c){a.F.J(b,c);var e=a.N,g=String(d);g in e&&delete e[g]}},0);
gb(a.N,String(d))};
return c}
k.oa=function(a){nf("a11y-announce",a)};
k.Ga=function(a){nf("WATCH_LATER_VIDEO_ADDED",a)};
k.Ha=function(a){nf("WATCH_LATER_VIDEO_REMOVED",a)};
k.ua=function(){return this.M||(gh(this)?"html5":null)};
k.ta=function(){return this.V};
function ih(a){a.cancel();bh(a);a.M=null;a.b&&(a.b.loaded=!1);var b=gh(a);b&&(fh(a)||!jh(a)?a.h=b:(b&&b.destroy&&b.destroy(),a.h=null));for(a=a.R;b=a.firstChild;)a.removeChild(b)}
k.cancel=function(){this.u&&yf(this.b.assets.js,this.u);U(this.da);this.G=!1};
k.j=function(){ih(this);if(this.h&&this.b&&this.h.destroy)try{this.h.destroy()}catch(b){R(b)}this.T=null;for(var a in this.g)q[this.g[a]]=null;this.W=this.b=this.api=null;delete this.R;delete this.i;L.prototype.j.call(this)};
function jh(a){return a.b&&a.b.args&&a.b.args.fflags?-1!=a.b.args.fflags.indexOf("player_destroy_old_version=true"):!1}
;var nh={},oh="player_uid_"+(1E9*Math.random()>>>0);function ph(a){var b="player";b=t(b)?Xb(b):b;var c=oh+"_"+(b[za]||(b[za]=++Aa)),d=nh[c];if(d)return d.loadNewVideoConfig(a),d.api;d=new ah(b,c);nh[c]=d;nf("player-added",d.api);dd(d,Da(qh,d));T(function(){d.loadNewVideoConfig(a)},0);
return d.api}
function qh(a){delete nh[a.C]}
;function rh(a,b,c){var d=Fg;Q("ytLoggingEventsDefaultDisabled",!1)&&Fg==Fg&&(d=null);wg(a,b,d,c,void 0)}
;var sh=w("ytLoggingLatencyUsageStats_")||{};v("ytLoggingLatencyUsageStats_",sh,void 0);var th=0;function uh(a){sh[a]=sh[a]||{count:0};var b=sh[a];b.count++;b.time=O();th||(th=Bf(vh,0,5E3));if(10<b.count){if(11==b.count){b=0==a.indexOf("info")?"WARNING":"ERROR";var c=Error("CSI data exceeded logging limit with key");c.params=a;Ze(c,b)}return!0}return!1}
function vh(){var a=O(),b;for(b in sh)6E4<a-sh[b].time&&delete sh[b];th=0}
;function wh(a,b){this.version=a;this.args=b}
;function xh(a){this.topic=a}
xh.prototype.toString=function(){return this.topic};var yh=w("ytPubsub2Pubsub2Instance")||new N;N.prototype.subscribe=N.prototype.subscribe;N.prototype.unsubscribeByKey=N.prototype.K;N.prototype.publish=N.prototype.J;N.prototype.clear=N.prototype.clear;v("ytPubsub2Pubsub2Instance",yh,void 0);v("ytPubsub2Pubsub2SubscribedKeys",w("ytPubsub2Pubsub2SubscribedKeys")||{},void 0);v("ytPubsub2Pubsub2TopicToKeys",w("ytPubsub2Pubsub2TopicToKeys")||{},void 0);v("ytPubsub2Pubsub2IsAsync",w("ytPubsub2Pubsub2IsAsync")||{},void 0);
v("ytPubsub2Pubsub2SkipSubKey",null,void 0);function zh(a,b){var c=w("ytPubsub2Pubsub2Instance");c&&c.publish.call(c,a.toString(),a,b)}
;var X=window.performance||window.mozPerformance||window.msPerformance||window.webkitPerformance||{};function Ah(){var a=Q("TIMING_TICK_EXPIRATION");a||(a={},P("TIMING_TICK_EXPIRATION",a));return a}
function Bh(){var a=Ah(),b;for(b in a)Df(a[b]);P("TIMING_TICK_EXPIRATION",{})}
;function Ch(a,b){wh.call(this,1,arguments)}
n(Ch,wh);function Dh(a,b){wh.call(this,1,arguments)}
n(Dh,wh);var Eh=new xh("aft-recorded"),Fh=new xh("timing-sent");var Gh={vc:!0},Y={},Hh=(Y.ad_allowed="adTypesAllowed",Y.yt_abt="adBreakType",Y.ad_cpn="adClientPlaybackNonce",Y.ad_docid="adVideoId",Y.yt_ad_an="adNetworks",Y.ad_at="adType",Y.browse_id="browseId",Y.p="httpProtocol",Y.t="transportProtocol",Y.cpn="clientPlaybackNonce",Y.csn="clientScreenNonce",Y.docid="videoId",Y.is_continuation="isContinuation",Y.is_nav="isNavigation",Y.b_p="kabukiInfo.browseParams",Y.is_prefetch="kabukiInfo.isPrefetch",Y.is_secondary_nav="kabukiInfo.isSecondaryNav",Y.prev_browse_id=
"kabukiInfo.prevBrowseId",Y.query_source="kabukiInfo.querySource",Y.voz_type="kabukiInfo.vozType",Y.yt_lt="loadType",Y.yt_ad="isMonetized",Y.nr="webInfo.navigationReason",Y.ncnp="webInfo.nonPreloadedNodeCount",Y.paused="playerInfo.isPausedOnLoad",Y.yt_pt="playerType",Y.fmt="playerInfo.itag",Y.yt_pl="watchInfo.isPlaylist",Y.yt_ad_pr="prerollAllowed",Y.pa="previousAction",Y.yt_red="isRedSubscriber",Y.st="serverTimeMs",Y.aq="tvInfo.appQuality",Y.br_trs="tvInfo.bedrockTriggerState",Y.label="tvInfo.label",
Y.is_mdx="tvInfo.isMdx",Y.preloaded="tvInfo.isPreloaded",Y.query="unpluggedInfo.query",Y.upg_chip_ids_string="unpluggedInfo.upgChipIdsString",Y.yt_vst="videoStreamType",Y.vph="viewportHeight",Y.vpw="viewportWidth",Y.yt_vis="isVisible",Y),Ih="ap c cver cbrand cmodel ei srt yt_fss yt_li plid vpil vpni vpst yt_eil vpni2 vpil2 icrc icrt pa GetBrowse_rid GetPlayer_rid GetSearch_rid GetWatchNext_rid cmt d_vpct d_vpnfi d_vpni pc pfa pfeh pftr prerender psc rc start tcrt tcrc ssr vpr vps yt_abt yt_fn yt_fs yt_pft yt_pre yt_pt yt_pvis yt_ref yt_sts".split(" "),
Jh="isContinuation isNavigation kabukiInfo.isPrefetch kabukiInfo.isSecondaryNav isMonetized playerInfo.isPausedOnLoad prerollAllowed isRedSubscriber tvInfo.isMdx tvInfo.isPreloaded isVisible watchInfo.isPlaylist".split(" "),Kh={},Lh=(Kh.pa="LATENCY_ACTION_",Kh.yt_pt="LATENCY_PLAYER_",Kh.yt_vst="VIDEO_STREAM_TYPE_",Kh),Mh=!1;
function Nh(){var a=Oh().info.yt_lt="hot_bg";Ph().info_yt_lt=a;if(Qh())if("yt_lt"in Hh){var b=Hh.yt_lt;0<=Ga(Jh,b)&&(a=!!a);"yt_lt"in Lh&&(a=Lh.yt_lt+a.toUpperCase());var c=a;if(Qh()){a={};b=b.split(".");for(var d=a,e=0;e<b.length-1;e++)d[b[e]]=d[b[e]]||{},d=d[b[e]];d[b[b.length-1]]=c;c=Rh();b=Object.keys(a).join("");uh("info_"+b+"_"+c)||(a.clientActionNonce=c,rh("latencyActionInfo",a))}}else 0<=Ga(Ih,"yt_lt")||R(Error("Unknown label yt_lt logged with GEL CSI."))}
function Sh(){var a=Th();if(a.aft)return a.aft;for(var b=Q("TIMING_AFT_KEYS",["ol"]),c=b.length,d=0;d<c;d++){var e=a[b[d]];if(e)return e}return NaN}
A(X.clearResourceTimings||X.webkitClearResourceTimings||X.mozClearResourceTimings||X.msClearResourceTimings||X.oClearResourceTimings||va,X);function Rh(){var a=Oh().nonce;a||(a=Hg(),Oh().nonce=a);return a}
function Th(){return Oh().tick}
function Ph(){var a=Oh();"gel"in a||(a.gel={});return a.gel}
function Oh(){var a;(a=w("ytcsi.data_"))||(a={tick:{},info:{}},Ea("ytcsi.data_",a));return a}
function Uh(){var a=Th(),b=a.pbr,c=a.vc;a=a.pbs;return b&&c&&a&&b<c&&c<a&&1==Oh().info.yt_pvis}
function Qh(){return!!S("csi_on_gel")||!!Oh().useGel}
function Vh(){Bh();if(!Qh()){var a=Th(),b=Oh().info,c=a._start;for(f in a)if(0==f.lastIndexOf("_",0)&&x(a[f])){var d=f.slice(1);if(d in Gh){var e=Ia(a[f],function(a){return Math.round(a-c)});
b["all_"+d]=e.join()}delete a[f]}e=Q("CSI_SERVICE_NAME","youtube");var f={v:2,s:e,action:Q("TIMING_ACTION",void 0)};d=Nh.srt;void 0!==a.srt&&delete b.srt;if(b.h5jse){var g=window.location.protocol+w("ytplayer.config.assets.js");(g=X.getEntriesByName?X.getEntriesByName(g)[0]:null)?b.h5jse=Math.round(b.h5jse-g.responseEnd):delete b.h5jse}a.aft=Sh();Uh()&&"youtube"==e&&(Nh(),e=a.vc,g=a.pbs,delete a.aft,b.aft=Math.round(g-e));for(var h in b)"_"!=h.charAt(0)&&(f[h]=b[h]);a.ps=O();h={};e=[];for(var m in a)"_"!=
m.charAt(0)&&(g=Math.round(a[m]-c),h[m]=g,e.push(m+"."+g));f.rt=e.join(",");(a=w("ytdebug.logTiming"))&&a(f,h);Wh(f,!!b.ap);zh(Fh,new Dh(h.aft+(d||0),void 0))}}
function Wh(a,b){if(S("debug_csi_data")){var c=w("yt.timing.csiData");c||(c=[],v("yt.timing.csiData",c,void 0));c.push({page:location.href,time:new Date,args:a})}c="";for(var d in a)c+="&"+d+"="+a[d];d="/csi_204?"+c.substring(1);if(window.navigator&&window.navigator.sendBeacon&&b){var e=void 0===e?"":e;Ve(d,e)||Ue(d,void 0,void 0,void 0,e)}else Ue(d);Ea("yt.timing.pingSent_",!0)}
;function Xh(a){return(0==a.search("cue")||0==a.search("load"))&&"loadModule"!=a}
function Yh(a,b,c){t(a)&&(a={mediaContentUrl:a,startSeconds:b,suggestedQuality:c});b=/\/([ve]|embed)\/([^#?]+)/.exec(a.mediaContentUrl);a.videoId=b&&b[2]?b[2]:null;return Zh(a)}
function Zh(a,b,c){if(z(a)){b=["endSeconds","startSeconds","mediaContentUrl","suggestedQuality","videoId"];c={};for(var d=0;d<b.length;d++){var e=b[d];a[e]&&(c[e]=a[e])}return c}return{videoId:a,startSeconds:b,suggestedQuality:c}}
function $h(a,b,c,d){if(z(a)&&!x(a)){b="playlist list listType index startSeconds suggestedQuality".split(" ");c={};for(d=0;d<b.length;d++){var e=b[d];a[e]&&(c[e]=a[e])}return c}b={index:b,startSeconds:c,suggestedQuality:d};t(a)&&16==a.length?b.list="PL"+a:b.playlist=a;return b}
;function ai(a){L.call(this);this.b=a;this.b.subscribe("command",this.ia,this);this.f={};this.h=!1}
C(ai,L);k=ai.prototype;k.start=function(){this.h||this.c||(this.h=!0,bi(this.b,"RECEIVING"))};
k.ia=function(a,b,c){if(this.h&&!this.c){var d=b||{};switch(a){case "addEventListener":t(d.event)&&(a=d.event,a in this.f||(c=A(this.Na,this,a),this.f[a]=c,this.addEventListener(a,c)));break;case "removeEventListener":t(d.event)&&ci(this,d.event);break;default:this.g.isReady()&&this.g.isExternalMethodAvailable(a,c||null)&&(b=di(a,b||{}),c=this.g.handleExternalCall(a,b,c||null),(c=ei(a,c))&&this.h&&!this.c&&bi(this.b,a,c))}}};
k.Na=function(a,b){this.h&&!this.c&&bi(this.b,a,this.Y(a,b))};
k.Y=function(a,b){if(null!=b)return{value:b}};
function ci(a,b){b in a.f&&(a.removeEventListener(b,a.f[b]),delete a.f[b])}
k.j=function(){var a=this.b;a.c||Rd(a.b,"command",this.ia,this);this.b=null;for(var b in this.f)ci(this,b);ai.w.j.call(this)};function fi(a,b){ai.call(this,b);this.g=a;this.start()}
C(fi,ai);fi.prototype.addEventListener=function(a,b){this.g.addEventListener(a,b)};
fi.prototype.removeEventListener=function(a,b){this.g.removeEventListener(a,b)};
function di(a,b){switch(a){case "loadVideoById":return b=Zh(b),[b];case "cueVideoById":return b=Zh(b),[b];case "loadVideoByPlayerVars":return[b];case "cueVideoByPlayerVars":return[b];case "loadPlaylist":return b=$h(b),[b];case "cuePlaylist":return b=$h(b),[b];case "seekTo":return[b.seconds,b.allowSeekAhead];case "playVideoAt":return[b.index];case "setVolume":return[b.volume];case "setPlaybackQuality":return[b.suggestedQuality];case "setPlaybackRate":return[b.suggestedRate];case "setLoop":return[b.loopPlaylists];
case "setShuffle":return[b.shufflePlaylist];case "getOptions":return[b.module];case "getOption":return[b.module,b.option];case "setOption":return[b.module,b.option,b.value];case "handleGlobalKeyDown":return[b.keyCode,b.shiftKey,b.ctrlKey,b.altKey,b.metaKey]}return[]}
function ei(a,b){switch(a){case "isMuted":return{muted:b};case "getVolume":return{volume:b};case "getPlaybackRate":return{playbackRate:b};case "getAvailablePlaybackRates":return{availablePlaybackRates:b};case "getVideoLoadedFraction":return{videoLoadedFraction:b};case "getPlayerState":return{playerState:b};case "getCurrentTime":return{currentTime:b};case "getPlaybackQuality":return{playbackQuality:b};case "getAvailableQualityLevels":return{availableQualityLevels:b};case "getDuration":return{duration:b};
case "getVideoUrl":return{videoUrl:b};case "getVideoEmbedCode":return{videoEmbedCode:b};case "getPlaylist":return{playlist:b};case "getPlaylistIndex":return{playlistIndex:b};case "getOptions":return{options:b};case "getOption":return{option:b}}}
fi.prototype.Y=function(a,b){switch(a){case "onReady":return;case "onStateChange":return{playerState:b};case "onPlaybackQualityChange":return{playbackQuality:b};case "onPlaybackRateChange":return{playbackRate:b};case "onError":return{errorCode:b}}return fi.w.Y.call(this,a,b)};
fi.prototype.j=function(){fi.w.j.call(this);delete this.g};function gi(a,b,c,d){L.call(this);this.f=b||null;this.u="*";this.g=c||null;this.sessionId=null;this.channel=d||null;this.C=!!a;this.l=A(this.A,this);window.addEventListener("message",this.l)}
n(gi,L);gi.prototype.A=function(a){if(!("*"!=this.g&&a.origin!=this.g||this.f&&a.source!=this.f)&&t(a.data)){try{var b=JSON.parse(a.data)}catch(c){return}if(!(null==b||this.C&&(this.sessionId&&this.sessionId!=b.id||this.channel&&this.channel!=b.channel))&&b)switch(b.event){case "listening":"null"!=a.origin&&(this.g=this.u=a.origin);this.f=a.source;this.sessionId=b.id;this.b&&(this.b(),this.b=null);break;case "command":this.h&&(!this.i||0<=Ga(this.i,b.func))&&this.h(b.func,b.args,a.origin)}}};
gi.prototype.sendMessage=function(a,b){var c=b||this.f;if(c){this.sessionId&&(a.id=this.sessionId);this.channel&&(a.channel=this.channel);try{var d=sd(a);c.postMessage(d,this.u)}catch(e){R(e,"WARNING")}}};
gi.prototype.j=function(){window.removeEventListener("message",this.l);L.prototype.j.call(this)};function hi(a,b,c){gi.call(this,a,b,c||Q("POST_MESSAGE_ORIGIN",void 0)||window.document.location.protocol+"//"+window.document.location.hostname,"widget");this.i=this.b=this.h=null}
n(hi,gi);function ii(){var a=this.c=new hi(!!Q("WIDGET_ID_ENFORCE")),b=A(this.Ka,this);a.h=b;a.i=null;this.c.channel="widget";if(a=Q("WIDGET_ID"))this.c.sessionId=a;this.g=[];this.i=!1;this.h={}}
k=ii.prototype;k.Ka=function(a,b,c){"addEventListener"==a&&b?(a=b[0],this.h[a]||"onReady"==a||(this.addEventListener(a,ji(this,a)),this.h[a]=!0)):this.ka(a,b,c)};
k.ka=function(){};
function ji(a,b){return A(function(a){this.sendMessage(b,a)},a)}
k.addEventListener=function(){};
k.ra=function(){this.i=!0;this.sendMessage("initialDelivery",this.Z());this.sendMessage("onReady");F(this.g,this.ja,this);this.g=[]};
k.Z=function(){return null};
function ki(a,b){a.sendMessage("infoDelivery",b)}
k.ja=function(a){this.i?this.c.sendMessage(a):this.g.push(a)};
k.sendMessage=function(a,b){this.ja({event:a,info:void 0==b?null:b})};
k.dispose=function(){this.c=null};function li(a){ii.call(this);this.b=a;this.f=[];this.addEventListener("onReady",A(this.Ia,this));this.addEventListener("onVideoProgress",A(this.Ra,this));this.addEventListener("onVolumeChange",A(this.Sa,this));this.addEventListener("onApiChange",A(this.Ma,this));this.addEventListener("onPlaybackQualityChange",A(this.Oa,this));this.addEventListener("onPlaybackRateChange",A(this.Pa,this));this.addEventListener("onStateChange",A(this.Qa,this));this.addEventListener("onWebglSettingsChanged",A(this.Ta,
this))}
C(li,ii);k=li.prototype;k.ka=function(a,b,c){if(this.b.isExternalMethodAvailable(a,c)){b=b||[];if(0<b.length&&Xh(a)){var d=b;if(z(d[0])&&!x(d[0]))d=d[0];else{var e={};switch(a){case "loadVideoById":case "cueVideoById":e=Zh.apply(window,d);break;case "loadVideoByUrl":case "cueVideoByUrl":e=Yh.apply(window,d);break;case "loadPlaylist":case "cuePlaylist":e=$h.apply(window,d)}d=e}b.length=1;b[0]=d}this.b.handleExternalCall(a,b,c);Xh(a)&&ki(this,this.Z())}};
k.Ia=function(){var a=A(this.ra,this);this.c.b=a};
k.addEventListener=function(a,b){this.f.push({eventType:a,listener:b});this.b.addEventListener(a,b)};
k.Z=function(){if(!this.b)return null;var a=this.b.getApiInterface();La(a,"getVideoData");for(var b={apiInterface:a},c=0,d=a.length;c<d;c++){var e=a[c],f=e;if(0==f.search("get")||0==f.search("is")){f=e;var g=0;0==f.search("get")?g=3:0==f.search("is")&&(g=2);f=f.charAt(g).toLowerCase()+f.substr(g+1);try{var h=this.b[e]();b[f]=h}catch(m){}}}b.videoData=this.b.getVideoData();b.currentTimeLastUpdated_=B()/1E3;return b};
k.Qa=function(a){a={playerState:a,currentTime:this.b.getCurrentTime(),duration:this.b.getDuration(),videoData:this.b.getVideoData(),videoStartBytes:0,videoBytesTotal:this.b.getVideoBytesTotal(),videoLoadedFraction:this.b.getVideoLoadedFraction(),playbackQuality:this.b.getPlaybackQuality(),availableQualityLevels:this.b.getAvailableQualityLevels(),currentTimeLastUpdated_:B()/1E3,playbackRate:this.b.getPlaybackRate(),mediaReferenceTime:this.b.getMediaReferenceTime()};this.b.getVideoUrl&&(a.videoUrl=
this.b.getVideoUrl());this.b.getVideoContentRect&&(a.videoContentRect=this.b.getVideoContentRect());this.b.getProgressState&&(a.progressState=this.b.getProgressState());this.b.getPlaylist&&(a.playlist=this.b.getPlaylist());this.b.getPlaylistIndex&&(a.playlistIndex=this.b.getPlaylistIndex());this.b.getStoryboardFormat&&(a.storyboardFormat=this.b.getStoryboardFormat());ki(this,a)};
k.Oa=function(a){ki(this,{playbackQuality:a})};
k.Pa=function(a){ki(this,{playbackRate:a})};
k.Ma=function(){for(var a=this.b.getOptions(),b={namespaces:a},c=0,d=a.length;c<d;c++){var e=a[c],f=this.b.getOptions(e);b[e]={options:f};for(var g=0,h=f.length;g<h;g++){var m=f[g],l=this.b.getOption(e,m);b[e][m]=l}}this.sendMessage("apiInfoDelivery",b)};
k.Sa=function(){ki(this,{muted:this.b.isMuted(),volume:this.b.getVolume()})};
k.Ra=function(a){a={currentTime:a,videoBytesLoaded:this.b.getVideoBytesLoaded(),videoLoadedFraction:this.b.getVideoLoadedFraction(),currentTimeLastUpdated_:B()/1E3,playbackRate:this.b.getPlaybackRate(),mediaReferenceTime:this.b.getMediaReferenceTime()};this.b.getProgressState&&(a.progressState=this.b.getProgressState());ki(this,a)};
k.Ta=function(){var a={sphericalProperties:this.b.getSphericalProperties()};ki(this,a)};
k.dispose=function(){li.w.dispose.call(this);for(var a=0;a<this.f.length;a++){var b=this.f[a];this.b.removeEventListener(b.eventType,b.listener)}this.f=[]};function mi(a){a=void 0===a?!1:a;L.call(this);this.b=new N(a);dd(this,Da(ed,this.b))}
C(mi,L);mi.prototype.subscribe=function(a,b,c){return this.c?0:this.b.subscribe(a,b,c)};
mi.prototype.h=function(a,b){this.c||this.b.J.apply(this.b,arguments)};function ni(a,b,c){mi.call(this);this.f=a;this.g=b;this.i=c}
C(ni,mi);function bi(a,b,c){if(!a.c){var d=a.f;d.c||a.g!=d.b||(a={id:a.i,command:b},c&&(a.data=c),d.b.postMessage(sd(a),d.g))}}
ni.prototype.j=function(){this.g=this.f=null;ni.w.j.call(this)};function oi(a,b,c){L.call(this);this.b=a;this.g=c;this.h=V(window,"message",A(this.i,this));this.f=new ni(this,a,b);dd(this,Da(ed,this.f))}
C(oi,L);oi.prototype.i=function(a){var b;if(b=!this.c)if(b=a.origin==this.g)a:{b=this.b;do{b:{var c=a.source;do{if(c==b){c=!0;break b}if(c==c.parent)break;c=c.parent}while(null!=c);c=!1}if(c){b=!0;break a}b=b.opener}while(null!=b);b=!1}if(b&&(b=a.data,t(b))){try{b=JSON.parse(b)}catch(d){return}b.command&&(c=this.f,c.c||c.h("command",b.command,b.data,a.origin))}};
oi.prototype.j=function(){Zf(this.h);this.b=null;oi.w.j.call(this)};function pi(){var a=ib(qi),b;return Gd(new M(function(c,d){a.onSuccess=function(a){ye(a)?c(a):d(new ri("Request failed, status="+a.status,"net.badstatus",a))};
a.onError=function(a){d(new ri("Unknown request error","net.unknown",a))};
a.L=function(a){d(new ri("Request timed out","net.timeout",a))};
b=Le("//googleads.g.doubleclick.net/pagead/id",a)}),function(a){a instanceof Hd&&b.abort();
return Ed(a)})}
function ri(a,b){E.call(this,a+", errorCode="+b);this.errorCode=b;this.name="PromiseAjaxError"}
n(ri,E);function si(){this.c=0;this.b=null}
si.prototype.then=function(a,b,c){return 1===this.c&&a?(a=a.call(c,this.b),yd(a)?a:ti(a)):2===this.c&&b?(a=b.call(c,this.b),yd(a)?a:ui(a)):this};
si.prototype.getValue=function(){return this.b};
si.prototype.$goog_Thenable=!0;function ui(a){var b=new si;a=void 0===a?null:a;b.c=2;b.b=void 0===a?null:a;return b}
function ti(a){var b=new si;a=void 0===a?null:a;b.c=1;b.b=void 0===a?null:a;return b}
;function vi(a){E.call(this,a.message||a.description||a.name);this.isMissing=a instanceof wi;this.isTimeout=a instanceof ri&&"net.timeout"==a.errorCode;this.isCanceled=a instanceof Hd}
n(vi,E);vi.prototype.name="BiscottiError";function wi(){E.call(this,"Biscotti ID is missing from server")}
n(wi,E);wi.prototype.name="BiscottiMissingError";var qi={format:"RAW",method:"GET",timeout:5E3,withCredentials:!0},xi=null;function oe(){if("1"===cb(me(),"args","privembed"))return Ed(Error("Biscotti ID is not available in private embed mode"));xi||(xi=Gd(pi().then(yi),function(a){return zi(2,a)}));
return xi}
function yi(a){a=a.responseText;if(0!=a.lastIndexOf(")]}'",0))throw new wi;a=JSON.parse(a.substr(4));if(1<(a.type||1))throw new wi;a=a.id;pe(a);xi=ti(a);Ai(18E5,2);return a}
function zi(a,b){var c=new vi(b);pe("");xi=ui(c);0<a&&Ai(12E4,a-1);throw c;}
function Ai(a,b){T(function(){Gd(pi().then(yi,function(a){return zi(b,a)}),va)},a)}
function Bi(){try{var a=w("yt.ads.biscotti.getId_");return a?a():oe()}catch(b){return Ed(b)}}
;function Ci(a){if("1"!==cb(me(),"args","privembed")){a&&ne();try{Bi().then(function(a){a=qe(a);a.bsq=Di++;Re("//www.youtube.com/ad_data_204",{va:!1,B:a,withCredentials:!0})},function(){}),T(Ci,18E5)}catch(b){R(b)}}}
var Di=0;var Z=w("ytglobal.prefsUserPrefsPrefs_")||{};v("ytglobal.prefsUserPrefsPrefs_",Z,void 0);function Ei(){this.b=Q("ALT_PREF_COOKIE_NAME","PREF");var a=Db.get(""+this.b,void 0);if(a){a=decodeURIComponent(a).split("&");for(var b=0;b<a.length;b++){var c=a[b].split("="),d=c[0];(c=c[1])&&(Z[d]=c.toString())}}}
k=Ei.prototype;k.get=function(a,b){Fi(a);Gi(a);var c=void 0!==Z[a]?Z[a].toString():null;return null!=c?c:b?b:""};
k.set=function(a,b){Fi(a);Gi(a);if(null==b)throw Error("ExpectedNotNull");Z[a]=b.toString()};
k.remove=function(a){Fi(a);Gi(a);delete Z[a]};
k.save=function(){zg(this.b,this.dump(),63072E3)};
k.clear=function(){for(var a in Z)delete Z[a]};
k.dump=function(){var a=[],b;for(b in Z)a.push(b+"="+encodeURIComponent(String(Z[b])));return a.join("&")};
function Gi(a){if(/^f([1-9][0-9]*)$/.test(a))throw Error("ExpectedRegexMatch: "+a);}
function Fi(a){if(!/^\w+$/.test(a))throw Error("ExpectedRegexMismatch: "+a);}
function Hi(a){a=void 0!==Z[a]?Z[a].toString():null;return null!=a&&/^[A-Fa-f0-9]+$/.test(a)?parseInt(a,16):null}
wa(Ei);var Ii=null,Ji=null,Ki=null,Li={};function Mi(a){var b=a.id;a=a.ve_type;var c=Lg++;a=new Jg({veType:a,veCounter:c,elementIndex:void 0,dataElement:void 0,youtubeData:void 0});Li[b]=a;b=Qg();c=Pg();b&&c&&Tg(b,c,[a])}
function Ni(a){var b=a.csn;a=a.root_ve_type;if(b&&a&&(Rg(b,a),a=Pg()))for(var c in Li){var d=Li[c];d&&Tg(b,a,[d])}}
function Oi(a){Li[a.id]=new Jg({trackingParams:a.tracking_params})}
function Pi(a){var b=Qg();a=Li[a.id];b&&a&&wg("visualElementGestured",{csn:b,ve:Kg(a),gestureType:"INTERACTION_LOGGING_GESTURE_TYPE_GENERIC_CLICK"},Fg,void 0,void 0)}
function Qi(a){a=a.ids;var b=Qg();if(b)for(var c=0;c<a.length;c++){var d=Li[a[c]];d&&wg("visualElementShown",{csn:b,ve:Kg(d),eventType:1},Fg,void 0,void 0)}}
function Ri(){var a=Ii;a&&a.startInteractionLogging&&a.startInteractionLogging()}
;v("yt.setConfig",P,void 0);v("yt.config.set",P,void 0);v("yt.setMsg",af,void 0);v("yt.msgs.set",af,void 0);v("yt.logging.errors.log",Ze,void 0);
v("writeEmbed",function(){var a=Q("PLAYER_CONFIG",void 0);Ci(!0);"gvn"==a.args.ps&&(document.body.style.backgroundColor="transparent");var b=document.referrer,c=Q("POST_MESSAGE_ORIGIN");window!=window.top&&b&&b!=document.URL&&(a.args.loaderUrl=b);Q("LIGHTWEIGHT_AUTOPLAY")&&(a.args.autoplay="1");Ii=a=ph(a);a.addEventListener("onScreenChanged",Ni);a.addEventListener("onLogClientVeCreated",Mi);a.addEventListener("onLogServerVeCreated",Oi);a.addEventListener("onLogVeClicked",Pi);a.addEventListener("onLogVesShown",
Qi);a.addEventListener("onReady",Ri);b=Q("POST_MESSAGE_ID","player");Q("ENABLE_JS_API")?Ki=new li(a):Q("ENABLE_POST_API")&&t(b)&&t(c)&&(Ji=new oi(window.parent,b,c),Ki=new fi(a,Ji.f));c=le("BG_P");Pf(c)&&(Q("BG_I")||Q("BG_IU"))&&(Lf=!0,Kf.initialize(Q("BG_I",null),Q("BG_IU",null),c,Of,void 0));Gf()},void 0);
v("yt.www.watch.ads.restrictioncookie.spr",function(a){Ue(a+"mac_204?action_fcts=1");return!0},void 0);
var Si=ue(function(){var a="ol";X.mark&&(0==a.lastIndexOf("mark_",0)||(a="mark_"+a),X.mark(a));a=Th();var b=O();a.ol&&(a._ol=a._ol||[a.ol],a._ol.push(b));a.ol=b;a=Ah();if(b=a.ol)Df(b),a.ol=0;Ph().tick_ol=void 0;O();Qh()?(a=Rh(),uh("tick_ol_"+a)||rh("latencyActionTicked",{tickName:"ol",clientActionNonce:a},void 0),a=!0):a=!1;if(a=!a)a=!w("yt.timing.pingSent_");if(a&&(b=Q("TIMING_ACTION",void 0),a=Th(),w("ytglobal.timingready_")&&b&&a._start&&(b=Sh()))){Mh||(zh(Eh,new Ch(Math.round(b-a._start),void 0)),
Mh=!0);b=!0;var c=Q("TIMING_WAIT",[]);if(c.length)for(var d=0,e=c.length;d<e;++d)if(!(c[d]in a)){b=!1;break}b&&Vh()}a=Ei.getInstance();c=!!((Hi("f"+(Math.floor(119/31)+1))||0)&67108864);b=1<window.devicePixelRatio;document.body&&hd(document.body,"exp-invert-logo")&&(b&&!hd(document.body,"inverted-hdpi")?(d=document.body,d.classList?d.classList.add("inverted-hdpi"):hd(d,"inverted-hdpi")||(d.className+=0<d.className.length?" inverted-hdpi":"inverted-hdpi")):!b&&hd(document.body,"inverted-hdpi")&&id());
c!=b&&(c="f"+(Math.floor(119/31)+1),d=Hi(c)||0,d=b?d|67108864:d&-67108865,0==d?delete Z[c]:(b=d.toString(16),Z[c]=b.toString()),a.save())}),Ti=ue(function(){var a=Ii;
a&&a.sendAbandonmentPing&&a.sendAbandonmentPing();Q("PL_ATT")&&Kf.dispose();a=0;for(var b=Ef.length;a<b;a++)Df(Ef[a]);Ef.length=0;xf("//static.doubleclick.net/instream/ad_status.js");Ff=!1;P("DCLKSTAT",0);fd(Ki,Ji);if(a=Ii)a.removeEventListener("onScreenChanged",Ni),a.removeEventListener("onLogClientVeCreated",Mi),a.removeEventListener("onLogServerVeCreated",Oi),a.removeEventListener("onLogVeClicked",Pi),a.removeEventListener("onLogVesShown",Qi),a.removeEventListener("onReady",Ri),a.destroy();Li=
{}});
window.addEventListener?(window.addEventListener("load",Si),window.addEventListener("unload",Ti)):window.attachEvent&&(window.attachEvent("onload",Si),window.attachEvent("onunload",Ti));Ea("yt.abuse.player.botguardInitialized",w("yt.abuse.player.botguardInitialized")||Qf);Ea("yt.abuse.player.invokeBotguard",w("yt.abuse.player.invokeBotguard")||Rf);Ea("yt.abuse.dclkstatus.checkDclkStatus",w("yt.abuse.dclkstatus.checkDclkStatus")||Hf);
Ea("yt.player.exports.navigate",w("yt.player.exports.navigate")||Sg);Ea("yt.util.activity.init",w("yt.util.activity.init")||bg);Ea("yt.util.activity.getTimeSinceActive",w("yt.util.activity.getTimeSinceActive")||eg);Ea("yt.util.activity.setTimestamp",w("yt.util.activity.setTimestamp")||cg);}).call(this);
