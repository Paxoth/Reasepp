!function(a){"function"==typeof define&&define.amd?module.exports=function(e,r){return void 0===r&&(r="undefined"!=typeof window?require("jquery"):require("jquery")(e)),a(r),r}:a(jQuery)}(function(a){"use strict";a.extend(a.FroalaEditor.DEFAULTS,{paragraphStyles:{"fr-text-gray":"Gray","fr-text-bordered":"Bordered","fr-text-spaced":"Spaced","fr-text-uppercase":"Uppercase"},paragraphMultipleStyles:!0}),a.FroalaEditor.PLUGINS.paragraphStyle=function(e){function r(r){var t="";e.opts.paragraphMultipleStyles||(t=Object.keys(e.opts.paragraphStyles),t.splice(t.indexOf(r),1),t=t.join(" ")),e.selection.save(),e.html.wrap(!0,!0,!0),e.selection.restore();var s=e.selection.blocks();e.selection.save();for(var l=0;l<s.length;l++)a(s[l]).removeClass(t).toggleClass(r),a(s[l]).hasClass("fr-temp-div")&&a(s[l]).removeClass("fr-temp-div"),""===a(s[l]).attr("class")&&a(s[l]).removeAttr("class");e.html.unwrap(),e.selection.restore()}function t(r,t){var s=e.selection.blocks();if(s.length){var l=a(s[0]);t.find(".fr-command").each(function(){var e=a(this).data("param1");a(this).toggleClass("fr-active",l.hasClass(e))})}}function s(){}return{_init:s,apply:r,refreshOnShow:t}},a.FroalaEditor.RegisterCommand("paragraphStyle",{type:"dropdown",html:function(){var a='<ul class="fr-dropdown-list">',e=this.opts.paragraphStyles;for(var r in e)a+='<li><a class="fr-command '+r+'" data-cmd="paragraphStyle" data-param1="'+r+'" title="'+this.language.translate(e[r])+'">'+this.language.translate(e[r])+"</a></li>";return a+="</ul>"},title:"Paragraph Style",callback:function(a,e){this.paragraphStyle.apply(e)},refreshOnShow:function(a,e){this.paragraphStyle.refreshOnShow(a,e)}}),a.FroalaEditor.DefineIcon("paragraphStyle",{NAME:"magic"})});