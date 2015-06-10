
<!DOCTYPE html>
<!-- saved from url=(0014)about:internet -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<title>StatR 101: Lab 11</title>

<style type="text/css">
body, td {
   font-family: sans-serif;
   background-color: white;
   font-size: 12px;
   margin: 8px;
}

tt, code, pre {
   font-family: 'DejaVu Sans Mono', 'Droid Sans Mono', 'Lucida Console', Consolas, Monaco, monospace;
}

h1 { 
   font-size:2.2em; 
}

h2 { 
   font-size:1.8em; 
}

h3 { 
   font-size:1.4em; 
}

h4 { 
   font-size:1.0em; 
}

h5 { 
   font-size:0.9em; 
}

h6 { 
   font-size:0.8em; 
}

a:visited {
   color: rgb(50%, 0%, 50%);
}

pre {	
   margin-top: 0;
   max-width: 95%;
   border: 1px solid #ccc;
   white-space: pre-wrap;
}

pre code {
   display: block; padding: 0.5em;
}

code.r, code.cpp {
   background-color: #F8F8F8;
}

table, td, th {
  border: none;
}

blockquote {
   color:#666666;
   margin:0;
   padding-left: 1em;
   border-left: 0.5em #EEE solid;
}

hr {
   height: 0px;
   border-bottom: none;
   border-top-width: thin;
   border-top-style: dotted;
   border-top-color: #999999;
}

@media print {
   * { 
      background: transparent !important; 
      color: black !important; 
      filter:none !important; 
      -ms-filter: none !important; 
   }

   body { 
      font-size:12pt; 
      max-width:100%; 
   }
       
   a, a:visited { 
      text-decoration: underline; 
   }

   hr { 
      visibility: hidden;
      page-break-before: always;
   }

   pre, blockquote { 
      padding-right: 1em; 
      page-break-inside: avoid; 
   }

   tr, img { 
      page-break-inside: avoid; 
   }

   img { 
      max-width: 100% !important; 
   }

   @page :left { 
      margin: 15mm 20mm 15mm 10mm; 
   }
     
   @page :right { 
      margin: 15mm 10mm 15mm 20mm; 
   }

   p, h2, h3 { 
      orphans: 3; widows: 3; 
   }

   h2, h3 { 
      page-break-after: avoid; 
   }
}

</style>

<!-- Styles for R syntax highlighter -->
<style type="text/css">
   pre .operator,
   pre .paren {
     color: rgb(104, 118, 135)
   }

   pre .literal {
     color: rgb(88, 72, 246)
   }

   pre .number {
     color: rgb(0, 0, 205);
   }

   pre .comment {
     color: rgb(76, 136, 107);
   }

   pre .keyword {
     color: rgb(0, 0, 255);
   }

   pre .identifier {
     color: rgb(0, 0, 0);
   }

   pre .string {
     color: rgb(3, 106, 7);
   }
</style>

<!-- R syntax highlighter -->
<script type="text/javascript">
var hljs=new function(){function m(p){return p.replace(/&/gm,"&amp;").replace(/</gm,"&lt;")}function f(r,q,p){return RegExp(q,"m"+(r.cI?"i":"")+(p?"g":""))}function b(r){for(var p=0;p<r.childNodes.length;p++){var q=r.childNodes[p];if(q.nodeName=="CODE"){return q}if(!(q.nodeType==3&&q.nodeValue.match(/\s+/))){break}}}function h(t,s){var p="";for(var r=0;r<t.childNodes.length;r++){if(t.childNodes[r].nodeType==3){var q=t.childNodes[r].nodeValue;if(s){q=q.replace(/\n/g,"")}p+=q}else{if(t.childNodes[r].nodeName=="BR"){p+="\n"}else{p+=h(t.childNodes[r])}}}if(/MSIE [678]/.test(navigator.userAgent)){p=p.replace(/\r/g,"\n")}return p}function a(s){var r=s.className.split(/\s+/);r=r.concat(s.parentNode.className.split(/\s+/));for(var q=0;q<r.length;q++){var p=r[q].replace(/^language-/,"");if(e[p]){return p}}}function c(q){var p=[];(function(s,t){for(var r=0;r<s.childNodes.length;r++){if(s.childNodes[r].nodeType==3){t+=s.childNodes[r].nodeValue.length}else{if(s.childNodes[r].nodeName=="BR"){t+=1}else{if(s.childNodes[r].nodeType==1){p.push({event:"start",offset:t,node:s.childNodes[r]});t=arguments.callee(s.childNodes[r],t);p.push({event:"stop",offset:t,node:s.childNodes[r]})}}}}return t})(q,0);return p}function k(y,w,x){var q=0;var z="";var s=[];function u(){if(y.length&&w.length){if(y[0].offset!=w[0].offset){return(y[0].offset<w[0].offset)?y:w}else{return w[0].event=="start"?y:w}}else{return y.length?y:w}}function t(D){var A="<"+D.nodeName.toLowerCase();for(var B=0;B<D.attributes.length;B++){var C=D.attributes[B];A+=" "+C.nodeName.toLowerCase();if(C.value!==undefined&&C.value!==false&&C.value!==null){A+='="'+m(C.value)+'"'}}return A+">"}while(y.length||w.length){var v=u().splice(0,1)[0];z+=m(x.substr(q,v.offset-q));q=v.offset;if(v.event=="start"){z+=t(v.node);s.push(v.node)}else{if(v.event=="stop"){var p,r=s.length;do{r--;p=s[r];z+=("</"+p.nodeName.toLowerCase()+">")}while(p!=v.node);s.splice(r,1);while(r<s.length){z+=t(s[r]);r++}}}}return z+m(x.substr(q))}function j(){function q(x,y,v){if(x.compiled){return}var u;var s=[];if(x.k){x.lR=f(y,x.l||hljs.IR,true);for(var w in x.k){if(!x.k.hasOwnProperty(w)){continue}if(x.k[w] instanceof Object){u=x.k[w]}else{u=x.k;w="keyword"}for(var r in u){if(!u.hasOwnProperty(r)){continue}x.k[r]=[w,u[r]];s.push(r)}}}if(!v){if(x.bWK){x.b="\\b("+s.join("|")+")\\s"}x.bR=f(y,x.b?x.b:"\\B|\\b");if(!x.e&&!x.eW){x.e="\\B|\\b"}if(x.e){x.eR=f(y,x.e)}}if(x.i){x.iR=f(y,x.i)}if(x.r===undefined){x.r=1}if(!x.c){x.c=[]}x.compiled=true;for(var t=0;t<x.c.length;t++){if(x.c[t]=="self"){x.c[t]=x}q(x.c[t],y,false)}if(x.starts){q(x.starts,y,false)}}for(var p in e){if(!e.hasOwnProperty(p)){continue}q(e[p].dM,e[p],true)}}function d(B,C){if(!j.called){j();j.called=true}function q(r,M){for(var L=0;L<M.c.length;L++){if((M.c[L].bR.exec(r)||[null])[0]==r){return M.c[L]}}}function v(L,r){if(D[L].e&&D[L].eR.test(r)){return 1}if(D[L].eW){var M=v(L-1,r);return M?M+1:0}return 0}function w(r,L){return L.i&&L.iR.test(r)}function K(N,O){var M=[];for(var L=0;L<N.c.length;L++){M.push(N.c[L].b)}var r=D.length-1;do{if(D[r].e){M.push(D[r].e)}r--}while(D[r+1].eW);if(N.i){M.push(N.i)}return f(O,M.join("|"),true)}function p(M,L){var N=D[D.length-1];if(!N.t){N.t=K(N,E)}N.t.lastIndex=L;var r=N.t.exec(M);return r?[M.substr(L,r.index-L),r[0],false]:[M.substr(L),"",true]}function z(N,r){var L=E.cI?r[0].toLowerCase():r[0];var M=N.k[L];if(M&&M instanceof Array){return M}return false}function F(L,P){L=m(L);if(!P.k){return L}var r="";var O=0;P.lR.lastIndex=0;var M=P.lR.exec(L);while(M){r+=L.substr(O,M.index-O);var N=z(P,M);if(N){x+=N[1];r+='<span class="'+N[0]+'">'+M[0]+"</span>"}else{r+=M[0]}O=P.lR.lastIndex;M=P.lR.exec(L)}return r+L.substr(O,L.length-O)}function J(L,M){if(M.sL&&e[M.sL]){var r=d(M.sL,L);x+=r.keyword_count;return r.value}else{return F(L,M)}}function I(M,r){var L=M.cN?'<span class="'+M.cN+'">':"";if(M.rB){y+=L;M.buffer=""}else{if(M.eB){y+=m(r)+L;M.buffer=""}else{y+=L;M.buffer=r}}D.push(M);A+=M.r}function G(N,M,Q){var R=D[D.length-1];if(Q){y+=J(R.buffer+N,R);return false}var P=q(M,R);if(P){y+=J(R.buffer+N,R);I(P,M);return P.rB}var L=v(D.length-1,M);if(L){var O=R.cN?"</span>":"";if(R.rE){y+=J(R.buffer+N,R)+O}else{if(R.eE){y+=J(R.buffer+N,R)+O+m(M)}else{y+=J(R.buffer+N+M,R)+O}}while(L>1){O=D[D.length-2].cN?"</span>":"";y+=O;L--;D.length--}var r=D[D.length-1];D.length--;D[D.length-1].buffer="";if(r.starts){I(r.starts,"")}return R.rE}if(w(M,R)){throw"Illegal"}}var E=e[B];var D=[E.dM];var A=0;var x=0;var y="";try{var s,u=0;E.dM.buffer="";do{s=p(C,u);var t=G(s[0],s[1],s[2]);u+=s[0].length;if(!t){u+=s[1].length}}while(!s[2]);if(D.length>1){throw"Illegal"}return{r:A,keyword_count:x,value:y}}catch(H){if(H=="Illegal"){return{r:0,keyword_count:0,value:m(C)}}else{throw H}}}function g(t){var p={keyword_count:0,r:0,value:m(t)};var r=p;for(var q in e){if(!e.hasOwnProperty(q)){continue}var s=d(q,t);s.language=q;if(s.keyword_count+s.r>r.keyword_count+r.r){r=s}if(s.keyword_count+s.r>p.keyword_count+p.r){r=p;p=s}}if(r.language){p.second_best=r}return p}function i(r,q,p){if(q){r=r.replace(/^((<[^>]+>|\t)+)/gm,function(t,w,v,u){return w.replace(/\t/g,q)})}if(p){r=r.replace(/\n/g,"<br>")}return r}function n(t,w,r){var x=h(t,r);var v=a(t);var y,s;if(v){y=d(v,x)}else{return}var q=c(t);if(q.length){s=document.createElement("pre");s.innerHTML=y.value;y.value=k(q,c(s),x)}y.value=i(y.value,w,r);var u=t.className;if(!u.match("(\\s|^)(language-)?"+v+"(\\s|$)")){u=u?(u+" "+v):v}if(/MSIE [678]/.test(navigator.userAgent)&&t.tagName=="CODE"&&t.parentNode.tagName=="PRE"){s=t.parentNode;var p=document.createElement("div");p.innerHTML="<pre><code>"+y.value+"</code></pre>";t=p.firstChild.firstChild;p.firstChild.cN=s.cN;s.parentNode.replaceChild(p.firstChild,s)}else{t.innerHTML=y.value}t.className=u;t.result={language:v,kw:y.keyword_count,re:y.r};if(y.second_best){t.second_best={language:y.second_best.language,kw:y.second_best.keyword_count,re:y.second_best.r}}}function o(){if(o.called){return}o.called=true;var r=document.getElementsByTagName("pre");for(var p=0;p<r.length;p++){var q=b(r[p]);if(q){n(q,hljs.tabReplace)}}}function l(){if(window.addEventListener){window.addEventListener("DOMContentLoaded",o,false);window.addEventListener("load",o,false)}else{if(window.attachEvent){window.attachEvent("onload",o)}else{window.onload=o}}}var e={};this.LANGUAGES=e;this.highlight=d;this.highlightAuto=g;this.fixMarkup=i;this.highlightBlock=n;this.initHighlighting=o;this.initHighlightingOnLoad=l;this.IR="[a-zA-Z][a-zA-Z0-9_]*";this.UIR="[a-zA-Z_][a-zA-Z0-9_]*";this.NR="\\b\\d+(\\.\\d+)?";this.CNR="\\b(0[xX][a-fA-F0-9]+|(\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)";this.BNR="\\b(0b[01]+)";this.RSR="!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|\\.|-|-=|/|/=|:|;|<|<<|<<=|<=|=|==|===|>|>=|>>|>>=|>>>|>>>=|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~";this.ER="(?![\\s\\S])";this.BE={b:"\\\\.",r:0};this.ASM={cN:"string",b:"'",e:"'",i:"\\n",c:[this.BE],r:0};this.QSM={cN:"string",b:'"',e:'"',i:"\\n",c:[this.BE],r:0};this.CLCM={cN:"comment",b:"//",e:"$"};this.CBLCLM={cN:"comment",b:"/\\*",e:"\\*/"};this.HCM={cN:"comment",b:"#",e:"$"};this.NM={cN:"number",b:this.NR,r:0};this.CNM={cN:"number",b:this.CNR,r:0};this.BNM={cN:"number",b:this.BNR,r:0};this.inherit=function(r,s){var p={};for(var q in r){p[q]=r[q]}if(s){for(var q in s){p[q]=s[q]}}return p}}();hljs.LANGUAGES.cpp=function(){var a={keyword:{"false":1,"int":1,"float":1,"while":1,"private":1,"char":1,"catch":1,"export":1,virtual:1,operator:2,sizeof:2,dynamic_cast:2,typedef:2,const_cast:2,"const":1,struct:1,"for":1,static_cast:2,union:1,namespace:1,unsigned:1,"long":1,"throw":1,"volatile":2,"static":1,"protected":1,bool:1,template:1,mutable:1,"if":1,"public":1,friend:2,"do":1,"return":1,"goto":1,auto:1,"void":2,"enum":1,"else":1,"break":1,"new":1,extern:1,using:1,"true":1,"class":1,asm:1,"case":1,typeid:1,"short":1,reinterpret_cast:2,"default":1,"double":1,register:1,explicit:1,signed:1,typename:1,"try":1,"this":1,"switch":1,"continue":1,wchar_t:1,inline:1,"delete":1,alignof:1,char16_t:1,char32_t:1,constexpr:1,decltype:1,noexcept:1,nullptr:1,static_assert:1,thread_local:1,restrict:1,_Bool:1,complex:1},built_in:{std:1,string:1,cin:1,cout:1,cerr:1,clog:1,stringstream:1,istringstream:1,ostringstream:1,auto_ptr:1,deque:1,list:1,queue:1,stack:1,vector:1,map:1,set:1,bitset:1,multiset:1,multimap:1,unordered_set:1,unordered_map:1,unordered_multiset:1,unordered_multimap:1,array:1,shared_ptr:1}};return{dM:{k:a,i:"</",c:[hljs.CLCM,hljs.CBLCLM,hljs.QSM,{cN:"string",b:"'\\\\?.",e:"'",i:"."},{cN:"number",b:"\\b(\\d+(\\.\\d*)?|\\.\\d+)(u|U|l|L|ul|UL|f|F)"},hljs.CNM,{cN:"preprocessor",b:"#",e:"$"},{cN:"stl_container",b:"\\b(deque|list|queue|stack|vector|map|set|bitset|multiset|multimap|unordered_map|unordered_set|unordered_multiset|unordered_multimap|array)\\s*<",e:">",k:a,r:10,c:["self"]}]}}}();hljs.LANGUAGES.r={dM:{c:[hljs.HCM,{cN:"number",b:"\\b0[xX][0-9a-fA-F]+[Li]?\\b",e:hljs.IMMEDIATE_RE,r:0},{cN:"number",b:"\\b\\d+(?:[eE][+\\-]?\\d*)?L\\b",e:hljs.IMMEDIATE_RE,r:0},{cN:"number",b:"\\b\\d+\\.(?!\\d)(?:i\\b)?",e:hljs.IMMEDIATE_RE,r:1},{cN:"number",b:"\\b\\d+(?:\\.\\d*)?(?:[eE][+\\-]?\\d*)?i?\\b",e:hljs.IMMEDIATE_RE,r:0},{cN:"number",b:"\\.\\d+(?:[eE][+\\-]?\\d*)?i?\\b",e:hljs.IMMEDIATE_RE,r:1},{cN:"keyword",b:"(?:tryCatch|library|setGeneric|setGroupGeneric)\\b",e:hljs.IMMEDIATE_RE,r:10},{cN:"keyword",b:"\\.\\.\\.",e:hljs.IMMEDIATE_RE,r:10},{cN:"keyword",b:"\\.\\.\\d+(?![\\w.])",e:hljs.IMMEDIATE_RE,r:10},{cN:"keyword",b:"\\b(?:function)",e:hljs.IMMEDIATE_RE,r:2},{cN:"keyword",b:"(?:if|in|break|next|repeat|else|for|return|switch|while|try|stop|warning|require|attach|detach|source|setMethod|setClass)\\b",e:hljs.IMMEDIATE_RE,r:1},{cN:"literal",b:"(?:NA|NA_integer_|NA_real_|NA_character_|NA_complex_)\\b",e:hljs.IMMEDIATE_RE,r:10},{cN:"literal",b:"(?:NULL|TRUE|FALSE|T|F|Inf|NaN)\\b",e:hljs.IMMEDIATE_RE,r:1},{cN:"identifier",b:"[a-zA-Z.][a-zA-Z0-9._]*\\b",e:hljs.IMMEDIATE_RE,r:0},{cN:"operator",b:"<\\-(?!\\s*\\d)",e:hljs.IMMEDIATE_RE,r:2},{cN:"operator",b:"\\->|<\\-",e:hljs.IMMEDIATE_RE,r:1},{cN:"operator",b:"%%|~",e:hljs.IMMEDIATE_RE},{cN:"operator",b:">=|<=|==|!=|\\|\\||&&|=|\\+|\\-|\\*|/|\\^|>|<|!|&|\\||\\$|:",e:hljs.IMMEDIATE_RE,r:0},{cN:"operator",b:"%",e:"%",i:"\\n",r:1},{cN:"identifier",b:"`",e:"`",r:0},{cN:"string",b:'"',e:'"',c:[hljs.BE],r:0},{cN:"string",b:"'",e:"'",c:[hljs.BE],r:0},{cN:"paren",b:"[[({\\])}]",e:hljs.IMMEDIATE_RE,r:0}]}};
hljs.initHighlightingOnLoad();
</script>


