/*!
 * froala_editor v2.0.1 (https://www.froala.com/wysiwyg-editor)
 * License https://froala.com/wysiwyg-editor/terms
 * Copyright 2014-2015 Froala Labs
 */
!function(e){"function"==typeof define&&define.amd?module.exports=function(t,n){return void 0===n&&(n="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(n),n}:e(jQuery)}(function(e){"use strict";e.extend(e.FroalaEditor.POPUP_TEMPLATES,{emoticons:"[_BUTTONS_][_EMOTICONS_]"}),e.extend(e.FroalaEditor.DEFAULTS,{emoticonsStep:8,emoticonsSet:[{code:"&#x1f600;",desc:"Grinning face"},{code:"&#x1f601;",desc:"Grinning face with smiling eyes"},{code:"&#x1f602;",desc:"Face with tears of joy"},{code:"&#x1f603;",desc:"Smiling face with open mouth"},{code:"&#x1f604;",desc:"Smiling face with open mouth and smiling eyes"},{code:"&#x1f605;",desc:"Smiling face with open mouth and cold sweat"},{code:"&#x1f606;",desc:"Smiling face with open mouth and tightly-closed eyes"},{code:"&#x1f607;",desc:"Smiling face with halo"},{code:"&#x1f608;",desc:"Smiling face with horns"},{code:"&#x1f609;",desc:"Winking face"},{code:"&#x1f60a;",desc:"Smiling face with smiling eyes"},{code:"&#x1f60b;",desc:"Face savoring delicious food"},{code:"&#x1f60c;",desc:"Relieved face"},{code:"&#x1f60d;",desc:"Smiling face with heart-shaped eyes"},{code:"&#x1f60e;",desc:"Smiling face with sunglasses"},{code:"&#x1f60f;",desc:"Smirking face"},{code:"&#x1f610;",desc:"Neutral face"},{code:"&#x1f611;",desc:"Expressionless face"},{code:"&#x1f612;",desc:"Unamused face"},{code:"&#x1f613;",desc:"Face with cold sweat"},{code:"&#x1f614;",desc:"Pensive face"},{code:"&#x1f615;",desc:"Confused face"},{code:"&#x1f616;",desc:"Confounded face"},{code:"&#x1f617;",desc:"Kissing face"},{code:"&#x1f618;",desc:"Face throwing a kiss"},{code:"&#x1f619;",desc:"Kissing face with smiling eyes"},{code:"&#x1f61a;",desc:"Kissing face with closed eyes"},{code:"&#x1f61b;",desc:"Face with stuck out tongue"},{code:"&#x1f61c;",desc:"Face with stuck out tongue and winking eye"},{code:"&#x1f61d;",desc:"Face with stuck out tongue and tightly-closed eyes"},{code:"&#x1f61e;",desc:"Disappointed face"},{code:"&#x1f61f;",desc:"Worried face"},{code:"&#x1f620;",desc:"Angry face"},{code:"&#x1f621;",desc:"Pouting face"},{code:"&#x1f622;",desc:"Crying face"},{code:"&#x1f623;",desc:"Persevering face"},{code:"&#x1f624;",desc:"Face with look of triumph"},{code:"&#x1f625;",desc:"Disappointed but relieved face"},{code:"&#x1f626;",desc:"Frowning face with open mouth"},{code:"&#x1f627;",desc:"Anguished face"},{code:"&#x1f628;",desc:"Fearful face"},{code:"&#x1f629;",desc:"Weary face"},{code:"&#x1f62a;",desc:"Sleepy face"},{code:"&#x1f62b;",desc:"Tired face"},{code:"&#x1f62c;",desc:"Grimacing face"},{code:"&#x1f62d;",desc:"Loudly crying face"},{code:"&#x1f62e;",desc:"Face with open mouth"},{code:"&#x1f62f;",desc:"Hushed face"},{code:"&#x1f630;",desc:"Face with open mouth and cold sweat"},{code:"&#x1f631;",desc:"Face screaming in fear"},{code:"&#x1f632;",desc:"Astonished face"},{code:"&#x1f633;",desc:"Flushed face"},{code:"&#x1f634;",desc:"Sleeping face"},{code:"&#x1f635;",desc:"Dizzy face"},{code:"&#x1f636;",desc:"Face without mouth"},{code:"&#x1f637;",desc:"Face with medical mask"}],emoticonsButtons:["emoticonsBack","|"]}),e.FroalaEditor.PLUGINS.emoticons=function(t){function n(){var e=t.$tb.find('.fr-command[data-cmd="emoticons"]'),n=t.popups.get("emoticons");if(n||(n=a()),!n.hasClass("fr-active")){t.popups.refresh("emoticons"),t.popups.setContainer("emoticons",t.$tb);var i=e.offset().left+e.outerWidth()/2,o=e.offset().top+(t.opts.toolbarBottom?10:e.outerHeight()-10);t.popups.show("emoticons",i,o,e.outerHeight())}}function i(){t.popups.hide("emoticons")}function a(){var e="";t.opts.toolbarInline&&t.opts.emoticonsButtons.length>0&&(e='<div class="fr-buttons fr-emoticons-buttons">'+t.button.buildList(t.opts.emoticonsButtons)+"</div>");var n={buttons:e,emoticons:o()},i=t.popups.create("emoticons",n);return t.tooltip.bind(i,".fr-emoticon"),i}function o(){for(var e="<div>",n=0;n<t.opts.emoticonsSet.length;n++)0!==n&&n%t.opts.emoticonsStep===0&&(e+="<br>"),e+='<span class="fr-command fr-emoticon" data-cmd="insertEmoticon" title="'+t.language.translate(t.opts.emoticonsSet[n].desc)+'" data-param1="'+t.opts.emoticonsSet[n].code+'">'+t.opts.emoticonsSet[n].code+"</span>";return e+="</div>"}function r(n){t.html.insert('<span class="fr-emoticon">'+n+"</span>"+e.FroalaEditor.MARKERS,!0)}function s(){t.popups.hide("emoticons"),t.toolbar.showInline()}function l(){t.events.on("html.get",function(n){for(var i=0;i<t.opts.emoticonsSet.length;i++){var a=t.opts.emoticonsSet[i],o=e("<div>").html(a.code).text();n=n.split(o).join(a.code)}return n});var n=function(){if(!t.selection.isCollapsed())return!1;var n=t.selection.element(),i=t.selection.endElement();if(e(n).hasClass("fr-emoticon"))return n;if(e(i).hasClass("fr-emoticon"))return i;var a=t.selection.ranges(0),o=a.startContainer;if(o.nodeType==Node.ELEMENT_NODE&&o.childNodes.length>0&&a.startOffset>0){var r=o.childNodes[a.startOffset-1];if(e(r).hasClass("fr-emoticon"))return r}return!1};t.events.on("keydown",function(i){if(t.keys.isCharacter(i.which)&&t.selection.inEditor()){var a=t.selection.ranges(0),o=n();o&&(0===a.startOffset?e(o).before(e.FroalaEditor.MARKERS+e.FroalaEditor.INVISIBLE_SPACE):e(o).after(e.FroalaEditor.INVISIBLE_SPACE+e.FroalaEditor.MARKERS),t.selection.restore())}}),t.events.on("keyup",function(){for(var n=t.$el.get(0).querySelectorAll(".fr-emoticon"),i=0;i<n.length;i++)"undefined"!=typeof n[i].textContent&&0===n[i].textContent.replace(/\u200B/gi,"").length&&e(n[i]).remove()})}return{_init:l,insert:r,showEmoticonsPopup:n,hideEmoticonsPopup:i,back:s}},e.FroalaEditor.DefineIcon("emoticons",{NAME:"smile-o"}),e.FroalaEditor.RegisterCommand("emoticons",{title:"Emoticons",undo:!1,focus:!0,refreshOnCallback:!1,popup:!0,callback:function(){this.popups.isVisible("emoticons")?(this.$el.find(".fr-marker")&&(this.events.disableBlur(),this.selection.restore()),this.popups.hide("emoticons")):this.emoticons.showEmoticonsPopup()}}),e.FroalaEditor.RegisterCommand("insertEmoticon",{callback:function(e,t){this.emoticons.insert(t),this.emoticons.hideEmoticonsPopup()}}),e.FroalaEditor.DefineIcon("emoticonsBack",{NAME:"arrow-left"}),e.FroalaEditor.RegisterCommand("emoticonsBack",{title:"Back",undo:!1,focus:!1,back:!0,refreshAfterCallback:!1,callback:function(){this.emoticons.back()}})});