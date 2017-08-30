/*!
 * froala_editor v2.0.1 (https://www.froala.com/wysiwyg-editor)
 * License https://froala.com/wysiwyg-editor/terms
 * Copyright 2014-2015 Froala Labs
 */
!function(e){"function"==typeof define&&define.amd?module.exports=function(t,n){return void 0===n&&(n="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(n),n}:e(jQuery)}(function(e){"use strict";e.extend(e.FroalaEditor.DEFAULTS,{inlineStyles:{"Big Red":"font-size: 20px; color: red;","Small Blue":"font-size: 14px; color: blue;"}}),e.FroalaEditor.PLUGINS.inlineStyle=function(t){function n(n){""!==t.selection.text()?t.html.insert(e.FroalaEditor.START_MARKER+'<span style="'+n+'">'+t.selection.text()+"</span>"+e.FroalaEditor.END_MARKER):t.html.insert('<span style="'+n+'">'+e.FroalaEditor.INVISIBLE_SPACE+e.FroalaEditor.MARKERS+"</span>")}return{apply:n}},e.FroalaEditor.RegisterCommand("inlineStyle",{type:"dropdown",html:function(){var e='<ul class="fr-dropdown-list">',t=this.opts.inlineStyles;for(var n in t)e+='<li><span style="'+t[n]+'"><a class="fr-command" data-cmd="inlineStyle" data-param1="'+t[n]+'" title="'+this.language.translate(n)+'">'+this.language.translate(n)+"</a></span></li>";return e+="</ul>"},title:"Inline Style",callback:function(e,t){this.inlineStyle.apply(t)}}),e.FroalaEditor.DefineIcon("inlineStyle",{NAME:"paint-brush"})});