<!-- MathJax scripts -->
<script type="text/javascript" src="https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>



</head>

<body>
<h1>StatR 101: Lab 11</h1>

<h2>December 3, 2012</h2>

<h2>Eli Gurarie</h2>

<h2>1. One-way Analysis of Variance: the Pie Example</h2>

<h3>a) First, by hand</h3>

<p>We referfirst to the Zone-Out Duration experiment in the lecture. </p>

<pre><code class="r">ZOD &lt;- c(0, 0.5, 1.5, 2, 1, 2, 2, 3, 5, 5.5, 6.5, 7)
Pie &lt;- c(rep(&quot;A&quot;, 4), rep(&quot;B&quot;, 4), rep(&quot;C&quot;, 4))
</code></pre>

<p>Let&#39;s make <code>Pie</code> a factor:</p>

<pre><code class="r">Pie &lt;- factor(Pie)
levels(Pie)
</code></pre>

<pre><code>## [1] &quot;A&quot; &quot;B&quot; &quot;C&quot;
</code></pre>

<p>And - as always in factorial-type data, draw a boxplot</p>

<pre><code class="r">boxplot(ZOD ~ Pie, col = c(&quot;green&quot;, &quot;blue&quot;, &quot;red&quot;), ylab = &quot;ZOD (minutes)&quot;, 
    xlab = &quot;Pie type&quot;)
</code></pre>

