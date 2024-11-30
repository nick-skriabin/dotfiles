"use strict";var I=Object.create;var d=Object.defineProperty;var J=Object.getOwnPropertyDescriptor;var K=Object.getOwnPropertyNames;var z=Object.getPrototypeOf,B=Object.prototype.hasOwnProperty;var V=(n,e)=>()=>(e||n((e={exports:{}}).exports,e),e.exports),Z=(n,e)=>{for(var t in e)d(n,t,{get:e[t],enumerable:!0})},O=(n,e,t,a)=>{if(e&&typeof e=="object"||typeof e=="function")for(let r of K(e))!B.call(n,r)&&r!==t&&d(n,r,{get:()=>e[r],enumerable:!(a=J(e,r))||a.enumerable});return n};var G=(n,e,t)=>(t=n!=null?I(z(n)):{},O(e||!n||!n.__esModule?d(t,"default",{value:n,enumerable:!0}):t,n)),_=n=>O(d({},"__esModule",{value:!0}),n);var j=V(T=>{T.version="0.1.0";var U=function(e){this.message=e,this.toString=function(){return this.constructor.name+": "+this.message}},M=function(e){this.firstWeekDay=e||0};M.prototype={constructor:M,weekStartDate:function(e){for(var t=new Date(e.getTime());t.getDay()!==this.firstWeekDay;)t.setDate(t.getDate()-1);return t},monthDates:function(e,t,a,r){if(typeof e!="number"||e<1970)throw new U("year must be a number >= 1970");if(typeof t!="number"||t<0||t>11)throw new U("month must be a number (Jan is 0)");var u=[],l=[],h=0,s=this.weekStartDate(new Date(e,t,1));do{for(h=0;h<7;h++)l.push(a?a(s):s),s=new Date(s.getTime()),s.setDate(s.getDate()+1);u.push(r?r(l):l),l=[]}while(s.getMonth()<=t&&s.getFullYear()===e);return u},monthDays:function(e,t){var a=function(u){return u.getMonth()===t?u.getDate():0};return this.monthDates(e,t,a)},monthText:function(e,t){if(typeof e>"u"){var a=new Date;e=a.getFullYear(),t=a.getMonth()}var r=function(h){for(var s=h.getMonth()===t?h.getDate().toString():"  ";s.length<2;)s=" "+s;return s},u=this.monthDates(e,t,r,function(l){return l.join(" ")});return u.join(`
`)}};var W="JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC".split(" ");for(p=0;p<W.length;p++)M[W[p]]=p;var p;T.Calendar=M});var X={};Z(X,{default:()=>L});module.exports=_(X);var o=require("@raycast/api"),m=require("react"),R=G(j());var H=(n,e)=>(n.getTimezoneOffset()-e.getTimezoneOffset())*6e4;var x=(n=new Date)=>{let e=(n.getDay()+6)%7,t=new Date(n);t.setDate(n.getDate()-e+3);let a=new Date(t.getFullYear(),0,1);return a.getDay()!==4&&a.setMonth(0,1+(11-a.getDay())%7),1+Math.floor((t-a+H(a,t))/6048e5)},v=(n=new Date)=>{let e=new Date(n);e.setDate(n.getDate()-n.getDay());let t=new Date(e.getFullYear(),0,1);return t.getDay()!==0&&t.setMonth(0,1+(7-t.getDay())%7),1+Math.floor((e-t+H(t,e))/6048e5)};var i=require("react/jsx-runtime"),q=[["SUN","MON","TUE","WED","THU","FRI","SAT"],["MON","TUE","WED","THU","FRI","SAT","SUN"]],b=Number((0,o.getPreferenceValues)().weekStart),y=(0,o.getPreferenceValues)().showWeeks,Q=(0,o.getPreferenceValues)().viewMode,C=new Date(new Date().getFullYear(),new Date().getMonth(),1);function L(){let[n,e]=(0,m.useState)(""),[t,a]=(0,m.useState)(""),[r,u]=(0,m.useState)(C);(0,m.useEffect)(()=>{let w=new R.Calendar(b).monthDates(r.getFullYear(),r.getMonth()),P=new Date().toDateString(),$=r.toLocaleString("en",{month:"long",year:"numeric"}),N=q[b];if(Q==1){let Y=w.map(g=>{let f=y?`| **${b===0?v(g[0]):x(g[0])}** |`:"|";return f+=g.map(c=>{let D=c.getMonth()===r.getMonth()?c.getDate().toString():" ",F=c.toDateString()===P&&D!==" "?"**\u2022 ":" ";return`${F}${D}${F!==" "?"**":""} |`}).join(""),`${f}
`}).join(""),S=y?"| **#** |":"|",A=N.map(g=>`**${g}**`).join(" |"),E=`${y?"| :---: |":"|"}${N.map(()=>":---:").join(" |")}`;a($),e(`# ${$}
${S}${A} |
${E} |
${Y}`)}else{let Y=w.map(g=>{let f="";if(y){let c="";b==0?c=v(g[0]).toString():c=x(g[0]).toString(),f+="`"+c+" ".repeat(2-c.length)+"`    "}return f+=g.map(c=>{let D=c.getMonth()===r.getMonth()?c.getDate().toString():"";return c.toDateString()===P&&D!==""?"`\u2022"+" ".repeat(3-D.length)+D+"` ":"`"+" ".repeat(4-D.length)+D+"` "}).join(""),`${f}
`}).join(`

`),S=r.toLocaleString("en",{month:"long",year:"numeric"}),A=y?"`# `    ":"",E=N.map(g=>`\` ${g}\``).join(" ");a(S),e("# "+S+`
***
`+A+E+`

`+Y)}},[r]);let l=k=>{let w=new Date(r.getFullYear(),r.getMonth()+k,1);u(w)},h=k=>{let w=new Date(r.getFullYear()+k,r.getMonth(),1);u(w)},s=()=>{r===C?(0,o.showToast)(o.Toast.Style.Success,"Current month is on screen"):u(C)};return(0,i.jsx)(o.Detail,{markdown:n,actions:(0,i.jsxs)(o.ActionPanel,{children:[(0,i.jsxs)(o.ActionPanel.Section,{title:t,children:[(0,i.jsx)(o.Action,{title:"Current Month",shortcut:{modifiers:[],key:"c"},icon:{source:{dark:"up-dark.png",light:"up.png"}},onAction:()=>s()}),(0,i.jsx)(o.Action.CopyToClipboard,{content:n})]}),(0,i.jsxs)(o.ActionPanel.Section,{title:"Change Month",children:[(0,i.jsx)(o.Action,{title:"Previous Month",shortcut:{modifiers:[],key:"arrowLeft"},icon:{source:{dark:"left-dark.png",light:"left.png"}},onAction:()=>l(-1)}),(0,i.jsx)(o.Action,{title:"Next Month",shortcut:{modifiers:[],key:"arrowRight"},icon:{source:{dark:"right-dark.png",light:"right.png"}},onAction:()=>l(1)})]}),(0,i.jsxs)(o.ActionPanel.Section,{title:"Change Year",children:[(0,i.jsx)(o.Action,{title:"Previous Year",shortcut:{modifiers:["shift"],key:"arrowLeft"},icon:{source:{dark:"double-left-dark.png",light:"double-left.png"}},onAction:()=>h(-1)}),(0,i.jsx)(o.Action,{title:"Next Year",shortcut:{modifiers:["shift"],key:"arrowRight"},icon:{source:{dark:"double-right-dark.png",light:"double-right.png"}},onAction:()=>h(1)})]}),(0,i.jsx)(o.ActionPanel.Section,{children:(0,i.jsx)(o.Action,{title:"Open Extension Preferences",onAction:o.openExtensionPreferences,shortcut:{modifiers:["cmd","shift"],key:","}})})]})})}
/*! Bundled license information:

calendar/lib/calendar.js:
  (*!
   * calendar.js: inspired by the calendar module from Python
   * Copyright(c) 2011 Luciano Ramalho <luciano@ramalho.org>
   * MIT Licensed
   *)

weeknumber/src/index.js:
  (*!
   * weeknumber
   * @author commenthol
   * @license Unlicense
   *)
*/
