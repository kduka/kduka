!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):"object"==typeof module&&module.exports?module.exports=function(t,n){return void 0===n&&(n="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(n)}:e(window.jQuery)}(function(e){e.extend(e.FE.POPUP_TEMPLATES,{"link.edit":"[_BUTTONS_]","link.insert":"[_BUTTONS_][_INPUT_LAYER_]"}),e.extend(e.FE.DEFAULTS,{linkEditButtons:["linkOpen","linkStyle","linkEdit","linkRemove"],linkInsertButtons:["linkBack","|","linkList"],linkAttributes:{},linkAutoPrefix:"http://",linkStyles:{"fr-green":"Green","fr-strong":"Thick"},linkMultipleStyles:!0,linkConvertEmailAddress:!0,linkAlwaysBlank:!1,linkAlwaysNoFollow:!1,linkList:[{text:"Froala",href:"https://froala.com",target:"_blank"},{text:"Google",href:"https://google.com",target:"_blank"},{displayText:"Facebook",href:"https://facebook.com"}],linkText:!0}),e.FE.PLUGINS.link=function(t){function n(){var n=t.image?t.image.get():null;if(!n&&t.$wp){var i=t.selection.ranges(0).commonAncestorContainer;if(i&&(i.contains&&i.contains(t.el)||!t.el.contains(i)||t.el==i)&&(i=null),i&&"A"===i.tagName)return i;var r=t.selection.element(),l=t.selection.endElement();return"A"==r.tagName||t.node.isElement(r)||(r=e(r).parentsUntil(t.$el,"a:first").get(0)),"A"==l.tagName||t.node.isElement(l)||(l=e(l).parentsUntil(t.$el,"a:first").get(0)),l&&(l.contains&&l.contains(t.el)||!t.el.contains(l)||t.el==l)&&(l=null),r&&(r.contains&&r.contains(t.el)||!t.el.contains(r)||t.el==r)&&(r=null),l&&l==r&&"A"==l.tagName?r:null}return"A"==t.el.tagName?t.el:n&&n.get(0).parentNode&&"A"==n.get(0).parentNode.tagName?n.get(0).parentNode:void 0}function i(){var e=t.image?t.image.get():null,n=[];if(e)"A"==e.get(0).parentNode.tagName&&n.push(e.get(0).parentNode);else{var i,r,l,a;if(t.win.getSelection){var s=t.win.getSelection();if(s.getRangeAt&&s.rangeCount){a=t.doc.createRange();for(var o=0;o<s.rangeCount;++o)if(i=s.getRangeAt(o),r=i.commonAncestorContainer,r&&1!=r.nodeType&&(r=r.parentNode),r&&"a"==r.nodeName.toLowerCase())n.push(r);else{l=r.getElementsByTagName("a");for(var p=0;p<l.length;++p)a.selectNodeContents(l[p]),a.compareBoundaryPoints(i.END_TO_START,i)<1&&a.compareBoundaryPoints(i.START_TO_END,i)>-1&&n.push(l[p])}}}else if(t.doc.selection&&"Control"!=t.doc.selection.type)if(i=t.doc.selection.createRange(),r=i.parentElement(),"a"==r.nodeName.toLowerCase())n.push(r);else{l=r.getElementsByTagName("a"),a=t.doc.body.createTextRange();for(var f=0;f<l.length;++f)a.moveToElementText(l[f]),a.compareEndPoints("StartToEnd",i)>-1&&a.compareEndPoints("EndToStart",i)<1&&n.push(l[f])}}return n}function r(i){if(t.core.hasFocus()){if(a(),i&&"keyup"===i.type&&(i.altKey||i.which==e.FE.KEYCODE.ALT))return!0;setTimeout(function(){if(!i||i&&(1==i.which||"mouseup"!=i.type)){var r=n(),a=t.image?t.image.get():null;if(r&&!a){if(t.image){var s=t.node.contents(r);if(1==s.length&&"IMG"==s[0].tagName){var o=t.selection.ranges(0);return 0===o.startOffset&&0===o.endOffset?e(r).before(e.FE.MARKERS):e(r).after(e.FE.MARKERS),t.selection.restore(),!1}}i&&i.stopPropagation(),l(r)}}},t.helpers.isIOS()?100:0)}}function l(n){var i=t.popups.get("link.edit");i||(i=s());var r=e(n);t.popups.isVisible("link.edit")||t.popups.refresh("link.edit"),t.popups.setContainer("link.edit",t.$sc);var l=r.offset().left+e(n).outerWidth()/2,a=r.offset().top+r.outerHeight();t.popups.show("link.edit",l,a,r.outerHeight())}function a(){t.popups.hide("link.edit")}function s(){var e="";t.opts.linkEditButtons.length>1&&("A"==t.el.tagName&&t.opts.linkEditButtons.indexOf("linkRemove")>=0&&t.opts.linkEditButtons.splice(t.opts.linkEditButtons.indexOf("linkRemove"),1),e='<div class="fr-buttons">'+t.button.buildList(t.opts.linkEditButtons)+"</div>");var i={buttons:e},r=t.popups.create("link.edit",i);return t.$wp&&t.events.$on(t.$wp,"scroll.link-edit",function(){n()&&t.popups.isVisible("link.edit")&&l(n())}),r}function o(){}function p(){var i=t.popups.get("link.insert"),r=n();if(r){var l,a,s=e(r),o=i.find('input.fr-link-attr[type="text"]'),p=i.find('input.fr-link-attr[type="checkbox"]');for(l=0;l<o.length;l++)a=e(o[l]),a.val(s.attr(a.attr("name")||""));for(p.prop("checked",!1),l=0;l<p.length;l++)a=e(p[l]),s.attr(a.attr("name"))==a.data("checked")&&a.prop("checked",!0);i.find('input.fr-link-attr[type="text"][name="text"]').val(s.text())}else i.find('input.fr-link-attr[type="text"]').val(""),i.find('input.fr-link-attr[type="checkbox"]').prop("checked",!1),i.find('input.fr-link-attr[type="text"][name="text"]').val(t.selection.text());i.find("input.fr-link-attr").trigger("change"),(t.image?t.image.get():null)?i.find('.fr-link-attr[name="text"]').parent().hide():i.find('.fr-link-attr[name="text"]').parent().show()}function f(){var e=t.$tb.find('.fr-command[data-cmd="insertLink"]'),n=t.popups.get("link.insert");if(n||(n=d()),!n.hasClass("fr-active"))if(t.popups.refresh("link.insert"),t.popups.setContainer("link.insert",t.$tb||t.$sc),e.is(":visible")){var i=e.offset().left+e.outerWidth()/2,r=e.offset().top+(t.opts.toolbarBottom?10:e.outerHeight()-10);t.popups.show("link.insert",i,r,e.outerHeight())}else t.position.forSelection(n),t.popups.show("link.insert")}function d(e){if(e)return t.popups.onRefresh("link.insert",p),t.popups.onHide("link.insert",o),!0;var i="";t.opts.linkInsertButtons.length>=1&&(i='<div class="fr-buttons">'+t.button.buildList(t.opts.linkInsertButtons)+"</div>");var r='<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="10" height="10" viewBox="0 0 32 32"><path d="M27 4l-15 15-7-7-5 5 12 12 20-20z" fill="#FFF"></path></svg>',l="",a=0;l='<div class="fr-link-insert-layer fr-layer fr-active" id="fr-link-insert-layer-'+t.id+'">',l+='<div class="fr-input-line"><input id="fr-link-insert-layer-url-'+t.id+'" name="href" type="text" class="fr-link-attr" placeholder="URL" tabIndex="'+ ++a+'"></div>',t.opts.linkText&&(l+='<div class="fr-input-line"><input id="fr-link-insert-layer-text-'+t.id+'" name="text" type="text" class="fr-link-attr" placeholder="'+t.language.translate("Text")+'" tabIndex="'+ ++a+'"></div>');for(var s in t.opts.linkAttributes)if(t.opts.linkAttributes.hasOwnProperty(s)){var f=t.opts.linkAttributes[s];l+='<div class="fr-input-line"><input name="'+s+'" type="text" class="fr-link-attr" placeholder="'+t.language.translate(f)+'" tabIndex="'+ ++a+'"></div>'}t.opts.linkAlwaysBlank||(l+='<div class="fr-checkbox-line"><span class="fr-checkbox"><input name="target" class="fr-link-attr" data-checked="_blank" type="checkbox" id="fr-link-target-'+t.id+'" tabIndex="'+ ++a+'"><span>'+r+'</span></span><label for="fr-link-target-'+t.id+'">'+t.language.translate("Open in new tab")+"</label></div>"),l+='<div class="fr-action-buttons"><button class="fr-command fr-submit" role="button" data-cmd="linkInsert" href="#" tabIndex="'+ ++a+'" type="button">'+t.language.translate("Insert")+"</button></div></div>";var d={buttons:i,input_layer:l},u=t.popups.create("link.insert",d);return t.$wp&&t.events.$on(t.$wp,"scroll.link-insert",function(){(t.image?t.image.get():null)&&t.popups.isVisible("link.insert")&&b(),n&&t.popups.isVisible("link.insert")&&v()}),u}function u(){var i=n(),r=t.image?t.image.get():null;if(!1===t.events.trigger("link.beforeRemove",[i]))return!1;r&&i?(r.unwrap(),t.image.edit(r)):i&&(t.selection.save(),e(i).replaceWith(e(i).html()),t.selection.restore(),a())}function c(){t.events.on("keyup",function(t){t.which!=e.FE.KEYCODE.ESC&&r(t)}),t.events.on("window.mouseup",r),t.events.$on(t.$el,"click","a",function(e){t.edit.isDisabled()&&e.preventDefault()}),t.helpers.isMobile()&&t.events.$on(t.$doc,"selectionchange",r),d(!0),"A"==t.el.tagName&&t.$el.addClass("fr-view"),t.events.on("toolbar.esc",function(){if(t.popups.isVisible("link.edit"))return t.events.disableBlur(),t.events.focus(),!1},!0)}function k(n){var i,r,l=t.opts.linkList[n],a=t.popups.get("link.insert"),s=a.find('input.fr-link-attr[type="text"]'),o=a.find('input.fr-link-attr[type="checkbox"]');for(r=0;r<s.length;r++)i=e(s[r]),l[i.attr("name")]?i.val(l[i.attr("name")]):"text"!=i.attr("name")&&i.val("");for(r=0;r<o.length;r++)i=e(o[r]),i.prop("checked",i.data("checked")==l[i.attr("name")]);t.accessibility.focusPopup(a)}function g(){var n,i,r=t.popups.get("link.insert"),l=r.find('input.fr-link-attr[type="text"]'),a=r.find('input.fr-link-attr[type="checkbox"]'),s=l.filter('[name="href"]').val(),o=l.filter('[name="text"]').val(),p={};for(i=0;i<l.length;i++)n=e(l[i]),["href","text"].indexOf(n.attr("name"))<0&&(p[n.attr("name")]=n.val());for(i=0;i<a.length;i++)n=e(a[i]),n.is(":checked")?p[n.attr("name")]=n.data("checked"):p[n.attr("name")]=n.data("unchecked")||null;var f=t.helpers.scrollTop();m(s,o,p),e(t.o_win).scrollTop(f)}function h(){if(!t.selection.isCollapsed()){t.selection.save();for(var n=t.$el.find(".fr-marker").addClass("fr-unprocessed").toArray();n.length;){var i=e(n.pop());i.removeClass("fr-unprocessed");var r=t.node.deepestParent(i.get(0));if(r){var l=i.get(0),a="",s="";do{l=l.parentNode,t.node.isBlock(l)||(a+=t.node.closeTagString(l),s=t.node.openTagString(l)+s)}while(l!=r);var o=t.node.openTagString(i.get(0))+i.html()+t.node.closeTagString(i.get(0));i.replaceWith('<span id="fr-break"></span>');var p=r.outerHTML;p=p.replace(/<span id="fr-break"><\/span>/g,a+o+s),r.outerHTML=p}n=t.$el.find(".fr-marker.fr-unprocessed").toArray()}t.html.cleanEmptyTags(),t.selection.restore()}}function m(l,a,s){if(void 0===s&&(s={}),!1===t.events.trigger("link.beforeInsert",[l,a,s]))return!1;var o=t.image?t.image.get():null;o||"A"==t.el.tagName?"A"==t.el.tagName&&t.$el.focus():(t.selection.restore(),t.popups.hide("link.insert"));var p=l;t.opts.linkConvertEmailAddress&&e.FE.MAIL_REGEX.test(l)&&!/^mailto:.*/i.test(l)&&(l="mailto:"+l);var f=/^([A-Za-z]:(\\){1,2}|[A-Za-z]:((\\){1,2}[^\\]+)+)(\\)?$/i;if(""===t.opts.linkAutoPrefix||new RegExp("^("+e.FE.LinkProtocols.join("|")+"):.","i").test(l)||/^data:image.*/i.test(l)||/^(https?:|ftps?:|file:|)\/\//i.test(l)||f.test(l)||["/","{","[","#","("].indexOf((l||"")[0])<0&&(l=t.opts.linkAutoPrefix+l),l=t.helpers.sanitizeURL(l),t.opts.linkAlwaysBlank&&(s.target="_blank"),t.opts.linkAlwaysNoFollow&&(s.rel="nofollow"),"_blank"==s.target?s.rel?s.rel+=" noopener noreferrer":s.rel="noopener noreferrer":null==s.target&&(s.rel?s.rel=s.rel.replace(/noopener/,"").replace(/noreferrer/,""):s.rel=null),a=a||"",l===t.opts.linkAutoPrefix)return t.popups.get("link.insert").find('input[name="href"]').addClass("fr-error"),t.events.trigger("link.bad",[p]),!1;var d,u=n();if(u)d=e(u),d.attr("href",l),a.length>0&&d.text()!=a&&!o&&d.text(a),o||d.prepend(e.FE.START_MARKER).append(e.FE.END_MARKER),d.attr(s),o||t.selection.restore();else{o?o.wrap('<a href="'+l+'"></a>'):(t.format.remove("a"),t.selection.isCollapsed()?(a=0===a.length?p:a,t.html.insert('<a href="'+l+'">'+e.FE.START_MARKER+a+e.FE.END_MARKER+"</a>"),t.selection.restore()):a.length>0&&a!=t.selection.text().replace(/\n/g,"")?(t.selection.remove(),t.html.insert('<a href="'+l+'">'+e.FE.START_MARKER+a+e.FE.END_MARKER+"</a>"),t.selection.restore()):(h(),t.format.apply("a",{href:l})));for(var c=i(),k=0;k<c.length;k++)d=e(c[k]),d.attr(s),d.removeAttr("_moz_dirty");1==c.length&&t.$wp&&!o&&(e(c[0]).prepend(e.FE.START_MARKER).append(e.FE.END_MARKER),t.selection.restore())}if(o){var g=t.popups.get("link.insert");g&&g.find("input:focus").blur(),t.image.edit(o)}else r()}function v(){a();var i=n();if(i){var r=t.popups.get("link.insert");r||(r=d()),t.popups.isVisible("link.insert")||(t.popups.refresh("link.insert"),t.selection.save(),t.helpers.isMobile()&&(t.events.disableBlur(),t.$el.blur(),t.events.enableBlur())),t.popups.setContainer("link.insert",t.$sc);var l=(t.image?t.image.get():null)||e(i),s=l.offset().left+l.outerWidth()/2,o=l.offset().top+l.outerHeight();t.popups.show("link.insert",s,o,l.outerHeight())}}function E(){(t.image?t.image.get():null)?t.image.back():(t.events.disableBlur(),t.selection.restore(),t.events.enableBlur(),n()&&t.$wp?(t.selection.restore(),a(),r()):"A"==t.el.tagName?(t.$el.focus(),r()):(t.popups.hide("link.insert"),t.toolbar.showInline()))}function b(){var e=t.image?t.image.get():null;if(e){var n=t.popups.get("link.insert");n||(n=d()),p(!0),t.popups.setContainer("link.insert",t.$sc);var i=e.offset().left+e.outerWidth()/2,r=e.offset().top+e.outerHeight();t.popups.show("link.insert",i,r,e.outerHeight())}}function y(i,l,a){void 0===a&&(a=t.opts.linkMultipleStyles),void 0===l&&(l=t.opts.linkStyles);var s=n();if(!s)return!1;if(!a){var o=Object.keys(l);o.splice(o.indexOf(i),1),e(s).removeClass(o.join(" "))}e(s).toggleClass(i),r()}return{_init:c,remove:u,showInsertPopup:f,usePredefined:k,insertCallback:g,insert:m,update:v,get:n,allSelected:i,back:E,imageLink:b,applyStyle:y}},e.FE.DefineIcon("insertLink",{NAME:"link"}),e.FE.RegisterShortcut(e.FE.KEYCODE.K,"insertLink",null,"K"),e.FE.RegisterCommand("insertLink",{title:"Insert Link",undo:!1,focus:!0,refreshOnCallback:!1,popup:!0,callback:function(){this.popups.isVisible("link.insert")?(this.$el.find(".fr-marker").length&&(this.events.disableBlur(),this.selection.restore()),this.popups.hide("link.insert")):this.link.showInsertPopup()},plugin:"link"}),e.FE.DefineIcon("linkOpen",{NAME:"external-link"}),e.FE.RegisterCommand("linkOpen",{title:"Open Link",undo:!1,refresh:function(e){this.link.get()?e.removeClass("fr-hidden"):e.addClass("fr-hidden")},callback:function(){var e=this.link.get();e&&this.o_win.open(e.href)},plugin:"link"}),e.FE.DefineIcon("linkEdit",{NAME:"edit"}),e.FE.RegisterCommand("linkEdit",{title:"Edit Link",undo:!1,refreshAfterCallback:!1,popup:!0,callback:function(){this.link.update()},refresh:function(e){this.link.get()?e.removeClass("fr-hidden"):e.addClass("fr-hidden")},plugin:"link"}),e.FE.DefineIcon("linkRemove",{NAME:"unlink"}),e.FE.RegisterCommand("linkRemove",{title:"Unlink",callback:function(){this.link.remove()},refresh:function(e){this.link.get()?e.removeClass("fr-hidden"):e.addClass("fr-hidden")},plugin:"link"}),e.FE.DefineIcon("linkBack",{NAME:"arrow-left"}),e.FE.RegisterCommand("linkBack",{title:"Back",undo:!1,focus:!1,back:!0,refreshAfterCallback:!1,callback:function(){this.link.back()},refresh:function(e){var t=this.link.get()&&this.doc.hasFocus();(this.image?this.image.get():null)||t||this.opts.toolbarInline?(e.removeClass("fr-hidden"),e.next(".fr-separator").removeClass("fr-hidden")):(e.addClass("fr-hidden"),e.next(".fr-separator").addClass("fr-hidden"))},plugin:"link"}),e.FE.DefineIcon("linkList",{NAME:"search"}),e.FE.RegisterCommand("linkList",{title:"Choose Link",type:"dropdown",focus:!1,undo:!1,refreshAfterCallback:!1,html:function(){for(var e='<ul class="fr-dropdown-list" role="presentation">',t=this.opts.linkList,n=0;n<t.length;n++)e+='<li role="presentation"><a class="fr-command" tabIndex="-1" role="option" data-cmd="linkList" data-param1="'+n+'">'+(t[n].displayText||t[n].text)+"</a></li>";return e+="</ul>"},callback:function(e,t){this.link.usePredefined(t)},plugin:"link"}),e.FE.RegisterCommand("linkInsert",{focus:!1,refreshAfterCallback:!1,callback:function(){this.link.insertCallback()},refresh:function(e){this.link.get()?e.text(this.language.translate("Update")):e.text(this.language.translate("Insert"))},plugin:"link"}),e.FE.DefineIcon("imageLink",{NAME:"link"}),e.FE.RegisterCommand("imageLink",{title:"Insert Link",undo:!1,focus:!1,popup:!0,callback:function(){this.link.imageLink()},refresh:function(e){var t;this.link.get()?(t=e.prev(),t.hasClass("fr-separator")&&t.removeClass("fr-hidden"),e.addClass("fr-hidden")):(t=e.prev(),t.hasClass("fr-separator")&&t.addClass("fr-hidden"),e.removeClass("fr-hidden"))},plugin:"link"}),e.FE.DefineIcon("linkStyle",{NAME:"magic"}),e.FE.RegisterCommand("linkStyle",{title:"Style",type:"dropdown",html:function(){var e='<ul class="fr-dropdown-list" role="presentation">',t=this.opts.linkStyles;for(var n in t)t.hasOwnProperty(n)&&(e+='<li role="presentation"><a class="fr-command" tabIndex="-1" role="option" data-cmd="linkStyle" data-param1="'+n+'">'+this.language.translate(t[n])+"</a></li>");return e+="</ul>"},callback:function(e,t){this.link.applyStyle(t)},refreshOnShow:function(t,n){var i=this.link.get();if(i){var r=e(i);n.find(".fr-command").each(function(){var t=e(this).data("param1"),n=r.hasClass(t);e(this).toggleClass("fr-active",n).attr("aria-selected",n)})}},plugin:"link"})});