<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASAAAAEgCAMAAAAjXV6yAAAAjVBMVEX9/v0AAAAAADkAAGUAAP8AOTkAOY8AZrUA/wA5AAA5ADk5AGU5OY85ZrU5j9plAABlADllAGVlOY9lZgBlZjllZmVlZrVltf2POQCPOTmPOWWPjzmP27WP29qP2/21ZgC1Zjm1ZmW1/rW1/tq1/v3ajzna24/a/rXa/v39tWX924/9/rX9/tr9/v3/AAA9fmHUAAAAL3RSTlP///////////////////////////////////////////////////////////8A/+SDKggAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAcTSURBVHic7Z0Pc9o2GIdLskHTpiak66DtBt2GV2zjff+PN8sGAmfZP/2xLAn/nstdLhBei+ekV7Isy+9K0ss73wUIHQoCUBCAggAUBKAgAAUBKAhAQQAKAlAQgIIAFASgIAAFASgIQEEACgJQEICCABQEoCAABQEoCEBBAAoCUBCAggAUBKAgAAUBKAhAQQAKAlAQgIIAFASgIAAFASgIQEEACgJQEICCABQEoCAABQEoCEBBAAoCUBCAggAUBKAgAAUBKAhAQQAKAtgImt0HDgVZfDYcKAhgK6hYJoahI8Fa0Or7bG0UOhLsBe3L3exxfx1SLb15QT8VDyFINLRbRyqhvaNWvmEEWRTAH+MIsi6APygIQEEn7AbPUxD0nyYUREE3UBCAggAUBKAgAAUBKAhAQQAKAlAQgIIAngXlT+vjZjabH9oF0/sezvAr6LhZl7t15em5ZSgYQV6nO4rV/vh1ezP1Gtqkvef5oKr6ZElZZot2wfS+hzM8Cyp3dcy2n3AE+U3SPQWz+OyQUBCAggAUBKAgAAUBKAhAQQAKAlAQYAxBWX060bHUrrNgev/uDPeCsuZM67jRUzQZQcXrZarnr87lZLKC6XwLh/g+m+8umMVnx2DIBVTp/JBGm4O6GFBQ8bKtfvKPkgYmZhKLZdBz0l0MKWi1r+pQl6B6tjX/ZFgAfwzaxGYP20zaxCo79Xx9wHPS1yjl5dtP9AdUuFfj4c9v+6Cvathh34tVw6NFmbUX2k9KUCVh/vNlO2joSFASdNwkVRPKJD2VRehIUO3FKkE9t2WYhI4EjRqUsga1ectB0rGgTehImPC5mBqqOajsvTXMJHQkqEx3LE+jTeagNtc1aODQkcAcBFCrQU0jk5xOWISOBI0alHZuIWAUOhI0BLEXk3AtSHbGbhE6EnRy0J3NSavBXgwwjCDpdPWUBGWd3fxlmB3f3h1qKOag7vRTLCs1NzUo5El7fQY41SiW83+n3sR2/WPE/EnW+iYkiKcanbCbpyCAyoTZ6m82sS5Yg2wHiuahI0F1fdDwoSOBc9IAxfVBmpOJKqEjQXUBFXOQHOYg5iAAcxCAJ6sAjqQBKudiv1/+jPJeDTus7/bJn2bJTtr8piOo736xevcXMSvNddJyxAhAbG4y3kp7/cXydofrf1tp/yCBnxrk/xC4F2suCaV+cpD/QwTezfs/BAUpCaq6cu1x9JR6sexBnMznT1z+0kYIqjdxK6UdlU3oSFC67NM0rgCX4Pk/BAVFIahz8DzCqFrnVgRv80GzXzQZV5Cj0DqRKAhECl1Q3cg8DhRDF+R9oBi4IP8DxcAFBdDNhy2ovwZVJ7IPW6m9yQjqzUFiRvG4SRwLCnug2NuLNWJ2C505ae3vFbygHk5z0umv7aXkaqVU+a/ABZ03eZMn6dOzjCWT0gMKCjsHVQ2sriVuerF7ELT6ZzM/UJCU8zhIdGRWgqzSSASCqmS8sBP0XpPYBInr8zbzQfcs6MzxGwW1GGw+iIJAaDtBYQ8UBwltJUjtEG6gILtDUFDcgkaAggAUBIhbEHOQziHcQEF2hxhOkJPBcASCJEs/pF9xOEFWRvWxrkHimo9C6OEEjYx9E+u8X5PdvE5oCgKhKQiEpiAQmoJAaAoCoSkIhKYgEJqCQGgKAqEpCISmIBCagkDoCZ/Nm4bW+i9/UBDAWlB9R7TF5ib3Lui8NYXk8XUUJJDcyAHTbPCJ+RrvNSh0rHNQ9/5mFGQXOhIoCEBBAJeC7gN3ghQ1xvnhMxQEoCAABQEoCEBBAAoCuBcUORQEoCAABQEoCEBBAAoCUBCAggAUBHAtyOyxSjXNJV3NnfkuiOc8tK9U6eNaUPbF5KlBNfXjk/MPZoLr7Y52AxhyLOj49Y9X00LWgs4b0GnSVNzzRU8bHAvKnw8700I2NUhzb8cTkuvAhjgWlCZltjD8bJODzL6p8UFbuBV03MwM9og90TQxs1ZiWPEkuBVUl9O0jTXPuDf7dCw5KBUFNK3utSDTYUIcvVizY5Ppd5zGOCh6KAhAQQAKAlAQgIIAFASgIAAFASgIQEEACgJQEICCABQEoCAABQEoCEBBAAoCBCOomaJPThd7zi+2n7g0NuEIkl3koaA3ztdRxe9i2VyOFb8/r8v8+efqe/OYvKXxdVpTwhKUf9iK37ukTBenF7OkzJJiOT9kj1dvjEc4gk6XCSsnoqE1+xiIP14PP7bFci0Wwry9MR7hCDqlG+FE3KnfPHbx475eYVTnpt367Y3xCFLQpZKIF9MvSZ28RQ0aufYIQhQkUk2zAkr8IRbhFctF/crljfEIUlDVlJqGdNw87sUKiOLlt3MvNnILC0dQJ/knq7WytgQvKK1rDgUFCwUBKAhAQQAKAlAQgIIAFASgIAAFASgIQEEACgJQEICCABQE+B/p6jA7xr1QGAAAAABJRU5ErkJggg==" alt="plot of chunk ZODboxplot"/> </p>

<p>Also, as with all analyses, it is helpful to generate a table of summary statistics:</p>

<pre><code class="r">SummaryTable &lt;- data.frame(n = tapply(ZOD, Pie, length), mean = tapply(ZOD, 
    Pie, mean), sd = tapply(ZOD, Pie, sd))
SummaryTable
</code></pre>

<pre><code>##   n mean     sd
## A 4    1 0.9129
## B 4    2 0.8165
## C 4    6 0.9129
</code></pre>

<p>As a general rule, it is a good idea to record summary tables like these in separate files.  For example:</p>

<pre><code class="r">write.csv(SummaryTable, file = &quot;SummaryTable.csv&quot;)
</code></pre>

<p>Ok, let&#39;s start collecting all the little pieces of ANOVA:</p>

<pre><code class="r">X &lt;- Pie
Y &lt;- ZOD
a &lt;- length(levels(X))
N &lt;- length(Y)
n &lt;- N/a
</code></pre>

<p>Recall the definition of the <em>total sums of squares</em> and the <em>treatment (or group [or model]) sum of squares</em>:
 \[ SS_{total} = \sum_{j=1}^a \sum_{i=1}^n (Y_{ij} - \overline{Y_{\cdot\cdot}})^2 \]
 \[ SS_{treatment} = \sum_{j=1}^a \sum_{i=1}^n (Y_{j\cdot} - \overline{Y_{\cdot\cdot}})^2 = n \sum_{j=1}^a (Y_{j\cdot} - \overline{Y_{\cdot\cdot}})^2 \]</p>

<pre><code class="r">Y.means &lt;- tapply(Y, X, mean)
SS.total &lt;- sum((Y - mean(Y))^2)
SS.treatment &lt;- n * sum((Y.means - mean(Y))^2)
</code></pre>

<p>The  <code>SS.error</code> can be obtained in one of two ways.  Either by the definition, which is \[ SS_{error} = \sum_{j=1}^a \sum_{i=1}^n (Y_{ij} - \overline{Y}_{i\cdot})^2, \] or simply as the difference of the <code>SS.total</code> and the <code>SS.treatment</code>.  </p>

<pre><code class="r">SS.error &lt;- SS.total - SS.treatment
</code></pre>

<blockquote>
<p><strong>EXERCISE:</strong> Calculate the error sum of squares in R using the mathematical definition above and confirm that if gives the same result.</p>
</blockquote>

<p>Next, we compute the <em>mean square of the errors</em> and the <em>mean square of the treatment (or group)</em>.</p>

<pre><code class="r">MS.error &lt;- SS.error/(N - a)
MS.treatment &lt;- SS.treatment/(a - 1)
</code></pre>

<p>And obtain the <em>F</em>-statistic: </p>

<pre><code class="r">F0 &lt;- MS.treatment/MS.error
</code></pre>

<p>And compute the <em>p</em>-value:</p>

<pre><code class="r">1 - pf(F0, a - 1, N - a)
</code></pre>

<pre><code>## [1] 5.081e-05
</code></pre>

<p>Clearly, we can reject the null hypothesis that there is no relationship between Pie type and Zone-Out Duration. </p>

<h3>b) Using R</h3>

<p>Of course, all of this could be performed in R. But it takes two steps.  The first (and this should be somewhat familiar looking) is to <em>specify the linear model</em></p>

<pre><code class="r">Pie.lm &lt;- lm(ZOD ~ Pie)
</code></pre>

<p>Recall that the notation <code>Y ~ X</code> means that we are modeling <code>Y</code> as a response to explanatory factor <code>X</code>, i.e. \( Y_{ij} =  \mu_i + \epsilon_{ij} \).  The <code>lm</code> part tells us that the \( \epsilon \)&#39;s are indpendent and identically distributed (iid) and normal, i.e. \( \epsilon_{ij} \sim {\cal N}(0,\sigma^2) \). </p>

<p>Look at the output of <code>summary(Pie.lm)</code></p>

<pre><code class="r">summary(Pie.lm)
</code></pre>

<pre><code>## 
## Call:
## lm(formula = ZOD ~ Pie)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -1.000 -0.625  0.000  0.625  1.000 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(&gt;|t|)    
## (Intercept)    1.000      0.441    2.27     0.05 *  
## PieB           1.000      0.624    1.60     0.14    
## PieC           5.000      0.624    8.02  2.2e-05 ***
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1 
## 
## Residual standard error: 0.882 on 9 degrees of freedom
## Multiple R-squared: 0.889,   Adjusted R-squared: 0.864 
## F-statistic:   36 on 2 and 9 DF,  p-value: 5.08e-05
</code></pre>

<p>Note that this gives somewhat confusing output (what is <code>Intercept</code>?  Why is <code>PieB</code> &ldquo;1&rdquo;, when its mean is 2.0?  What are the <code>t-tests</code> it is performing?).  The short interpretation of this output is that it is not very useful.  </p>

<p>However, the <code>Pie.lm</code> is a &ldquo;fitted model object&rdquo;&ldquo;, which contains a lot of useful information.  Note all the named components of this object:</p>

<pre><code class="r">names(Pie.lm)
</code></pre>

<pre><code>##  [1] &quot;coefficients&quot;  &quot;residuals&quot;     &quot;effects&quot;       &quot;rank&quot;         
##  [5] &quot;fitted.values&quot; &quot;assign&quot;        &quot;qr&quot;            &quot;df.residual&quot;  
##  [9] &quot;contrasts&quot;     &quot;xlevels&quot;       &quot;call&quot;          &quot;terms&quot;        
## [13] &quot;model&quot;
</code></pre>

<p>Important features of the model are the <em>model predictions</em>:</p>

<pre><code class="r">Pie.lm$fit
</code></pre>

<pre><code>##  1  2  3  4  5  6  7  8  9 10 11 12 
##  1  1  1  1  2  2  2  2  6  6  6  6
</code></pre>

<p>and the <em>model residuals</em>:</p>

<pre><code class="r">Pie.lm$res
</code></pre>

<pre><code>##          1          2          3          4          5          6 
## -1.000e+00 -5.000e-01  5.000e-01  1.000e+00 -1.000e+00 -8.327e-17 
##          7          8          9         10         11         12 
## -8.327e-17  1.000e+00 -1.000e+00 -5.000e-01  5.000e-01  1.000e+00
</code></pre>

<p>Note, immediately, that this object make finding the residual sum of squares instant:</p>

<pre><code class="r">sum(Pie.lm$res^2)
</code></pre>

<pre><code>## [1] 7
</code></pre>

<p>Before we perform the analysis of variance, it is import to verify the assumptions of ANOVA, which are related to the residuals.  The simplest, most efficient, and often sufficient way to verify these is by plotting the linear model directly:</p>

<pre><code class="r">par(mfrow = c(2, 2))
plot(Pie.lm)
</code></pre>

