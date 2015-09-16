@HtmlImport('app_element.html')
library iron_list.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart' /*hide Foo*/;
//import 'package:polymer_elements/iron_list.dart';
//import 'foo.dart';

/// [IronList]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created() {
//    data = _createData();
  }

//  @property(observer: 'selectedxChanged')
//  var selectedx;

//  Map<int, Foo> _createData() {
//    int index = 0;
//    return new Map.fromIterable(
//        <Foo>[new Foo('alpha'), new Foo('beta'), new Foo('gamma')],
//        key: (e) => index++,
//        value: (e) => e);
//  }

  @property
  List<Map> data = jsValue([
    {'index': 0, 'item': {'name': 'a'}},
    {'index': 1, 'item': {'name': 'b'}},
    {'index': 2, 'item': {'name': 'c'}},
    {'index': 3, 'item': {'name': 'd'}},
  ]);

//  selectedxChanged(oldVal, newVal) {
//    print(newVal);
//  }

  @eventHandler
  void activateHandler(dom.CustomEvent e) {
    print(e.detail.data);
  }
}
