!function(e){"function"==typeof define&&define.amd?module.exports=function(t,n){return void 0===n&&(n="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(n),n}:e(jQuery)}(function(e){"use strict";e.extend(e.FroalaEditor.DEFAULTS,{charCounterMax:-1,charCounterCount:!0}),e.FroalaEditor.PLUGINS.charCounter=function(t){function n(){return t.$el.text().length}function r(e){if(t.opts.charCounterMax<0)return!0;if(n()<t.opts.charCounterMax)return!0;var r=e.which;return!(!t.keys.ctrlKey(e)&&t.keys.isCharacter(r))||(e.preventDefault(),e.stopPropagation(),t.events.trigger("charCounter.exceeded"),!1)}function o(r){return t.opts.charCounterMax<0?r:e("<div>").html(r).text().length+n()<=t.opts.charCounterMax?r:(t.events.trigger("charCounter.exceeded"),"")}function a(){if(t.opts.charCounterCount){var e=n()+(t.opts.charCounterMax>0?"/"+t.opts.charCounterMax:"");i.text(e),t.opts.toolbarBottom&&i.css("margin-bottom",t.$tb.outerHeight(!0));var r=t.$wp.get(0).offsetWidth-t.$wp.get(0).clientWidth;r>0&&("rtl"==t.opts.direction?i.css("margin-left",r):i.css("margin-right",r))}}function u(){return!(!t.$wp||!t.opts.charCounterCount)&&(i=e('<span class="fr-counter"></span>'),t.$box.append(i),t.events.on("keydown",r,!0),t.events.on("paste.afterCleanup",o),t.events.on("keyup",a),t.events.on("contentChanged",a),t.events.on("charCounter.update",a),a(),void t.events.on("destroy",function(){e(t.original_window).off("resize.char"+t.id),i.removeData().remove()}))}var i;return{_init:u}}});