<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfgAAAH4CAMAAACR9g9NAAAA21BMVEX9/v0AAAAAABwAADkAAGUAOTkAOWUAOY8AZmUAZo8AZrU5AAA5ADk5AGU5OTk5OWU5OY85ZmU5ZrU5j485j9plAABlADllAGVlOQBlOTllOWVlOY9lZjllZmVlZrVlj9pltdpltf1/f3+POQCPOTmPOWWPZgCPZo+Pj2WPj7WPj9qPtY+P27WP2/21ZgC1Zjm1j4+1tWW124+12/21/rW1/tq1/v2+vr7ajznaj2XatWXa24/a29ra/rXa/tra/v39tWX9tY/9tbX924/927X9/rX9/tr9/v3/AADjKQcZAAAASXRSTlP//////////////////////////////////////////////////////////////////////////////////////////////wD/si6NqgAAAAlwSFlzAAALEgAACxIB0t1+/AAAHnNJREFUeJztnYti2zaWhsu1W+/KSeqmctOO284qTjo7Myum000ddjoZcUcrIe//RIsbL5JA3AiCIM75YzsSBR4B+IgDEDd+RlAg9dncEUDNIwQPVAgeqBA8UCF4oELwQIXggQrBAxWCByoED1QIHqgQPFAheKBC8ECF4IEKwQMVggcqBA9UCB6oEDxQIXigQvBAheCBCsEDFYIHKgQPVAgeqBA8UCF4oELwQIXggQrBAxWCByoED1STgN/fFlTXT+eHn/Mjx8eN8rjG1JoGET+9jy7sJKv9LYupLpmk93lFE9ym7ORNSE0DniehutkpP3UD3362aPCsEFiCL2m2He5l0k7eBNWE4Nnfwz0v+DUv//LAF99u2Cv+e8uuZ/aqlh5if7cjxzfb5m2TG/vn7++FF5EWhZ0pIj+B9s//turnx/7Lb69/ffNf1JPRdK5JLxuaBNei0Jy8CauJS3y5JtWKHF49sf/YYXqgLhrwh2+2siDLEIRBp/A/Nm878I2rFxalnSkiP4FovMtNm/ybHXP9x0eaIber02ygYWuebHbo/E1YTVjHMy9Fo0yZyphLwNRFNyWeih6RaReqKNh195abWnXgG4vCzhSRn0As3g87mXyaApZ0doWzX5lUkQ30hbje2Sfnb8JqshJfX225Qy4K+oLiu+qu6rIDXzLvLZ3+lbg67v75Ztt7e1bipUVp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" alt="plot of chunk unnamed-chunk-17"/> </p>

<p>The imporant plots here are the first two.  They indicate that the residuals have consistent variances and are roughly normal, suggesting that the assumptions are valid.</p>

<blockquote>
<p><strong>EXERCISE</strong>:  Use the <code>Pie.lm</code> object to create the first plots by hand.</p>
</blockquote>

<p>Ok, now that we have confirmed that the assumptions of ANOVA are supported, we can shoot the magic bullet:</p>

<pre><code class="r">anova(Pie.lm)
</code></pre>

<pre><code>## Analysis of Variance Table
## 
## Response: ZOD
##           Df Sum Sq Mean Sq F value  Pr(&gt;F)    
## Pie        2     56   28.00      36 5.1e-05 ***
## Residuals  9      7    0.78                    
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1
</code></pre>

<p>There it is: instant ANOVA. Double check that the results of the ANOVA conforms with our results.  Note, as always, that the output of <code>anova</code> is a named list:</p>

<pre><code class="r">names(anova(Pie.lm))
</code></pre>

<pre><code>## [1] &quot;Df&quot;      &quot;Sum Sq&quot;  &quot;Mean Sq&quot; &quot;F value&quot; &quot;Pr(&gt;F)&quot;
</code></pre>

<p>out of which any component can be easily extracted, for example:</p>

<pre><code class="r">anova(Pie.lm)$Sum
</code></pre>

<pre><code>## [1] 56  7
</code></pre>

<blockquote>
<p><strong>Exercise</strong>: perform an analysis of variance on a random resampling of the ZOD (or Pie) data.  Do you expect there to be a significant effect of Pie?</p>
</blockquote>

<h2>2. Two-Way ANOVA: Analysis of Cow Growth</h2>

<p>A 2-way ANOVA is essentially similar to a 1-way ANOVA, but explores 2 main effects AND a potential interaction effect.  </p>

<p>We will look at some data on growth of a cow under three different diets (barley, oats and wheat) and three diet supplements, plus a control group with no supplements.  The response variable is weekly weight gain on individual cows.  The data are posted here:</p>

