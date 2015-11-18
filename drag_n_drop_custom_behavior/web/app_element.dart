@HtmlImport('app_element.html')
library drag_n_drop.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'drag_me.dart';

/// [DragMe]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property String message;

  void ready() {
    new PolymerDom(this.root).querySelectorAll('[bwu-drop-target]').forEach((dom.Element e) {
      e.on['bwu-drag-enter'].listen((dom.Event event) => (event.target as dom.Element).classes.add('bwu-drag-over'));
      e.on['bwu-drag-leave'].listen((dom.Event event) => (event.target as dom.Element).classes.remove('bwu-drag-over'));
      e.on['bwu-drag-drop'].listen((dom.Event event) => (event.target as dom.Element).classes.add('bwu-drag-dropped'));
    });
  }

  @reflectable
  void trackHandler(dom.CustomEvent event, [_]) {
    print(event.type);
  }

    @reflectable
  void mouseOverHandler(dom.CustomEvent event, [_]) {

  }
}