<pre><code class="r">Growth &lt;- read.csv(&quot;http://faculty.washington.edu/eliezg/data/Growth.csv&quot;)
</code></pre>

<p>I discovered a fun package called <code>googleVis</code>, which allows you to generate a Google style html table (as well as lots of other Google style visualizations with R/Markdown/knitr, see examples here: <a href="http://www.r-bloggers.com/googlevis-0-3-2-is-released-better-integration-with-knitr/">http://www.r-bloggers.com/googlevis-0-3-2-is-released-better-integration-with-knitr/</a>). </p>

<pre><code class="r">require(googleVis)
print(gvisTable(Growth, options = list(height = 300)), &quot;chart&quot;)
</code></pre>

<!-- Table generated in R 2.15.0 by googleVis 0.2.15 package -->

<!-- Mon Dec 03 23:25:32 2012 -->

<!-- jsHeader -->

<script type="text/javascript" src="http://www.google.com/jsapi">
</script>

<script type="text/javascript">
 
// jsData 
function gvisDataTableID1c483ae63b63 ()
{
  var data = new google.visualization.DataTable();
  var datajson =
[
 [
 "supergain",
"wheat",
17.37125111 
],
[
 "supergain",
"wheat",
16.81488903 
],
[
 "supergain",
"wheat",
 18.0818374 
],
[
 "supergain",
"wheat",
15.78174829 
],
[
 "control",
"wheat",
17.70656456 
],
[
 "control",
"wheat",
18.22716932 
],
[
 "control",
"wheat",
16.08650292 
],
[
 "control",
"wheat",
17.60183606 
],
[
 "supersupp",
"wheat",
20.78861134 
],
[
 "supersupp",
"wheat",
20.00857817 
],
[
 "supersupp",
"wheat",
 19.3028731 
],
[
 "supersupp",
"wheat",
18.57330111 
],
[
 "agrimore",
"wheat",
19.54687993 
],
[
 "agrimore",
"wheat",
17.96440085 
],
[
 "agrimore",
"wheat",
21.43738428 
],
[
 "agrimore",
"wheat",
19.60762695 
],
[
 "supergain",
"oats",
19.36091974 
],
[
 "supergain",
"oats",
20.64937883 
],
[
 "supergain",
"oats",
19.60614794 
],
[
 "supergain",
"oats",
19.03556747 
],
[
 "control",
"oats",
21.56472896 
],
[
 "control",
"oats",
20.25976458 
],
[
 "control",
"oats",
19.20455035 
],
[
 "control",
"oats",
 20.9456156 
],
[
 "supersupp",
"oats",
21.14743401 
],
[
 "supersupp",
"oats",
23.00609369 
],
[
 "supersupp",
"oats",
21.90279279 
],
[
 "supersupp",
"oats",
21.38461774 
],
[
 "agrimore",
"oats",
23.58744105 
],
[
 "agrimore",
"oats",
 22.3151736 
],
[
 "agrimore",
"oats",
22.37652558 
],
[
 "agrimore",
"oats",
24.91439495 
],
[
 "supergain",
"barley",
23.82941658 
],
[
 "supergain",
"barley",
23.75687731 
],
[
 "supergain",
"barley",
21.34872954 
],
[
 "supergain",
"barley",
20.92947123 
],
[
 "control",
"barley",
24.69354073 
],
[
 "control",
"barley",
24.32012743 
],
[
 "control",
"barley",
22.02811202 
],
[
 "control",
"barley",
 22.1448196 
],
[
 "supersupp",
"barley",
24.62987793 
],
[
 "supersupp",
"barley",
23.08774445 
],
[
 "supersupp",
"barley",
27.79490195 
],
[
 "supersupp",
"barley",
26.78868607 
],
[
 "agrimore",
"barley",
26.04248312 
],
[
 "agrimore",
"barley",
25.28337056 
],
[
 "agrimore",
"barley",
25.03889345 
],
[
 "agrimore",
"barley",
29.02916349 
] 
];
data.addColumn('string','supplement');
data.addColumn('string','diet');
data.addColumn('number','gain');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartTableID1c483ae63b63() {
  var data = gvisDataTableID1c483ae63b63();
  var options = {};
options["allowHtml"] = true;
options["height"] =    300;

     var chart = new google.visualization.Table(
       document.getElementById('TableID1c483ae63b63')
     );
     chart.draw(data,options);
    

}
  
 
// jsDisplayChart 
function displayChartTableID1c483ae63b63()
{
  google.load("visualization", "1", { packages:["table"] }); 
  google.setOnLoadCallback(drawChartTableID1c483ae63b63);
}
 
// jsChart 
displayChartTableID1c483ae63b63()
 
<!-- jsFooter -->  
//-->
</script>
 

<!-- divChart -->

<div id="TableID1c483ae63b63"
  style="width: 600px; height: 300px;">
</div>

<p>(<sub>Note: I took these data  from <em>The R Book</em> by Michael Crawley, Wiley 2007: <a href="http://www.bio.ic.ac.uk/research/mjcraw/therbook/">http://www.bio.ic.ac.uk/research/mjcraw/therbook/</a>.</sub>)</p>

<p>Note that the supplement factor levels are ordered alphabetically</p>

<pre><code class="r">levels(Growth$supplement)
</code></pre>

<pre><code>## [1] &quot;agrimore&quot;  &quot;control&quot;   &quot;supergain&quot; &quot;supersupp&quot;
</code></pre>

<p>Which awkwardly places &quot;control&rdquo; second.  A reordering of factors might be in order (so to speak). There is a convenient function called <code>relevel</code> which does exactly that:</p>

<pre><code class="r">Growth$supplement &lt;- relevel(Growth$supplement, ref = &quot;control&quot;)
</code></pre>

<pre><code class="r">par(cex.lab = 1.25, cex.axis = 1.1, mar = c(4, 4, 2, 2), bty = &quot;l&quot;)
cols &lt;- c(&quot;orange&quot;, &quot;yellow&quot;, &quot;red&quot;)
layout(rbind(c(1, 2), c(3, 3)))
boxplot(gain ~ diet, data = Growth, col = cols, ylab = &quot;Weight gain (kg)&quot;, main = &quot;Diet&quot;, 
    srt = 45)
boxplot(gain ~ supplement, data = Growth, col = &quot;orange&quot;, ylab = &quot;Weight gain (kg)&quot;, 
    main = &quot;Supplement&quot;)
boxplot(gain ~ diet * supplement, at = c(-0.5, 0, 0.5) + rep(1:4 * 3, each = 3), 
    data = Growth, col = cols, xaxt = &quot;n&quot;, ylab = &quot;Weight gain (kg)&quot;, main = &quot;Diet x Supplement&quot;)
axis(1, at = 1:4 * 3, labels = levels(supplement))
legend(&quot;topleft&quot;, legend = levels(diet), fill = cols, bty = &quot;n&quot;)
</code></pre>

<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfgAAAH4CAMAAACR9g9NAAAAzFBMVEX9/v0AAAAAADkAAGUAOWUAOY8AZmUAZrU5AAA5ADk5AGU5OTk5OWU5OY85ZmU5Zo85ZrU5j7U5j9plAABlADllAGVlOQBlOTllOY9lZgBlZjllZmVlZo9lZrVlj9pltf2POQCPOTmPOWWPZgCPZmWPjzmPj9qPtY+P27WP29qP2/21ZgC1Zjm1ZmW1jzm1j4+124+1/rW1/tq1/v3ajznaj2XatWXa24/a29ra/rXa/tra/v39tWX924/9/rX9/tr9/v3/AAD/pQD//wA2Q6ywAAAARHRSTlP/////////////////////////////////////////////////////////////////////////////////////AP///4LVZm4AAAAJcEhZcwAACxIAAAsSAdLdfvwAABw3SURBVHic7Z0Nn+O2cYeHu9lId/ZdLtKdX9qm2rs2qSOd3birZhsfKdHx9/9OBQhKK1GEiAEBDjCa52evdAQEzOBPECCJF6iFmwSoDRBoAGoDBBqA2gCBBqA2QKABqA0QaABqAwQagNoAgQagzb6aF0Vx/1SXxep46B2lQXEolZcrW5Al4IQYRQLhk8RQzRf1/lEpf2S3nNGZEwnl5bmTJzgIH6VIIHySGLTw2nftvqr9d+v9Y1E8fKE1KjiNl9rPRb25fyqLt3P17fjRem4OPPxUqIPtkWquo8QpEgidII6mSNQf5b7+qoqFY43fLbWYL8I/fNnqc739OHhuDsz01/ZINX/45TFSkUD4JDE0wivHlPvb5qRfcRReV+CmI9MKvDDnevtx8Lxs67/6Z3skZl2A8EliOKnx20KzYCl8XW/Vpfso/Ko91w+nvPH8VHhzhL/wq/a8r3l27jRtlbbV+Nq0BCc1vjalw1l4Uwv0V+UwR+G3Rk7l4W7ZtuW6/rcfB89PhG+PsBb+5T6+vdndFJYbn4zZFE1fXbn2fV+v3nh+Inx7pBU+SpFA6ASFIcpicfJBBVBmfpuI8AIhQG2AQANQGyDQANQGCDQAMn4Rw4hMYOU7IOOzch4JK98BGZ+V80hY+Q7I+KycR8LKd0DGZ+U8Ela+AzI+K+eRsPIdkPFZOY+Ele+AjG9zvuhnpHVpMcqb1MoGkPEdzOWl9glhHEuk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" alt="plot of chunk unnamed-chunk-26"/> </p>

<p>These boxplots are quite illuminating, showing likely significant main effects. The open question is: are there significant &ldquo;interaction effects&rdquo;?  I.e., do different supplements in combination with different grains act in different ways on weight growth? </p>

<p>One quick way to visualize this question is to look at &ldquo;interaction plots&rdquo;:</p>

<pre><code class="r">par(mfrow = c(2, 1))
interaction.plot(diet, supplement, gain)
interaction.plot(supplement, diet, gain)
</code></pre>

<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfgAAAH4CAMAAACR9g9NAAAAllBMVEX9/v0AAAAAADkAAGUAOTkAOWUAOY8AZo8AZrU5AAA5ADk5AGU5OWU5OY85ZrU5j485j9plAABlADllAGVlOQBlOTllOY9lZgBlZjllZmVlj49ltf2POQCPOTmPOWWPZgCPjzmPj2WP27WP2/21ZgC1Zjm124+1/rW1/v3ajzna24/a/rXa/v39tWX924/9/rX9/tr9/v15k2BOAAAAMnRSTlP/////////////////////////////////////////////////////////////////AA1QmO8AAAAJcEhZcwAACxIAAAsSAdLdfvwAABcjSURBVHic7Z2Jets2FkaHduORk6Yjx+kquTMZqY7VsRa+/8sNQYCLxA0gtgve/3x1pWgBQBxhIbHwHzlgyT9iJwDEAeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pkC8UyBeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pkC8UyBeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pliIz4DlPEo3uK7wDfW4k+Pm8s2yx7eTYMGUbEVf9lu8v2m8P+5Yx7iKWMr/vz8dnnZlY+GQYtOwNQngDesq/qiuB/XeX5cmQatPgT5czh96pQzw4/Yd+72ZR+x6123qp/sYIIuFMTPDfr6s5Df5Zhl92+lwOLv/Pyf7G6Xqwfx4vlJvH15+ZZl6+KjRbUrXzl9/neWbeTzYTyI1zxT7PnejMgWjOg2HVa1+KeH9+N99SBe3K/F25dt8ZFH+TH5yulxnR8f3n2X+NOj+AXO6tx1EwP3Lc5fduKhFr8pSvdOPYgXvuyqrrX4K/6pXlFf8CxenM5dtms34uXXIF8hy1QlXvwM9hv1UP4SinJyt2uLl6+EES+F71fuxJdfhXyJqrKVeFHi5UPZ6Jc53hYvXwlX4gsOP3SjsZKHWl9IF39C9UE07qvyX/JBtejFs5Z49UoY8UVPci0eDt0upP0FHOby92WvPj9k2b+eixL/W9mrlw+qV3+3a5d49YoSf9mG7tVrBl1+ZFotc/k1qqunHuyJfh4/7R61vmBx4nM9s5DvGAric81SDfkOISI+1y33cO8IOuJzXa+Q7wJS4nPtMg35tlATn+uXe7i3gaD4XN8q5M9GT/yxHGYdvRJkHPTUt3WlQv4stMSLsUDnQWsEoF3u4d4YPfHdoTf7oPXC0HYK+WboVfX7tfugtYPRVwr5+mhW9eHb+KuQDMo93OtBs1ffE5iBUUby++ZjVnMuf/x6/zY8XzMV8blhaV6E/Mnljr3zMes5l5ux+Zoa4s/P3yNX9U2QRuV+Ce7H6Z+P2cy5HJmvmVCJV6Ea+Vy6/N75mM2cy5H5moTm1ZtEYPZxXwkhQXc+ZjPnsv/98kFP/IFIVd+EbVjuF+q+dz5ma87lyHxNvdO5L7vjSvQSjPCc2aY2Fym/bz5ma87lyHxN3St38j+jRPnPaOOSvEj5NVPz8a6m7WmJLxoGOYnfKB1BMtm83C/XvXvxotqQ6zFNCJXDWJ45h+RO5/qjMlfJXf4yxOfzyj1n9yaDNIbnc8EXycwxyVa+wbDsYXXs2dRsdtDqQ24zflYpXpJ77R64wUSM8/N3oxO6SMPoaO+10Dud25Yl/uHv7mZ284O++bDLvOfTzz89ZtmmbIs//LwTA7Gvn956dsURI7Q3m+Jodu7E1lYrw6l3UQveIsq9SJEa9Wg9bSFOyaul8nc7MRBbro++2hVHXL0t3lCDtU3Y41FHWFBhEeNtUCz6euqaqrrCJsRf75FRPFQjtO1rr9TEl190lvuzyn1S7suL8WI/2V7x4hX1hhqsrb9IUXz5ZVfZP6+fn4h80fiq7XAmS/xNx5yq+DKA8PN0299yE7lXStUfd1Ub3xHfGqFVT+uvUhZfBuIm/5fa3h+y7MPXjajH/9lX4qtevRAvB2trrMVbbHAYdpHUIvr5wzgeO5WTLUeCtNvgMPBCmaWWe3GniDvDvXH0ZtkOq3exwWHIkr/ovp4JOlX9Phseo3GzwWHQkj+v3C/NvcG1+n4sNjjsfCFYyV9uP18bWr36gCV/Vrm3jDMI1728wT6fnnjRe+i70VR/kLbz6kOV/GX29VyKr0bn+sy73K+++Wqokj/j90mquZcn57d3pnhtRuPsxFfj8QOdO7f71bcCCFPy59ROYeQ3w3LXfzUi948P79UYXHWZrhqNG7tPhW2J97NffR1EsDZ/hn0CJV9qbV2Rl9uVV9fm1Yu92LbxvvarvwooVG/f1H70Wl/e5rE1BteIb73Yi3Wv3uHp3DAhz/NNO6Yx3Xsv8bNwniOBr/BpR2cf21xEfVuovb0zRWs0bhHiY1zb1wsnWpV/1auv70zxqkbjrHv18/CWGcFH9TQCit7cm5Ki+OAlX9++k8iCoCc+wpamOhEELfma9lORr3cBJ86WphpRhC75OvbTqPWtR+dmB+2O0CVfy76rqHyhV9XH3NJUK6rwJX/KPnXzmlU9yTa+E2Hwkj9+uYdalX91apdmr34wyhglPx8u/ISb+2WJVxFHKPn5mH2n0VwxtZetXE2p1laKa3rl0G2ZqvGAqe5zNxV1pJI/aH9eLFVgt481U3vZqpUWam1lOWBbLavQa+Mp7nOnkYA4Jb/Xvp9iP7mXrVxbVX70uT1up386R3Kfu+kk6Jd8H3Ffxe5F/cRetmo1ZbW20lg84X3udNDK8szXqFI7dh/yx/ayVSVera00F097nzsNdAfZ/CT62r5L+VN72bZXU37czRA/C0LiJbol31PktX2HJ3lTe9nK1ZRqbaVv8dbTq/2hlyh/KW/li4dI+rc0HWihtefcPfzP9Jb1BMVLdPLc58+2tu84jq74kdWUep277broH5rtckdYfPySn9f1oscYJuIff7s+nSvEJ3g6N07skm80s8951ONvt0t8/0qa2UFTgEDJj3VBX7uN1187pxk0HeKX/AhwOp0bRrPke09HQFKec+eaSfueLvBEQXeQxn3QFNGZTJnkgXVZwpw71+iU/OTRHI8nPufONdMlP/nO3jInYrhhSm7S8tHGj7Hgko82fppFlny08TossOQvaV69bxZV8nHlzgSNkh8kHQ6AeHNGx9RSucBjLf70mK0Ovc1AEsdvw6D9FOTbiheTd8WE+1P3zmTkj92e8ZJPGlvx5VqOteudLdMilUWTV6DEu2C45JOV76KNXzNt429JquSjV++ShEo+r3n1YUii5KPE+yCBkg/x/hgs+WGT0Y/16dyTqte9bmKcKgMln8IFHusSL/eynxE0H/o3SImcQfZV/eAsDYivGS750UAbH47ezXFi5RLEhyT8tliDQHx4SJzSQXwMCFzdgvh4RLUP8TGJWPIhPj7o3IFwQDxTIJ4pPsUDyvgTDxIG4pkC8UyBeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzxan4/ebmBdPbFHshYiJ6oyaRKRAfPmoSmeJY/O9Ztin3ySoeTj9+vX8Vd7p+EnsqFL+Jng3TfCHjlAkpnx+Nd2i24LLdiHs758eHvz/9WuZIJz2hkjKMW/Hlva3FenpxX+PH8p7m4kbXh1V+XIv/QiHvs10lpEiS2KVxFSz6Q3HIhe/D+vS4ru77XUTfpCdYSoZxXtXL6l7cs7S52X3xr/Mv73/NuQvGLIRntZ2DTMi8O3DMpqjb/vq2urzsrvOgSU/IxAzgVLxQW8oXFWt10GIPnbvd5eW/vwSr6UXUYkfOVkIeh2667IPz8/fn10/fn2/yoJWe+Lgu8UX7dn7a5M0t7Ks9cA+/h6vpVYlvJaTA9F7ZNuz/+Ony8m2VX+fBdXoi41b8qjb+sarmVHtb9naCIeNsEiISEFL8MZOt/HUetDImPq579aJCO2TZh6+b6qCLek68ePkz4OGqnrNMyGV7/7YP2avPZZ/+/i2/yYMmPeGSMkSwK3enn0LFBHQIJf4QsG8FNMC1eqZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTID4v1zw1U19pTIL1DsTncrFbDcQz4fxUTQYvJ2UTWdPoHYgXix2yTbO8EyWeB2J5k2zj1dJGiOdB6Xm/aZY2QjwPWiVeLm2EeCZctfFqaSMDIP6ybfXq73Y5jTWN3oF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pkC8UyBeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pkC8UyBeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pkC8UyBeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnio34DFDGo3iL7wLfWIs/PW4u2yx7eDcNGkTFVvxlu8n3m8L/5455iKeMrfjz89vlZVc+GgU91cYAz1hX9UVxP67z/LgyDRpExb5zty/7iF3v0+JR6o0oWtXTp6pebZ7NJHavHvK1Ed2pGoriNc8UgQnnp+zD17LEF8/u38r/WQXo4HQuu5vRubv6IH4ik+zX+TErxRfPDqv4JV7UP5ft2kq88Yf5IbJXtvHnLzvxr+jipfD9ylY8zI9Set6X4p+KRvRuF1286nEcfugmxFglqvxBWiVelrDo4ou+xlo8HLp9jVka4b6fqzb++PAeX/zsoJ1+axmMHPtl2+rVF73pyzZ2r3520CNfZCo/6GFTFG/95QQJ/mOnKp6V+RjHSlZ8zqfKj3KYlMU7C4Qw0X7c1MUv3nwsyIvPl1vlRz2uFMQvkti5oyf+WA6zGl4ycHpoSyv10Q9HS/z5aTP+sTlBEwgwEiR+xHriu0Nv9kGTCDE8VI5Br6rfr90HPQ8SpcUCf8nf39bK4+M4mlV99DY+SMCe8fuj9SF+Hv4OM1XzXtn/nmWbcipc8XD68ev9azVBT/wmOgtekhSfp1flW6dXBND3V7MvB+nFzKzi4fS4yZsJesd1ufbhOrzx6IT48/N3WlV9sAhcESShoqqX1b2aktdM0Dv/8v7XzixNZEt8oBicECaZQm0pX5TQSrycoHd5+e8vt0sbU59XT73KD5e+vZjuvBGXXERVr8Sr8/DD753TMj3xB5JVffCITAmasP2qNv5xp8SrCXriFcO0qdO5L7vjSvQSjAh32ETNh01W0asXK1uKMqom5zUT9PLLn6ZTYesrd/I/o5SEnUJGTD6t9Jx+6rykJf7yUvQPjOfwkzr0oFA78sNdp6bXbOML58csM7xuG/zwqZQyIskYJ+nTub5II+d67Pi1WZp4oInJII3h+dxo0D5LRudqZiCSKe0Cg2HZw+rYs6nZ7KD9X+EJ+gOgJX26I24wEeP8/N3ohI5MVtRjGj7j8Bj2DByJFzsfFCX+4e/uZnbzg1YfCpljfYNaLoIlYV3tjlIOy5bPj6Nts2bnTmxttTKceqeZHXE2y3H2AwjWlKjRj9vHGnl1thqWldfpRy62cu/V2zYDZA5SeBbW82pYVv1jCCrio1eXM5qB6GluI1r1co/RZlhWbks1ABXxsar8PmKdDlqhSnxrWLZg5DSMjnh6jDUD9H4YzRYpclhWSE9IPL0MzbvNAMU0Vr16OSwrdkrZu+jVD+Ngg8Obr5F0X+H7ekAwtCZbjlwMcLXBodMvg2n0ZtkOq3e2wWHn21DvFZ2qfp8Nj9G43ODw9vtQ7xGDa/X9ON7g0EsgoAu1Xn03FKg3o3d8pvuinnhxn6m+G0314npePdQb4VJ8NTrXZ9756Vw/sD+O6GuJ2fPHh78//VqunuyM1l1/wWg8fqBz5+N0rgvt83t7Jo5v6n6Rh3V+KHwf1qdHuYhCrpdsRutuwxtPzWSJ93Y6xwzrX/Xp8/tf31ZqFnyzXlK81XtfA9s23uPpXC/LK/aOajJxteX10/fnm/WSrdG6m2jHgwu+X/00y6ry3R3M/o+fLi/f5N1qmvWS16N17YjHQ4t/Ogc0OWaylb9eL9laRHlNquLTL/aua66yT3//VotX6yWb0bqb6MdDIys+9So/euLTFZ8qRH6weuLjb2k6GAmJXNSHTHo1l1CR2NJ0IBoyeTkOsXRaj87NDtotpDK1B1rWc6O1c46Ddgy5nK0gVtIrNKt6sm18Oz6KGUwyUYKl9eqp5jM5liaeThEjWsVX6Imnvc/dbbxZHt9/7Pgn0Wvjie9z1x99pB8A8ZJeoXs6R32fu2EGVhV7iy1AJC7Qm4ixnH3u/P0AEinpFXptfBr73Jng+geQlvV8gb16Q5oNJixCcJieYHgQH3TbcnfM+wGkdpQ12nPuHv43vrWGcdBU0f4BJOu8RHeW7enzu9kud8mKr5g4G0hbu/7pXCE+0dM5N9z+AJI/OIMS37+SZmbQqRYYz52XcNniYe2cZtDpdf98EzRD4p7OwX1N6KyIPucOBT+PUgB0B2ncB93+JGv3kfZ0HX872Jw7tu5jHbfmeHyIOXcMK/2IR0xsIgYn93GPlUQbf/01FvKjHySVNv7mq7GzxS8UDo9QG3/zbQq54wMix0V6Xj2RPHIInSOiPhFjSQWf1KFQF18GRCnD5kLtIKzFnx6z1aG3GXA7pY1WthlCMPm24sVtUMSE+1P3zmSOjzXZSp9mum3Flze5Wvvf2VIFSTIPR6Ga4nRKfBVqSvIJp9VFG7/238bfhEw3P1vQTmUKvfrewGlnK3Hredrz6slmLtmEtUi1xFdx0MtjeinqJXHxZTyEcppSWsaxPp17UvV6sE2M+6CR3zRSoYl1iZd72c8I2jGxK/2krOcuqvrBWRrhMyJa5qdmPV9EG38daXgHCVrPlye+jDgLdkZJ95LsFEsU3yLr4jh4l8GFZOHie3D2U0jYes5RfJc51ULa1nOIH2D8t5C89Rzi9QnaZfQPxDMF4pkC8UzxKR5Qxp94kDAQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4p7sWb3prYQSTeowxyTGFJtMQHFr9ArMWfHrNsU+6f8OHn3enHr/evn94uL9+ybC1vT128cf+Wizfe5FNziu/d7aqAPv+7iE88f22CnCP+mFXfLP7Oz/8RUdwktjggdXjFR2TEToLue7/6WDBsxYvF8+IQ9uv8eLc7PZaZdNmuihxb1W88vIs3xFOxY54pl+1GBFEFJB8KEypI+S/jdIt9G1d17j89vB/v31QK65DvdurwyujKqBwE3ft+9bFguKjqiyMRB3N52amDEZsiir8i28QbxYN4Q2TinDsiSK2tgJQJEWTzomma5W4Pde5vRIJVCquQxSHImFV0evFMBt37vnwwPYz52Ivfi4pL7HvZK168ot4od9OZUZ3JPTVbATXiWy8ah/oo0lLlvnCx36gUli/KA6oOz0T8VND978sH48OYjXVV/7SRLZVGiZ91/xNPJV6gGgmV+6LYyRS2Srw6PDPxE0H3vy8f5hzGPGzFl8n/uKva+I74diu8120lrxFtfPH9JqDGxPw2XiSk+BMpPIgWdlW+cpNYdUAfd0bip4Lufb/6WDCsq/pDln34uhH1+D/7Snze6nfL3rk5V716FcNWnD3k+fxe/V5u4FYk/19FF+XLb1XXW1XC6oDU4ZmV+Kmg+96vPhYMh+fxCZ9N92/s5eSApu7spt6fdwM4CxyJF7chD/qDdUs3250d0MLFg9SAeKZAPFMgnikQzxSIZwrEMwXimQLxTIF4pkA8UyCeKRDPFIhnCsQzBeKZAvFMgXimQLxAY3ZdwjMKe4F4AcQvmZG1imqhz71YRNFZ71kv01yUeT7ix9YqqtWdxds36z3LdY5zF22QhpH4kbWKailT8dtor/5q1jlWC3cWBB/xY2sVy19CuaqxLb61hBLi02ZoraJa9llws94zr6sIiE+VsbWKp3oHh/71nhCfMiNrFVWv/m6X36z3bNqGyxa9+iUQa8kaGSA+dkoiwVU8eyCeKRDPFIhnCsQzBeKZAvFMgXimQDxTIJ4pEM8UiGcKxDMF4pkC8UyBeKb8H3Ojf6rHuYeBAAAAAElFTkSuQmCC" alt="plot of chunk unnamed-chunk-27"/> </p>

<p>The fact that these lines are fairly parallel, suggests that the effects of the supplements are similar across all diets.</p>

<p>As usual, it is often very useful to generate a summary table of the data.  We&#39;ll use <code>tapply</code>, but in a somewhat different way this time, structuring the application with a list.</p>

<pre><code class="r">tapply(gain, list(diet, supplement), mean)
</code></pre>

<pre><code>##        agrimore control supergain supersupp
## barley    26.35   23.30     22.47     25.58
## oats      23.30   20.49     19.66     21.86
## wheat     19.64   17.41     17.01     19.67
</code></pre>

<p>With some manipulation, we can make a decent looking table of means and standard deviations:</p>

<pre><code class="r">M &lt;- tapply(gain, list(supplement, diet), mean)
S &lt;- tapply(gain, list(supplement, diet), sd)
Summary &lt;- M
Summary[1:length(Summary)] &lt;- paste(round(M, 1), &quot; (&quot;, round(S, 2), &quot;)&quot;, sep = &quot;&quot;)
Summary &lt;- data.frame(Supplement = levels(supplement), Summary)
print(gvisTable(Summary, options = list(height = 150)), &quot;chart&quot;)
</code></pre>

<!-- Table generated in R 2.15.0 by googleVis 0.2.15 package -->

<!-- Mon Dec 03 23:25:33 2012 -->

<!-- jsHeader -->

<script type="text/javascript" src="http://www.google.com/jsapi">
</script>

<script type="text/javascript">
 
// jsData 
function gvisDataTableID1c4823224f45 ()
{
  var data = new google.visualization.DataTable();
  var datajson =
[
 [
 "agrimore",
"26.3 (1.84)",
"23.3 (1.23)",
"19.6 (1.42)" 
],
[
 "control",
"23.3 (1.41)",
"20.5 (1.01)",
"17.4 (0.92)" 
],
[
 "supergain",
"22.5 (1.54)",
"19.7 (0.7)",
"17 (0.97)" 
],
[
 "supersupp",
"25.6 (2.12)",
"21.9 (0.83)",
"19.7 (0.95)" 
] 
];
data.addColumn('string','Supplement');
data.addColumn('string','barley');
data.addColumn('string','oats');
data.addColumn('string','wheat');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartTableID1c4823224f45() {
  var data = gvisDataTableID1c4823224f45();
  var options = {};
options["allowHtml"] = true;
options["height"] =    150;

     var chart = new google.visualization.Table(
       document.getElementById('TableID1c4823224f45')
     );
     chart.draw(data,options);
    

}
  
 
// jsDisplayChart 
function displayChartTableID1c4823224f45()
{
  google.load("visualization", "1", { packages:["table"] }); 
  google.setOnLoadCallback(drawChartTableID1c4823224f45);
}
 
// jsChart 
displayChartTableID1c4823224f45()
 
<!-- jsFooter -->  
//-->
</script>
 

<!-- divChart -->

<div id="TableID1c4823224f45"
  style="width: 600px; height: 150px;">
</div>

<p>Ok, with little further ado, let&#39;s perform an analysis of variance in three short steps.  First, fit the linear model:</p>

<pre><code class="r">Growth.lm &lt;- lm(gain ~ diet * supplement, data = Growth)
</code></pre>

<p>Second, look at the diagnostic plots:</p>

<pre><code class="r">par(mfrow = c(2, 2))
plot(Growth.lm)
</code></pre>

<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfgAAAH4CAMAAACR9g9NAAAA51BMVEX9/v0AAAAAADkAAGUAOWUAOY8AZmUAZo8AZrU5AAA5ADk5AGU5OTk5OWU5OY85ZmU5Zo85ZrU5j485j9plAABlADllAGVlOQBlOTllOWVlOY9lZjllZmVlZo9lZrVlj9pltdpltf1/f3+POQCPOTmPOWWPZgCPZmWPZo+Pj2WPj7WPj9qPtY+Ptf2P27WP29qP2/21ZgC1Zjm1ZmW1j4+1tWW124+12/21/rW1/tq1/v2+vr7ajznaj2XatWXa24/a29ra/rXa/tra/v39tWX9tY/9tbX924/927X9/rX9/tr9/v3/AADcN6xUAAAATXRSTlP///////////////////////////////////////////////////////////////////////////////////////////////////8A/21MA38AAAAJcEhZcwAACxIAAAsSAdLdfvwAACAASURBVHic7Z0JY9w2dseXUtSOfCjNSnF2nTTZkey03aMZ2tnUGdObOGJ3OkN//89TXDwHN3GReP9EsmYIggB/xMP1AP6uAWWp38VOACiOAHymAvCZCsBnKgCfqQB8pgLwmQrAZyoAn6kAfKYC8JkKwGcqAJ+pAHymAvCZCsBnKgCfqQB8pgLwmQrAZyoAn6kAfKYC8JkKwGcqAJ+pAHymAvCZCsBnKgCfqQB8pgLwmQrAZyoAn6kAfKbyAv5wXSBd7qdfPyXfnB623O8lUd2iIPT/waGzeJLV4RqnVJbNZnC8Qhnucjb64FJ+wJMsVFeP3KNm4LtjiwaPC4Em+BLdtuMdy9rog1N5BI9/H+9Iwa9J+WdffPbVFv9Ffq7x84z/qpmFONw8NqdXu/ZjezcOT9/dUSvCYqTx+Ei8Bx2e/n0zvB+H519d/vzqv5AlQ/m8bQa3oc1wTQvN6INbeS7x5W1TbZrjiz3+B3+NvqiLFvzxyx0ryCxEg6Ej+B/bjz341tTTGFk8PhLvQSjd5bbL/tUjNv2nB3RDrjfj24DC1iTb+KvpB7fyWMdjK4WSjJiylDPAyES3JR4JfcPyTlUhsLf9RxLVpgffxkjj8ZF4D8LpfvnIso9ygLOOn3D8w7JKbwP6gz7v+Mj0g1t5K/H1xY4Y5KJAfyB8F/1TXfbg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" alt="plot of chunk unnamed-chunk-31"/> </p>

<p>The diagnostic plots look fine.   Finally, compute the anova table:</p>

<pre><code class="r">anova(Growth.lm)
</code></pre>

<pre><code>## Analysis of Variance Table
## 
## Response: gain
##                 Df Sum Sq Mean Sq F value Pr(&gt;F)    
## diet             2  287.2   143.6   83.52  3e-14 ***
## supplement       3   91.9    30.6   17.81  3e-07 ***
## diet:supplement  6    3.4     0.6    0.33   0.92    
## Residuals       36   61.9     1.7                   
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1
</code></pre>

<p>The p-values here suggest strongly that there are highly significant main effects, but no significant interaction effects. The supplements act in similar ways across all basic feed types, and there is strong evidence that Argimore and Supersupp are the superior supplement, whereas supergain might be made out of sawdust. </p>

<blockquote>
<p><strong>Topic for discussion</strong>: Each p-value represents a hypothesis test. What exactly are the hypotheses being tested?</p>
</blockquote>

<h2>3. Inference on Linear Regression</h2>

<p>Load the sleep data:</p>

<pre><code class="r">Sleep.df &lt;- read.csv(&quot;http://faculty.washington.edu/eliezg/data/Sleep.csv&quot;)
Sleep &lt;- Sleep.df$Sleep
ZOD &lt;- Sleep.df$ZOD
</code></pre>

<p>Or, by hand:</p>

<pre><code class="r">Sleep &lt;- c(2.6, 4.2, 4.3, 4.8, 4.9, 5.3, 5.5, 5.6, 5.6, 6.5, 6.8, 7.8, 7.8, 
    8, 8.4)
ZOD &lt;- c(13, 8, 13, 10, 10, 9, 8, 10, 9, 1, 4, 3, 2, 0, 6)
</code></pre>

<p>Plot the data:</p>

<pre><code class="r">plot(Sleep, ZOD, xlab = &quot;Sleep (hrs)&quot;, ylab = &quot;Zone-out duration (min)&quot;, pch = 19, 
    col = rgb(0, 0, 0, 0.3), cex = 2)
</code></pre>

<p><img src="data:image/png;base64,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" alt="plot of chunk unnamed-chunk-35"/> </p>

<p>We&#39;ve already estimated regression parameters in this class, but as a brief review, here is how you obtain \( \widehat\alpha \) and \( \widehat\beta \):</p>

<pre><code class="r">Sleep.mean &lt;- mean(Sleep)
ZOD.mean &lt;- mean(ZOD)
(beta.hat &lt;- sum((Sleep - Sleep.mean) * (ZOD - ZOD.mean))/sum((Sleep - Sleep.mean)^2))
</code></pre>

<pre><code>## [1] -2.117
</code></pre>

<pre><code class="r">(alpha.hat &lt;- ZOD.mean - alpha.hat * Sleep.mean)
</code></pre>

<pre><code>## Error: object &#39;alpha.hat&#39; not found
</code></pre>

<p>Which we can add to out plot with the <code>abline()</code> function:</p>

<pre><code class="r">plot(Sleep, ZOD, xlab = &quot;Sleep (hrs)&quot;, ylab = &quot;Zone-out duration (min)&quot;, pch = 19, 
    col = rgb(0, 0, 0, 0.3), cex = 2)
</code></pre>

<p><img src="data:image/png;base64,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" alt="plot of chunk unnamed-chunk-37"/> </p>

<pre><code class="r">abline(beta.hat, alpha.hat, col = 2, lwd = 2)
</code></pre>

<pre><code>## Error: object &#39;alpha.hat&#39; not found
</code></pre>

<p>Now, lets let <code>R</code> fit the linear model</p>

<pre><code class="r">Sleep.lm &lt;- lm(ZOD ~ Sleep)
summary(Sleep.lm)
</code></pre>

<pre><code>## 
## Call:
## lm(formula = ZOD ~ Sleep)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.740 -1.051  0.143  1.113  4.283 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(&gt;|t|)    
## (Intercept)   19.503      2.335    8.35  1.4e-06 ***
## Sleep         -2.117      0.384   -5.52  9.9e-05 ***
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1 
## 
## Residual standard error: 2.37 on 13 degrees of freedom
## Multiple R-squared: 0.701,   Adjusted R-squared: 0.678 
## F-statistic: 30.5 on 1 and 13 DF,  p-value: 9.89e-05
</code></pre>

<p>Note that the output of the linear model summary has some t-values attached to the two coeffients.  In contrast to the fitted factor model above, these t-values correspond to useful tests.  Specifically, they test: \( H_0: \alpha = 0 \) and \( H_0: \beta = 0 \).  It turns out that the statistic: 
\[ t_\beta = \frac{\widehat{\beta}}{MSE}\sum_{i=1}^n {X_i - \overline{X})^2} \]
happens to have a \( {\cal T(\nu = n-2)} \) distribution under the null-hypothesis.  And a similar statistic can be constructed for the intercept \( \widehat{\alpha} \).</p>

<p>Of course, it is somewhat more straightforward to compute the ANOVA table:</p>

<pre><code class="r">anova(Sleep.lm)
</code></pre>

<pre><code>## Analysis of Variance Table
## 
## Response: ZOD
##           Df Sum Sq Mean Sq F value  Pr(&gt;F)    
## Sleep      1  171.7   171.7    30.5 9.9e-05 ***
## Residuals 13   73.3     5.6                    
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1
</code></pre>

<p>Note that the <em>p</em>-value is very small (highly significant), and exactly equal to the \( p \)-value on the slope in the <code>summary()</code> command.  This is not a coincidence, the <em>F</em>-statistic used in the ANOVA is exactly the square of the \( t \)-statistic above.  </p>

<blockquote>
<p><strong>Quick exercise:</strong> Confirm this fact by extracting the <em>t</em>-statistic from the summary output.  (Hint: it is hidden under the <code>$coef</code> portion of the summary object).</p>
</blockquote>

<p>We know that the <em>T</em> distribution models the ratio between a \( {\cal N}(0,1) \) and the square root of a \( \chi^2 \) random variable, so it is perhaps unsurprising that the square of that statistic has the appropriate <em>F</em> null-distribution.  Before we forget, we should always plot the diagnostic plots.</p>

<pre><code class="r">plot(Sleep.lm)
</code></pre>

<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfgAAAH4CAMAAACR9g9NAAABHVBMVEX9/v0AAAAAACgAADkAAGUAOTkAOWUAOY8AZoEAZo8AZrUoZtooj9o5AAA5ADk5AGU5OTk5OWU5OY85ZmU5ZrU5j485j5w5j9pXOShlAABlADllAGVlOQBlOTllOWVlOY9lSEhlZjllZmVlZrVlj49lj9pltbVltdpltf1/f3+POQCPOTmPOWWPZgCPZo+Pj2WPj7WPj9qPtY+P29qP2/21WAC1ZgC1Zjm1ZmW1j4+1tWW124+12/21/rW1/tq1/v2+vr7ajznaj2XatWXa24/a29ra/rXa/tra/v3bAAD9jzn9tWX9tY/9tbX924/927X9/rX9/tr9/v3+Zjn+ZmX+ZrX+j9r+tf3+2/3+/v3/AAD/ADn/AGX/OTn/ZrVRZZVRAAAAX3RSTlP/////////////////////////////////////////////////////////////////////////////////////////////////////////////AP///////////////4N2PAcAAAAJcEhZcwAACxIAAAsSAdLdfvwAACAASURBVHic7Z0JY+S2dcfNSo7aabWHolSV14nquG7H2nWbYzprx7W1dJLNxEzZEXPYnhzf/2MUDwA5B3ETAEHi/XdXqxmSbwD8Bg8g8EC806Cy1DtjJwA1jhB8pkLwmQrBZyoEn6kQfKZC8JkKwWcqBJ+pEHymQvCZCsFnKgSfqRB8pkLwmQrBZyoEn6kQfKZC8JkKwWcqBJ+pEHymQvCZCsFnKgSfqRB8pkLwmQrBZyoEn6kQfKZC8JkKwWcqBJ+pEHymCgK+viyIzh9O335K33m8XwrfV5i6IaewvweHenaSVX0JKVVlszk4XpIMdzk7euFTYcDTLJQXG+FRO/DdsUmDh0pgCH5Nim17y7N29MKrAoKHn9tbWvErWv/5G997fwm/0X+X8H2G3yruIeqrTfP4ctW+bEujfvrFLfMi3CKzEyLxAVQ//cXisDzq5++ff/nyv4gnI/m8aQ6Koc1wxSrN0Qu/Clzj1zdNuWi2Lx7gP3ibvFEVLfjteytekfkZDUAn8N+2L/fgW1fPLHI7IRIfQCTd62WX/YsNuP7He1Igl4vjYiDnVjTb8NbpC78K2MaDlyJJ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" alt="plot of chunk unnamed-chunk-40"/> </p>

<blockquote>
<p><strong>Exercise:</strong> Randomize either Sleep or ZOD and perform this regression (i.e. plot the relatinship, fit the linear model, draw the regression line, and perform an ANOVA).  Do this a bunch of times.  Do you ever geta significant result at the 5% significance level?</p>
</blockquote>

<h2>4. ANCOVA: Continuous and Discrete covariates</h2>

<pre><code class="r">PieSleep.df &lt;- read.csv(&quot;http://faculty.washington.edu/eliezg/data/PieSleep.csv&quot;)
print(gvisTable(PieSleep.df, options = list(height = 200, width = 200)), &quot;chart&quot;)
</code></pre>

<!-- Table generated in R 2.15.0 by googleVis 0.2.15 package -->

<!-- Mon Dec 03 23:25:34 2012 -->

<!-- jsHeader -->

<script type="text/javascript" src="http://www.google.com/jsapi">
</script>

<script type="text/javascript">
 
// jsData 
function gvisDataTableID1c4841935788 ()
{
  var data = new google.visualization.DataTable();
  var datajson =
[
 [
 "A",
3.285173207,
8 
],
[
 "A",
3.308277955,
7 
],
[
 "A",
3.379937073,
3 
],
[
 "A",
3.721991067,
4 
],
[
 "A",
3.780649365,
3 
],
[
 "A",
3.907599645,
6 
],
[
 "A",
3.918759832,
6 
],
[
 "A",
4.234696084,
1 
],
[
 "A",
  4.3621453,
6 
],
[
 "A",
4.389407236,
4 
],
[
 "A",
5.492562612,
2 
],
[
 "A",
5.438526477,
1 
],
[
 "A",
4.660287069,
4 
],
[
 "A",
5.086328883,
0 
],
[
 "A",
4.755998743,
2 
],
[
 "B",
5.073365378,
2 
],
[
 "B",
5.001977539,
3 
],
[
 "B",
5.459092974,
4 
],
[
 "B",
5.433959574,
3 
],
[
 "B",
4.638185363,
6 
],
[
 "B",
5.715548857,
2 
],
[
 "B",
5.790939854,
2 
],
[
 "B",
5.806455955,
5 
],
[
 "B",
5.876242144,
1 
],
[
 "B",
7.037894668,
1 
],
[
 "B",
6.981818799,
4 
],
[
 "B",
6.122155701,
5 
],
[
 "B",
6.018731085,
0 
],
[
 "B",
7.281137518,
1 
],
[
 "B",
7.022948502,
2 
],
[
 "C",
5.922520764,
12 
],
[
 "C",
5.986209698,
10 
],
[
 "C",
 6.70105288,
5 
],
[
 "C",
6.409453027,
10 
],
[
 "C",
6.287252858,
9 
],
[
 "C",
7.598549485,
4 
],
[
 "C",
7.731432257,
4 
],
[
 "C",
8.082781099,
0 
],
[
 "C",
 8.13503464,
0 
],
[
 "C",
8.341620903,
4 
],
[
 "C",
8.398207872,
4 
],
[
 "C",
8.413051354,
4 
],
[
 "C",
8.831281697,
0 
],
[
 "C",
9.317522461,
7 
],
[
 "C",
10.94607651,
0 
] 
];
data.addColumn('string','Pie');
data.addColumn('number','Sleep');
data.addColumn('number','ZOD');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartTableID1c4841935788() {
  var data = gvisDataTableID1c4841935788();
  var options = {};
options["allowHtml"] = true;
options["height"] =    200;
options["width"] =    200;

     var chart = new google.visualization.Table(
       document.getElementById('TableID1c4841935788')
     );
     chart.draw(data,options);
    

}
  
 
// jsDisplayChart 
function displayChartTableID1c4841935788()
{
  google.load("visualization", "1", { packages:["table"] }); 
  google.setOnLoadCallback(drawChartTableID1c4841935788);
}
 
// jsChart 
displayChartTableID1c4841935788()
 
<!-- jsFooter -->  
//-->
</script>
 

<!-- divChart -->

<div id="TableID1c4841935788"
  style="width: 200px; height: 200px;">
</div>

<pre><code class="r">Pie &lt;- PieSleep.df$Pie
Sleep &lt;- PieSleep.df$Sleep
ZOD &lt;- PieSleep.df$ZOD
</code></pre>

<p>Note that a quick one-way ANOVA against the Pie effect=is not significant:</p>

<pre><code class="r">boxplot(ZOD ~ Pie, col = c(3, 4, 2))
</code></pre>

<p><img src="data:image/png;base64,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" alt="plot of chunk unnamed-chunk-43"/> </p>

<pre><code class="r">tapply(ZOD, Pie, mean)
</code></pre>

<pre><code>##     A     B     C 
## 3.800 2.733 4.867
</code></pre>

<pre><code class="r">anova(lm(ZOD ~ Pie))
</code></pre>

<pre><code>## Analysis of Variance Table
## 
## Response: ZOD
##           Df Sum Sq Mean Sq F value Pr(&gt;F)
## Pie        2     34   17.07    2.07   0.14
## Residuals 42    347    8.26
</code></pre>

<p>Plot all the data:</p>

<pre><code class="r">cols &lt;- c(&quot;green&quot;, &quot;blue&quot;, &quot;red&quot;)[Pie]
plot(Sleep, ZOD, col = cols, pch = 19)
legend(&quot;topright&quot;, legend = c(&quot;Apple&quot;, &quot;Blueberry&quot;, &quot;Cherry&quot;), col = 1:3, pch = 19)
</code></pre>

<p><img src="data:image/png;base64,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" alt="plot of chunk unnamed-chunk-44"/> </p>

<p>Add some regression lines:</p>

<pre><code class="r">abline(lm(ZOD[Pie == &quot;A&quot;] ~ Sleep[Pie == &quot;A&quot;]), col = &quot;green&quot;)
abline(lm(ZOD[Pie == &quot;B&quot;] ~ Sleep[Pie == &quot;B&quot;]), col = &quot;blue&quot;)
abline(lm(ZOD[Pie == &quot;C&quot;] ~ Sleep[Pie == &quot;C&quot;]), col = &quot;red&quot;)
</code></pre>

<p><img src="data:image/png;base64,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" alt="plot of chunk unnamed-chunk-45"/> </p>

<p>Ok, lets fit a model that includes the Pie effect, the Sleep effect and their interaction:</p>

<pre><code class="r">PieSleep.lm &lt;- lm(ZOD ~ Pie * Sleep)
anova(PieSleep.lm)
</code></pre>

<pre><code>## Analysis of Variance Table
## 
## Response: ZOD
##           Df Sum Sq Mean Sq F value Pr(&gt;F)    
## Pie        2   34.1    17.1    3.74  0.033 *  
## Sleep      1  156.8   156.8   34.40  8e-07 ***
## Pie:Sleep  2   12.4     6.2    1.36  0.267    
## Residuals 39  177.8     4.6                   
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1
</code></pre>

<p>The interaction is clearly not significant.  So we fit a main-effect only model:</p>

<pre><code class="r">PieSleep.lm &lt;- lm(ZOD ~ Pie + Sleep)
anova(PieSleep.lm)
</code></pre>

<pre><code>## Analysis of Variance Table
## 
## Response: ZOD
##           Df Sum Sq Mean Sq F value Pr(&gt;F)    
## Pie        2   34.1    17.1    3.68  0.034 *  
## Sleep      1  156.8   156.8   33.80  8e-07 ***
## Residuals 41  190.2     4.6                   
## ---
## Signif. codes:  0 &#39;***&#39; 0.001 &#39;**&#39; 0.01 &#39;*&#39; 0.05 &#39;.&#39; 0.1 &#39; &#39; 1
</code></pre>

<p>This is the most &ldquo;parsimonious&rdquo; model.  Note that to specify it, we need to obtain all the relevant parameters. We can obtain those directly from the output of:</p>

<pre><code class="r">PieSleep.lm
</code></pre>

<pre><code>## 
## Call:
## lm(formula = ZOD ~ Pie + Sleep)
## 
## Coefficients:
## (Intercept)         PieB         PieC        Sleep  
##       11.88         2.17         7.83        -1.90
</code></pre>

<p>The intercept corresponds to the intercept for the Apple group, the PieB and PieC effects are additive on the intercept, the slope is common to all of them.  Thus:</p>

<pre><code class="r">alpha.A &lt;- PieSleep.lm$coef[1]
alpha.B &lt;- alpha.A + PieSleep.lm$coef[2]
alpha.C &lt;- alpha.A + PieSleep.lm$coef[3]
beta &lt;- PieSleep.lm$coef[4]
</code></pre>

<p>Finally, the variance coefficient is the mean square residual:</p>

<pre><code class="r">names(anova(PieSleep.lm))
</code></pre>

<pre><code>## [1] &quot;Df&quot;      &quot;Sum Sq&quot;  &quot;Mean Sq&quot; &quot;F value&quot; &quot;Pr(&gt;F)&quot;
</code></pre>

<pre><code class="r">sigma2 &lt;- anova(PieSleep.lm)$Mean[3]
</code></pre>

<p>Let&#39;s write out the results:</p>

<pre><code class="r">t(data.frame(alpha.A, alpha.B, alpha.C, beta, sigma2))
</code></pre>

<pre><code>##         (Intercept)
## alpha.A      11.876
## alpha.B      14.046
## alpha.C      19.708
## beta         -1.901
## sigma2        4.640
</code></pre>

<p>A very nice model.  Cherry pie is still the pie least conducive to concentration in class - the apparent lack of a significant result is due to the fact that the study was - in fact - poorly designed and the apple pie eating subjects were disadvantaged by having the least sleep. </p>

<p>Note that these data were simulated, and when I simulated them I made the intercepts 10, 15 and 20 minutes respectively, with a slope of -2 and a variance of 4.  So the model managed to identify these values fairly closely. </p>

</body>

</html>

